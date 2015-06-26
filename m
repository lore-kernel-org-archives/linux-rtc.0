Return-Path: <rtc-linux+bncBCAJFDXE4QGBBTGVWOWAKGQE2HK3OHY@googlegroups.com>
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com. [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id p9si29169wiz.3.2015.06.25.23.01.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 23:01:48 -0700 (PDT)
Received: by mail-wg0-x232.google.com with SMTP id x7so6200324wgj.2
        for <rtc-linux@googlegroups.com>; Thu, 25 Jun 2015 23:01:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150614223747.GB17679@piout.net>
References: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
	<1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
	<20150614223747.GB17679@piout.net>
Date: Fri, 26 Jun 2015 14:01:48 +0800
Message-ID: <CAHKZfL1+qi=OV6cO=KVzvVV52tD554U6USSSa9cwHbpAS6TobA@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v2 1/2] rtc-cmos: Clear interrupt flag if
 alarm time is
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>, Egbert Eich <eich@suse.com>, Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

>>
>> -static struct cmos_rtc       cmos_rtc;
>> +static struct cmos_rtc       cmos_rtc = { .alarm_expires = 0 };
>>
>
> That is probably unnecessary as the whole struct is already zeroed at
> initialization.
>

Yes. Good catch. Will keep the original code.

>> +     if (cmos->alarm_expires > (t_now + 1))
>> +             return -EBUSY;
>> +     else if (cmos->alarm_expires == (t_now + 1))
>> +             msleep(1000);
>
> I'm not too happy about that one second wait. Isn't the idea of
> updating the alarm to a value in the past to cancel it working?
>

Updating the alarm to the past value can cancel it working.
I've verified it on my local machine and the issue goes away.
Thanks for the suggestion.

>>  static int cmos_suspend(struct device *dev)
>> @@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
>>       struct device *dev = &pnp->dev;
>>       struct cmos_rtc *cmos = dev_get_drvdata(dev);
>>
>> -     if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
>> -             return;
>> +     if (system_state == SYSTEM_POWER_OFF) {
>> +             cmos_poweroff(dev);
>
> You should test the return value of cmos_poweroff() at some point as the
> return is depending on it in the original code.
>

Yes, agreed.

> However, I'm not sure why one would want to not execute
> cmos_do_shutdown() only when CONFIG_PM is not defined.
>

I have the same question about this one. BTW, cmos_do_shutdown()
is not executed when CONFIG_PM is defined.


I created the following patch based on your suggestion. Does it looks good
to you? If it does, I'll prepare v3 for testing. Thanks in advance.

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index a82556a..f8900aa 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -51,6 +51,7 @@ struct cmos_rtc {
        struct device           *dev;
        int                     irq;
        struct resource         *iomem;
+       time64_t                alarm_expires;

        void                    (*wake_on)(struct device *);
        void                    (*wake_off)(struct device *);
@@ -377,6 +378,8 @@ static int cmos_set_alarm(struct device *dev,
struct rtc_wkalrm *t)

        spin_unlock_irq(&rtc_lock);

+       cmos->alarm_expires = rtc_tm_to_time64(&t->time);
+
        return 0;
 }

@@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device *dev)
        cmos->dev = NULL;
 }

+static int cmos_aie_poweroff(struct device *dev)
+{
+       struct cmos_rtc *cmos = dev_get_drvdata(dev);
+       struct rtc_time now;
+       time64_t t_now;
+       int retval = 0;
+       unsigned char rtc_control;
+
+       if (!cmos->alarm_expires)
+               return -EINVAL;
+
+       spin_lock_irq(&rtc_lock);
+       rtc_control = CMOS_READ(RTC_CONTROL);
+       spin_unlock_irq(&rtc_lock);
+
+       /* We only care about the situation where AIE is disabled. */
+       if (rtc_control & RTC_AIE)
+               return -EBUSY;
+
+       cmos_read_time(dev, &now);
+       t_now = rtc_tm_to_time64(&now);
+
+       /*
+        * When enabling "RTC wake-up" in BIOS setup, the machine reboots
+        * automatically right after shutdown on some buggy boxes.
+        * This automatic rebooting issue won't happen when the alarm
+        * time is larger than now+1 seconds.
+        *
+        * If the alarm time is equal to now+1 seconds, the issue can be
+        * prevented by cancelling the alarm.
+        */
+       if (cmos->alarm_expires == t_now + 1) {
+               struct rtc_wkalrm alarm;
+               int err;
+
+               /* Cancel the AIE timer by configuring the past time. */
+               rtc_time64_to_tm(t_now - 1, &alarm.time);
+               alarm.enabled = 0;
+               retval = cmos_set_alarm(dev, &alarm);
+       } else if (cmos->alarm_expires > t_now + 1) {
+               retval = -EBUSY;
+       }
+
+       return retval;
+}
+
 #ifdef CONFIG_PM

 static int cmos_suspend(struct device *dev)
@@ -1094,8 +1143,12 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
        struct device *dev = &pnp->dev;
        struct cmos_rtc *cmos = dev_get_drvdata(dev);

-       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
-               return;
+       if (system_state == SYSTEM_POWER_OFF) {
+               int retval = cmos_poweroff(dev);
+
+               if (cmos_aie_poweroff(dev) < 0 && !retval)
+                       return;
+       }

        cmos_do_shutdown(cmos->irq);
 }
@@ -1200,8 +1253,12 @@ static void cmos_platform_shutdown(struct
platform_device *pdev)
        struct device *dev = &pdev->dev;
        struct cmos_rtc *cmos = dev_get_drvdata(dev);

-       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
-               return;
+       if (system_state == SYSTEM_POWER_OFF) {
+               int retval = cmos_poweroff(dev);
+
+               if (cmos_aie_poweroff(dev) < 0 && !retval)
+                       return;
+       }

        cmos_do_shutdown(cmos->irq);
 }
--
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
