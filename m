Return-Path: <rtc-linux+bncBDEKVJM7XAHRB5VQ5DFAKGQEFCIHZ3A@googlegroups.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com. [2607:f8b0:4003:c06::241])
        by gmr-mx.google.com with ESMTPS id c18si939269itb.2.2017.07.03.03.12.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 03:12:05 -0700 (PDT)
Received: by mail-oi0-x241.google.com with SMTP id n2so11286744oig.3
        for <rtc-linux@googlegroups.com>; Mon, 03 Jul 2017 03:12:05 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1497951359-13334-36-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org> <1497951359-13334-36-git-send-email-benjamin.gaignard@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 3 Jul 2017 12:12:05 +0200
Message-ID: <CAK8P3a1EL5wu8CmCCiqq3TMdFd58LZx_zsdEeEgx3tOrFc+2Pg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 35/51] rtc: pm8xxx: stop using rtc deprecated functions
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 20, 2017 at 11:35 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux@googlegroups.com
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/rtc/rtc-pm8xxx.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index fac8355..e6b52bd 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -81,7 +81,8 @@ struct pm8xxx_rtc {
>  static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>         int rc, i;
> -       unsigned long secs, irq_flags;
> +       unsigned long long secs;
> +       unsigned long irq_flags;

'secs' should be 'time64_t' here, which is signed.

>         u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0;
>         unsigned int ctrl_reg;
>         struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
> @@ -90,14 +91,14 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>         if (!rtc_dd->allow_set_time)
>                 return -EACCES;
>
> -       rtc_tm_to_time(tm, &secs);
> +       secs = rtc_tm_to_time64(tm);
>
>         for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
>                 value[i] = secs & 0xFF;
>                 secs >>= 8;
>         }
>
> -       dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
> +       dev_dbg(dev, "Seconds value to be written to RTC = %llu\n", secs);
>

However, note that you only write 32 bits here, since NUM_8_BIT_RTC_REGS
is set to '4'. Is that a hardware constant? If yes, it would be best to return
-EINVAL or -EOVERFLOW for out of range times.

I think should really try to come up with a way to set the policy for
overflows in
RTC drivers globally in this case. There are many drivers that take a 32-bit
unsigned value (and many others that don't), but a nicer policy for the long
run might be to define some kind of windowing where values before e.g.
year 2000 or 2017 are wrapped around and used as future dates.

Unfortunately, the downside of this is that any RTC that defaults to '0'
and is now interpreted as year 1970 would then be interpreted as a future
data that can not be represented in today's 32-bit time_t.

       Arnd

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
