Return-Path: <rtc-linux+bncBDS7HNEFSALRBEPA2OZAKGQEK3LR2PY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d185si27998wmf.0.2015.11.24.15.17.36
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 15:17:36 -0800 (PST)
Date: Wed, 25 Nov 2015 00:17:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 5/9] rtc-pcf2123: put the chip reset into a function
Message-ID: <20151124231736.GF3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <dd040a11817f2caac1db13ec49c64f603013b982.1446587705.git.stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <dd040a11817f2caac1db13ec49c64f603013b982.1446587705.git.stillcompiling@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/11/2015 at 07:36:36 -0800, Joshua Clayton wrote :

A commit message, even when simple is mandatory.

> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  drivers/rtc/rtc-pcf2123.c | 64 ++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
> index 257ce7d..d3c1447 100644
> --- a/drivers/rtc/rtc-pcf2123.c
> +++ b/drivers/rtc/rtc-pcf2123.c
> @@ -260,6 +260,40 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> +static int pcf2123_reset(struct device *dev)
> +{
> +	int ret;
> +	u8  rxbuf[2];
> +
> +	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Stop the counter */
> +	dev_dbg(dev, "stopping RTC\n");
> +	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* See if the counter was actually stopped */
> +	dev_dbg(dev, "checking for presence of RTC\n");
> +	ret = pcf2123_read(dev, PCF2123_REG_CTRL1, rxbuf, sizeof(rxbuf));
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "received data from RTC (0x%02X 0x%02X)\n",
> +			rxbuf[0], rxbuf[1]);

This is not properly aligned (use checkpatch --strict)


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
