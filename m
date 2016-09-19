Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWGJQG7QKGQEG5OG3MY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 82si1618304wmg.3.2016.09.19.15.21.11
        for <rtc-linux@googlegroups.com>;
        Mon, 19 Sep 2016 15:21:11 -0700 (PDT)
Date: Tue, 20 Sep 2016 00:21:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH v3 1/2] rtc-cmos: Clear ACPI-driven alarms
 upon resume
Message-ID: <20160919222101.5jrgrormdyx5r2tf@piout.net>
References: <20160914190841.10684-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160914190841.10684-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Gabriele,

Thanks for your persistence! Both patches look good. Can you fix the
build issues reported by kbuild?

On 14/09/2016 at 21:08:40 +0200, Gabriele Mazzotta wrote :
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
>  drivers/rtc/rtc-cmos.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 1dec52f..6042257 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -939,6 +939,22 @@ static int cmos_resume(struct device *dev)
>  			tmp &= ~RTC_AIE;
>  			hpet_mask_rtc_irq_bit(RTC_AIE);
>  		} while (mask & RTC_AIE);
> +
> +		if ((tmp & RTC_AIE) &&
> +		    !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
> +			acpi_status status;
> +			acpi_event_status rtc_status;
> +
> +			status = acpi_get_event_status(ACPI_EVENT_RTC,
> +						       &rtc_status);
> +			if (ACPI_FAILURE(status)) {
> +				dev_err(dev, "Could not get RTC status\n");
> +			} else if (rtc_status & ACPI_EVENT_FLAG_SET) {
> +				tmp &= ~RTC_AIE;
> +				CMOS_WRITE(tmp, RTC_CONTROL);
> +				rtc_update_irq(cmos->rtc, 1, mask);
> +			}
> +		}
>  	}
>  	spin_unlock_irq(&rtc_lock);
>  
> @@ -976,6 +992,22 @@ static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
>  static u32 rtc_handler(void *context)
>  {
>  	struct device *dev = context;
> +	struct cmos_rtc *cmos = dev_get_drvdata(dev);
> +	unsigned char rtc_control;
> +	unsigned char rtc_intr;
> +
> +	spin_lock_irq(&rtc_lock);
> +	if (!cmos_rtc.suspend_ctrl)
> +		rtc_control = cmos_rtc.suspend_ctrl;
> +	else
> +		rtc_control = CMOS_READ(RTC_CONTROL);
> +	if (rtc_control & RTC_AIE) {
> +		cmos_rtc.suspend_ctrl &= ~RTC_AIE;
> +		CMOS_WRITE(rtc_control, RTC_CONTROL);
> +		rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
> +		rtc_update_irq(cmos->rtc, 1, rtc_intr);
> +	}
> +	spin_unlock_irq(&rtc_lock);
>  
>  	pm_wakeup_event(dev, 0);
>  	acpi_clear_event(ACPI_EVENT_RTC);
> -- 
> 2.9.3
> 

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
