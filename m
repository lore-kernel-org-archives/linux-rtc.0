Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBHHWSPAAKGQEZIL32AQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id p131si5256138vkf.1.2016.10.17.09.23.55
        for <rtc-linux@googlegroups.com>;
        Mon, 17 Oct 2016 09:23:56 -0700 (PDT)
Date: Mon, 17 Oct 2016 18:23:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mirza Krak <mirza.krak@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	Mirza Krak <mirza.krak@hostmobility.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: pcf85063: do not register a RTC
 device if chip is not present
Message-ID: <20161017161403.fkppk6fbvdjbp2lz@piout.net>
References: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 17/10/2016 at 15:53:31 +0200, Mirza Krak wrote :
> From: Mirza Krak <mirza.krak@hostmobility.com>
> 
> Add a sanity check to see if chip is present. If we can not communicate
> with the chip there is no point in registering a RTC device.
> 

Does it makes sense? If the device is not present, why has it been
registered in the first place?

> Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index efb0a08..a06dff9 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -191,12 +191,19 @@ static int pcf85063_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
>  	struct rtc_device *rtc;
> +	int err;
>  
>  	dev_dbg(&client->dev, "%s\n", __func__);
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
>  
> +	err = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
> +	if (err < 0) {
> +		dev_err(&client->dev, "RTC chip is not present\n");
> +		return err;
> +	}
> +
>  	rtc = devm_rtc_device_register(&client->dev,
>  				       pcf85063_driver.driver.name,
>  				       &pcf85063_rtc_ops, THIS_MODULE);
> -- 
> 2.1.4
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
