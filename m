Return-Path: <rtc-linux+bncBDS7HNEFSALRBZFR5WYAKGQE4BWSAJQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hs5si437596wib.1.2015.10.11.23.53.24
        for <rtc-linux@googlegroups.com>;
        Sun, 11 Oct 2015 23:53:24 -0700 (PDT)
Date: Mon, 12 Oct 2015 08:53:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: at91rm9200: clear RTC alarm status flag
 prior to suspending
Message-ID: <20151012065323.GA3558@piout.net>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Wenyou,

On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> This patch is to clear the RTC alarm status flag prior to suspending
> to avoid the erroneous wake-up activity.
> 

Is this a new issue appearing with the sama5d2 or was it present from
the beginning?

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
>  drivers/rtc/rtc-at91rm9200.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index cb62e21..b60fd47 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -495,6 +495,8 @@ static int at91_rtc_suspend(struct device *dev)
>  	/* this IRQ is shared with DBGU and other hardware which isn't
>  	 * necessarily doing PM like we are...
>  	 */
> +	at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
> +
>  	at91_rtc_imr = at91_rtc_read_imr()
>  			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
>  	if (at91_rtc_imr) {
> -- 
> 1.7.9.5
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
