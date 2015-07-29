Return-Path: <rtc-linux+bncBC4IFTUFXEFBBN7M4KWQKGQE4KGEGOQ@googlegroups.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com. [209.85.192.172])
        by gmr-mx.google.com with ESMTPS id ct6si4278786pdb.1.2015.07.29.04.17.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2015 04:17:11 -0700 (PDT)
Received: by mail-pd0-f172.google.com with SMTP id bh15so4396043pdb.1
        for <rtc-linux@googlegroups.com>; Wed, 29 Jul 2015 04:17:11 -0700 (PDT)
Date: Wed, 29 Jul 2015 19:17:00 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in
 init flow
Message-ID: <20150729111700.GA12912@leoy-linaro>
References: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
 <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Linus,

On Wed, Jul 29, 2015 at 11:08:30AM +0200, Linus Walleij wrote:
> On Wed, Jul 29, 2015 at 8:02 AM, Leo Yan <leo.yan@linaro.org> wrote:
> 
> > When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
> > the data register (DR) will read back as value zero. So the suspend
> > test code will set the match register (MR) for 10 seconds' timeout; But
> > there have chance later will read back some random values from DR
> > register; So finally miss with match value and will not trigger
> > waken up event anymore.
> >
> > This issue can be dismissed by reset registers in initialization flow;
> > And this code have no harm for ST's variant.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> I don't understand this...

Sorry for confusion. This issue is found when i use file
kernel/power/suspend_test.c to verify the system suspend. Before the
system suspend, the flow need set 10's alarm in RTC for waken up
event.

But what i observed the phenomenon is:

At the init phase:
RTC_LR = 0x0;
RTC_DR = 0x0;
RTC_MR = 0x0;

According to the timeout is 10s, the function *pl031_set_alarm()* will
set RTC_MR = 10; So usually RTC_DR will increase one for every second
and will trigger interrupt when RTC_DR equal to RTC_MR. But on
Hi6220, though the RTC_DR init value is zero, but very soon it will be
set a random value which is bigger than 10. So it will never match with
RTC_MR register anymore; finally the system cannot resume back due the
waken up event will not be triggered.

So suspect RTC_LR has not been initailized correctly and it will load
random value to RTC_DR. After reset the RTC_LR, this issue will be
fixed.

> > +       /* Init registers */
> > +       writel(0x0, ldata->base + RTC_LR);
> 
> This will reset the clock to jan 1st 1970 on every reboot.
> The idea is that the RTC should *preserve* the system time
> if you reboot the system, so NACK.
> 
> Usually userspace has a script using hwclock to read the
> system time from the rtc to system time with hwclock -s
> after userspace comes up. Likewise it writes it back with
> hwclock -w before rebooting.

This change is wrong.

> > +       writel(0x0, ldata->base + RTC_DR);
> 
> This is a read-only register in the PL031 clean variant.
> What do you want to achieve here? Is this register writeable
> on the HiSilicon?

Checked the manual, this register is RO. Will drop it.

> > +       writel(0x0, ldata->base + RTC_IMSC);
> 
> OK
> 
> > +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);
> 
> So why do we want to have the alarm enabled by
> default, before the kernel nor userspace has requested
> it?

This is to clear any pending interrupt, but not enable alarm.

> If your problem is with suspend/resume I suggest you work
> on the [runtime]_suspend/resume hooks instead of probe().
> Possibly you need to save/restore state across suspend/resume.

Do you think below change is make sense?

---8<---

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..c461e03 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -345,6 +345,10 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
 	dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
 
+	/* Init registers */
+	writel(0x0, ldata->base + RTC_IMSC);
+	writel(RTC_BIT_AI, ldata->base + RTC_ICR);
+
 	data = readl(ldata->base + RTC_CR);
 	/* Enable the clockwatch on ST Variants */
 	if (vendor->clockwatch)
@@ -368,6 +372,9 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 				writel(time, ldata->base + RTC_LR);
 			}
 		}
+	} else {
+		time = readl(ldata->base + RTC_DR);
+		writel(time, ldata->base + RTC_LR);
 	}
 
 	device_init_wakeup(&adev->dev, 1);

Thanks,
Leo Yan

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
