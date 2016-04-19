Return-Path: <rtc-linux+bncBDS7HNEFSALRBLXD3K4AKGQE27LN2EQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d92si247058wma.2.2016.04.19.15.31.10
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Apr 2016 15:31:10 -0700 (PDT)
Date: Wed, 20 Apr 2016 00:31:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, soren.brinkmann@xilinx.com,
	Michal Simek <michal.simek@xilinx.com>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
	Anirudha Sarangi <anirudh@xilinx.com>,
	Srikanth Vemula <svemula@xilinx.com>,
	Anurag Kumar Vulisha <anuragku@xilinx.com>
Subject: [rtc-linux] Re: [PATCH 3/3] RTC: Update seconds time programming logic
Message-ID: <20160419223109.GF29844@piout.net>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Hi,

Please use rtc: zynqmp in your subject line.

On 12/04/2016 at 17:45:46 +0530, Anurag Kumar Vulisha wrote :
> @@ -78,6 +85,17 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
>  
> +	/*
> +	 * Clear the rtc interrupt status register after setting the
> +	 * time. During a read_time function, the code should read the
> +	 * RTC_INT_STATUS register and if bit 0 is still 0, it means
> +	 * that one second has not elapsed yet since RTC was set and
> +	 * the current time should be read from SET_TIME_READ register;
> +	 * otherwise, CURRENT_TIME register is read to report the time
> +	 */
> +	writel(RTC_INT_SEC | RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_STS);

You probably shouldn't clear RTC_INT_ALRM here but it should be done in
the init and when enabling/disabling alarm. Or maybe easier would be to
ignore RTC_INT_ALRM in xlnx_rtc_interrupt when it is not set in
RTC_INT_MASK.

Or, instead of using interrupts, can't you simply read RTC_INT_STS in
xlnx_rtc_read_time()? Is it updated even when the interrupt is not
enabled?

> +	xrtcdev->time_updated = 0;
> +
>  	return 0;
>  }
>  
> @@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>  
> -	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> +	if (xrtcdev->time_updated == 0) {
> +		/*
> +		 * Time written in SET_TIME_WRITE has not yet updated into
> +		 * the seconds read register, so read the time from the
> +		 * SET_TIME_WRITE instead of CURRENT_TIME register.
> +		 */
> +		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD), tm);
> +		tm->tm_sec -= 1;
> +	} else {
> +		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> +	}
>  
>  	return rtc_valid_tm(tm);
>  }
> @@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
>  {
>  	u32 rtc_ctrl;
>  
> +	/* Enable RTC SEC interrupts */
> +	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
> +
>  	/* Enable RTC switch to battery when VCC_PSAUX is not available */
>  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
>  	rtc_ctrl |= RTC_BATT_EN;
> @@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
>  	/* Clear interrupt */
>  	writel(status, xrtcdev->reg_base + RTC_INT_STS);
>  
> -	if (status & RTC_INT_SEC)
> +	if (status & RTC_INT_SEC) {
> +		if (xrtcdev->time_updated == 0) {
> +			/* RTC updated the seconds read register */
> +			xrtcdev->time_updated = 1;
> +		}
>  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> +	}
>  	if (status & RTC_INT_ALRM)
>  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
>  
> -- 
> 2.1.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
