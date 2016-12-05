Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6MOS3BAKGQET2HILRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l66si50985wml.0.2016.12.05.07.27.53
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Dec 2016 07:27:53 -0800 (PST)
Date: Mon, 5 Dec 2016 16:27:52 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 4/4] rtc: mcp795: use bcd2bin/bin2bcd.
Message-ID: <20161205152752.btnbja25daxn2dha@piout.net>
References: <cover.1480939487.git.emilbart@gmail.com>
 <1c3a3f47c0316b2bf02e762d0990de1aab23d828.1480939487.git.emilbart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1c3a3f47c0316b2bf02e762d0990de1aab23d828.1480939487.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/12/2016 at 14:11:53 +0100, Emil Bartczak wrote :
> Change rtc-mcp795.c to use the bcd2bin/bin2bcd functions.
> ---
>  drivers/rtc/rtc-mcp795.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> index c9ad46c..1d823f9 100644
> --- a/drivers/rtc/rtc-mcp795.c
> +++ b/drivers/rtc/rtc-mcp795.c
> @@ -22,6 +22,7 @@
>  #include <linux/rtc.h>
>  #include <linux/of.h>
>  #include <linux/delay.h>
> +#include <linux/bcd.h>
>  
>  /* MCP795 Instructions, see datasheet table 3-1 */
>  #define MCP795_EEREAD		0x03
> @@ -137,7 +138,6 @@ static int mcp795_start_oscillator(struct device *dev)
>  
>  static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
>  {
> -	int month;

You just introduced this variable to fix a bug. Maybe it was not necessary?


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
