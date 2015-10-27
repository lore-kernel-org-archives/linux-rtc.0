Return-Path: <rtc-linux+bncBDS7HNEFSALRBWEDYCYQKGQEIF5C6TI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id en3si601710wib.3.2015.10.27.15.59.36
        for <rtc-linux@googlegroups.com>;
        Tue, 27 Oct 2015 15:59:36 -0700 (PDT)
Date: Tue, 27 Oct 2015 23:59:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, k.kozlowski@samsung.com,
	mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Message-ID: <20151027225934.GL22331@piout.net>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 26/10/2015 at 18:21:22 +0530, Alim Akhtar wrote :
> RTC found in s2mps15 is almost same as one found in s2mps14.
> This patch add required changes to enable s2mps15 rtc timer.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

One really small nitpick below else you can add my
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-s5m.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> @@ -317,7 +319,8 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	u8 data[info->regs->regs_count];
>  	int ret;
>  
> -	if (info->device_type == S2MPS14X || info->device_type == S2MPS13X) {
> +	if (info->device_type == S2MPS14X || info->device_type == S2MPS15X ||
> +						info->device_type == S2MPS13X) {

This line is not properly aligned.

>  		ret = regmap_update_bits(info->regmap,
>  				info->regs->rtc_udr_update,
>  				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);

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
