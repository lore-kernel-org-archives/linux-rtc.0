Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSEGS3BAKGQE2OL3CYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si35481wmd.3.2016.12.05.07.10.00
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Dec 2016 07:10:00 -0800 (PST)
Date: Mon, 5 Dec 2016 16:09:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/4] rtc: mcp795: fix invalid month setting.
Message-ID: <20161205150959.gx5ccrfcvb5an7lx@piout.net>
References: <cover.1480939487.git.emilbart@gmail.com>
 <9d5792a4e183cdea55accd6747b55f54d9e9d6aa.1480939487.git.emilbart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <9d5792a4e183cdea55accd6747b55f54d9e9d6aa.1480939487.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 05/12/2016 at 14:11:50 +0100, Emil Bartczak wrote :
> The 10 month register was always set to value 0 in the RTC hardware.
> Due to the bug month November or December became February.

All your patches are missing your SoB, see Developer's Certificate of
Origin 1.1 in Documentation/SubmittingPatches

> ---
>  drivers/rtc/rtc-mcp795.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> index 4021fd0..266328b 100644
> --- a/drivers/rtc/rtc-mcp795.c
> +++ b/drivers/rtc/rtc-mcp795.c
> @@ -29,7 +29,7 @@
>  #define MCP795_EEWREN	0x06
>  #define MCP795_SRREAD	0x05
>  #define MCP795_SRWRITE	0x01
> -#define MCP795_READ		0x13
> +#define MCP795_READ	0x13

Unrelated change

>  #define MCP795_WRITE	0x12
>  #define MCP795_UNLOCK	0x14
>  #define MCP795_IDWRITE	0x32
> @@ -39,6 +39,7 @@
>  
>  #define MCP795_ST_BIT	0x80
>  #define MCP795_24_BIT	0x40
> +#define MCP795_LP_BIT	0x20
>  
>  static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
>  {
> @@ -108,7 +109,8 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
>  	data[1] = (data[1] & 0x80) | ((tim->tm_min / 10) << 4) | (tim->tm_min % 10);
>  	data[2] = ((tim->tm_hour / 10) << 4) | (tim->tm_hour % 10);
>  	data[4] = ((tim->tm_mday / 10) << 4) | ((tim->tm_mday) % 10);
> -	data[5] = (data[5] & 0x10) | (tim->tm_mon / 10) | (tim->tm_mon % 10);
> +	data[5] = (data[5] & MCP795_LP_BIT) |

You changed 0x10 in MCP795_LP_BIT which you defined as 0x20, is that
right?

This is also an unrelated change.

> +			((tim->tm_mon / 10) << 4) | (tim->tm_mon % 10);
>  
>  	if (tim->tm_year > 100)
>  		tim->tm_year -= 100;
> @@ -137,11 +139,11 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
>  	if (ret)
>  		return ret;
>  
> -	tim->tm_sec		= ((data[0] & 0x70) >> 4) * 10 + (data[0] & 0x0f);
> -	tim->tm_min		= ((data[1] & 0x70) >> 4) * 10 + (data[1] & 0x0f);
> +	tim->tm_sec	= ((data[0] & 0x70) >> 4) * 10 + (data[0] & 0x0f);
> +	tim->tm_min	= ((data[1] & 0x70) >> 4) * 10 + (data[1] & 0x0f);
>  	tim->tm_hour	= ((data[2] & 0x30) >> 4) * 10 + (data[2] & 0x0f);
>  	tim->tm_mday	= ((data[4] & 0x30) >> 4) * 10 + (data[4] & 0x0f);
> -	tim->tm_mon		= ((data[5] & 0x10) >> 4) * 10 + (data[5] & 0x0f);
> +	tim->tm_mon	= ((data[5] & 0x10) >> 4) * 10 + (data[5] & 0x0f);

All those whitespace changes are actually confusing. Please do them in a
separate patch or in your last patch.

>  	tim->tm_year	= ((data[6] & 0xf0) >> 4) * 10 + (data[6] & 0x0f) + 100; /* Assume we are in 20xx */
>  
>  	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d %02d:%02d:%02d\n",
> -- 
> 2.7.4
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
