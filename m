Return-Path: <rtc-linux+bncBDZJXP7F6YLRBENRUS2AKGQEGUXG3OA@googlegroups.com>
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id 185si2322053wmn.0.2016.01.03.04.48.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 04:48:17 -0800 (PST)
Date: Sun, 3 Jan 2016 13:48:16 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
    Julia Lawall <julia.lawall@lip6.fr>
Subject: [rtc-linux] Re: [PATCH 7/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_interrupt()
In-Reply-To: <5688E229.4010400@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1601031348040.2053@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net> <5688DF2D.6090204@users.sourceforge.net> <5688E229.4010400@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 3 Jan 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 3 Jan 2016 09:00:30 +0100
> 
> Pass the address of the data structure element "time" directly in calls
> of the function "rtc_update_irq" instead of an extra initialisation
> for one local variable at the beginning.

Why is it better?

julia
 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/rtc/rtc-ab-b5ze-s3.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
> index e3a015a..88f1d0b 100644
> --- a/drivers/rtc/rtc-ab-b5ze-s3.c
> +++ b/drivers/rtc/rtc-ab-b5ze-s3.c
> @@ -816,7 +816,6 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
>  	struct i2c_client *client = data;
>  	struct device *dev = &client->dev;
>  	struct abb5zes3_rtc_data *rtc_data = dev_get_drvdata(dev);
> -	struct rtc_device *rtc = rtc_data->rtc;
>  	u8 regs[ABB5ZES3_CTRL_SEC_LEN];
>  	int ret, handled = IRQ_NONE;
>  
> @@ -844,8 +843,7 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
>  	/* Check alarm flag */
>  	if (regs[ABB5ZES3_REG_CTRL2] & ABB5ZES3_REG_CTRL2_AF) {
>  		dev_dbg(dev, "RTC alarm!\n");
> -
> -		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> +		rtc_update_irq(rtc_data->rtc, 1, RTC_IRQF | RTC_AF);
>  
>  		/* Acknowledge and disable the alarm */
>  		_abb5zes3_rtc_clear_alarm(dev);
> @@ -857,8 +855,7 @@ static irqreturn_t _abb5zes3_rtc_interrupt(int irq, void *data)
>  	/* Check watchdog Timer A flag */
>  	if (regs[ABB5ZES3_REG_CTRL2] & ABB5ZES3_REG_CTRL2_WTAF) {
>  		dev_dbg(dev, "RTC timer!\n");
> -
> -		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> +		rtc_update_irq(rtc_data->rtc, 1, RTC_IRQF | RTC_AF);
>  
>  		/*
>  		 * Acknowledge and disable the alarm. Note: WTAF
> -- 
> 2.6.3
> 
> 
