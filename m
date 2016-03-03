Return-Path: <rtc-linux+bncBCC6ZWOPXENRBRNI4G3AKGQEOOL4IFQ@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w10si290942wmw.3.2016.03.03.07.12.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 07:12:05 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: pcf85063: remove struct pcf85063
Date: Thu, 3 Mar 2016 16:14:08 +0100
Cc: rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 linux-kernel@vger.kernel.org
References: <1456914343-4611-1-git-send-email-alexandre.belloni@free-electrons.com> <1456914343-4611-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1456914343-4611-2-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201603031614.08309.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday 02 March 2016 11:25:43 Alexandre Belloni wrote:
> No members of struct pcf85063 are used anymore, remove the whole structure.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 550f67518c5a..e8ddbb359d11 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -31,11 +31,6 @@
>
>  static struct i2c_driver pcf85063_driver;
>
> -struct pcf85063 {
> -	struct rtc_device *rtc;
> -	int voltage_low; /* indicates if a low_voltage was detected */
> -};
> -
>  static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
>  {
>  	s32 ret;
> @@ -168,25 +163,18 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
>  static int pcf85063_probe(struct i2c_client *client, 
>  				const struct i2c_device_id *id)
>  {
> -	struct pcf85063 *pcf85063;
> +	struct rtc_device *rtc;
>
>  	dev_dbg(&client->dev, "%s\n", __func__);
>
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
>
> -	pcf85063 = devm_kzalloc(&client->dev, sizeof(struct pcf85063),
> -				GFP_KERNEL);
> -	if (!pcf85063)
> -		return -ENOMEM;
> -
> -	i2c_set_clientdata(client, pcf85063);
> -
> -	pcf85063->rtc = devm_rtc_device_register(&client->dev,
> -				pcf85063_driver.driver.name,
> -				&pcf85063_rtc_ops, THIS_MODULE);
> +	rtc = devm_rtc_device_register(&client->dev,
> +				       pcf85063_driver.driver.name,
> +				       &pcf85063_rtc_ops, THIS_MODULE);
>
> -	return PTR_ERR_OR_ZERO(pcf85063->rtc);
> +	return PTR_ERR_OR_ZERO(rtc);
>  }
>
>  static const struct i2c_device_id pcf85063_id[] = {

Reviewed-by: Juergen Borleis <jbe@pengutronix.de>

jb
