Return-Path: <rtc-linux+bncBDS7HNEFSALRBGVA6WVQKGQEDWNMY5Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si335789wib.3.2015.06.14.02.57.46
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 02:57:46 -0700 (PDT)
Date: Sun, 14 Jun 2015 11:57:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [1/2] rtc: pcf8563: Refactor to use SMBUS api instead
 of raw I2C.
Message-ID: <20150614095744.GK3890@piout.net>
References: <20140724164306.23803.44546.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20140724164306.23803.44546.stgit@localhost>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Martin,

Do you mind rebasing that patch so that it can be applied?

Thanks!

On 24/07/2014 at 18:43:06 +0200, Martin Fuzzey wrote :
> This is simpler and supported by more bus drivers.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/rtc/rtc-pcf8563.c |   72 +++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 63b558c..88b5c99 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -69,6 +69,28 @@ struct pcf8563 {
>  	int voltage_low; /* incicates if a low_voltage was detected */
>  };
>  
> +static int  pcf8563_read_regs(struct i2c_client *client,
> +			const uint8_t first_reg,
> +			int num_regs, uint8_t *buf)
> +{
> +	s32 count;
> +
> +	count = i2c_smbus_read_i2c_block_data(client, first_reg, num_regs, buf);
> +
> +	if (count == num_regs)
> +		return 0;
> +
> +	if (count < 0) {
> +		dev_err(&client->dev, "%s: reg=%d err=%d\n", __func__,
> +				first_reg, count);
> +		return count;
> +	}
> +
> +	dev_err(&client->dev, "%s: partial reg=%d wanted=%d got=%d\n", __func__,
> +				first_reg, num_regs, count);
> +	return -EIO;
> +}
> +
>  /*
>   * In the routines that deal directly with the pcf8563 hardware, we use
>   * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -76,27 +98,12 @@ struct pcf8563 {
>  static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  {
>  	struct pcf8563 *pcf8563 = i2c_get_clientdata(client);
> -	unsigned char buf[13] = { PCF8563_REG_ST1 };
> -
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
> -
> -	/* read registers */
> -	if ((i2c_transfer(client->adapter, msgs, 2)) != 2) {
> -		dev_err(&client->dev, "%s: read error\n", __func__);
> -		return -EIO;
> -	}
> +	uint8_t buf[PCF8563_REG_YR + 1];
> +	int ret;
> +
> +	ret = pcf8563_read_regs(client, PCF8563_REG_ST1, sizeof(buf), buf);
> +	if (ret)
> +		return ret;
>  
>  	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV) {
>  		pcf8563->voltage_low = 1;
> @@ -144,8 +151,7 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  static int pcf8563_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>  {
>  	struct pcf8563 *pcf8563 = i2c_get_clientdata(client);
> -	int i, err;
> -	unsigned char buf[9];
> +	unsigned char buf[PCF8563_REG_YR + 1];
>  
>  	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
>  		"mday=%d, mon=%d, year=%d, wday=%d\n",
> @@ -170,21 +176,9 @@ static int pcf8563_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>  
>  	buf[PCF8563_REG_DW] = tm->tm_wday & 0x07;
>  
> -	/* write register's data */
> -	for (i = 0; i < 7; i++) {
> -		unsigned char data[2] = { PCF8563_REG_SC + i,
> -						buf[PCF8563_REG_SC + i] };
> -
> -		err = i2c_master_send(client, data, sizeof(data));
> -		if (err != sizeof(data)) {
> -			dev_err(&client->dev,
> -				"%s: err=%d addr=%02x, data=%02x\n",
> -				__func__, err, data[0], data[1]);
> -			return -EIO;
> -		}
> -	}
> -
> -	return 0;
> +	return i2c_smbus_write_i2c_block_data(client, PCF8563_REG_SC,
> +						sizeof(buf) - PCF8563_REG_SC,
> +						&buf[PCF8563_REG_SC]);
>  }
>  
>  #ifdef CONFIG_RTC_INTF_DEV
> @@ -248,7 +242,7 @@ static int pcf8563_probe(struct i2c_client *client,
>  
>  	dev_dbg(&client->dev, "%s\n", __func__);
>  
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -ENODEV;
>  
>  	pcf8563 = devm_kzalloc(&client->dev, sizeof(struct pcf8563),

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
