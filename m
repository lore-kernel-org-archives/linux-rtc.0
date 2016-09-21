Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCGRRO7QKGQESIUQHNI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w16si1581629wmd.0.2016.09.21.13.07.36
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Sep 2016 13:07:36 -0700 (PDT)
Date: Wed, 21 Sep 2016 22:07:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH v4 1/2] rtc-cmos: Clear ACPI-driven alarms
 upon resume
Message-ID: <20160921200735.nqvs33topaaeq7fv@piout.net>
References: <20160919231244.6775-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160919231244.6775-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Thank you for your perseverance.

On 20/09/2016 at 01:12:43 +0200, Gabriele Mazzotta wrote :
> Currently ACPI-driven alarms are not cleared when they wake the
> system. As consequence, expired alarms must be manually cleared to
> program a new alarm. Fix this by correctly handling ACPI-driven
> alarms.
> 
> More specifically, the ACPI specification [1] provides for two
> alternative implementations of the RTC. Depending on the
> implementation, the driver either clear the alarm from the resume
> callback or from ACPI interrupt handler:
> 
>  - The platform has the RTC wakeup status fixed in hardware
>    (ACPI_FADT_FIXED_RTC is 0). In this case the driver can determine
>    if the RTC was the reason of the wakeup from the resume callback
>    by reading the RTC status register.
> 
>  - The platform has no fixed hardware feature event bits. In this
>    case a GPE is used to wake the system and the driver clears the
>    alarm from its handler.
> 
> [1] http://www.acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Applied, with the following cosmetic change:
@@ -982,13 +982,11 @@ static u32 rtc_handler(void *context)
 {
        struct device *dev = context;
        struct cmos_rtc *cmos = dev_get_drvdata(dev);
-       unsigned char rtc_control;
+       unsigned char rtc_control = 0;
        unsigned char rtc_intr;
 
        spin_lock_irq(&rtc_lock);
-       if (!cmos_rtc.suspend_ctrl)
-               rtc_control = cmos_rtc.suspend_ctrl;
-       else
+       if (cmos_rtc.suspend_ctrl)
                rtc_control = CMOS_READ(RTC_CONTROL);
        if (rtc_control & RTC_AIE) {
                cmos_rtc.suspend_ctrl &= ~RTC_AIE;



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
