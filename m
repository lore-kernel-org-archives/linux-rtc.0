Return-Path: <rtc-linux+bncBDS7HNEFSALRBDNF3KZQKGQEKNNRS7A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si446123wmc.0.2015.12.20.03.35.41
        for <rtc-linux@googlegroups.com>;
        Sun, 20 Dec 2015 03:35:41 -0800 (PST)
Date: Sun, 20 Dec 2015 12:35:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 2/3] RTC/PCF85063: fix time/date reading (part II)
Message-ID: <20151220113540.GD3541@piout.net>
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
 <1449496174-7813-3-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449496174-7813-3-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 07/12/2015 at 14:49:33 +0100, Juergen Borleis wrote :
> Use the function to read the whole time/date register in one turn and now
> check if the RTC signals an invalid time/date (due to a battery power loss
> for example). In this case ignore the time/date until it is really set
> again.
> 
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> ---
>  drivers/rtc/rtc-pcf85063.c | 45 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 75f2866..abed934 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -22,6 +22,7 @@
>  #define PCF85063_REG_CTRL2		0x01
>  
>  #define PCF85063_REG_SC			0x04 /* datetime */
> +#define PCF85063_REG_SC_OS		0x80
>  #define PCF85063_REG_MN			0x05
>  #define PCF85063_REG_HR			0x06
>  #define PCF85063_REG_DM			0x07
> @@ -77,39 +78,31 @@ static int pcf85063_read_time(struct i2c_client *client, u8 *buf, u16 size)
>   */
>  static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  {
> +	int rc;
>  	struct pcf85063 *pcf85063 = i2c_get_clientdata(client);
> -	unsigned char buf[13] = { PCF85063_REG_CTRL1 };
> -	struct i2c_msg msgs[] = {
> -		{/* setup read ptr */
> -			.addr = client->addr,
> -			.len = 1,
> -			.buf = buf
> -		},
> -		{/* read status + date */
> -			.addr = client->addr,
> -			.flags = I2C_M_RD,
> -			.len = 13,
> -			.buf = buf
> -		},
> -	};
> +	u8 regs[7];
>  
> -	/* read registers */
> -	if ((i2c_transfer(client->adapter, msgs, 2)) != 2) {
> -		dev_err(&client->dev, "%s: read error\n", __func__);
> -		return -EIO;

Isn't that already reading the time and date register in one block? I'd
say you are simply reading less registers. Also, maybe you could use
i2c_smbus_read_block_data?


> +	rc = pcf85063_read_time(client, regs, sizeof(regs));
> +	if (rc < 0)
> +		return rc;
> +
> +	/* if the clock has lost its power it makes no sense to use its time */
> +	if (regs[0] & PCF85063_REG_SC_OS) {
> +		dev_warn(&client->dev, "Power loss detected, invalid time\n");
> +		return -EINVAL;
>  	}

That part is more useful and as I understand it is what you are trying
to fix.


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
