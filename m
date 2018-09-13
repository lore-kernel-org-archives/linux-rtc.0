Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:53082 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeINAk3 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 13 Sep 2018 20:40:29 -0400
Date: Thu, 13 Sep 2018 21:29:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 5/5] rtc: pcf85063: external capacitor configuration
Message-ID: <20180913192924.GK14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180907193508.24974-6-sam@ravnborg.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/09/2018 21:35:08+0200, Sam Ravnborg wrote:
> From: Søren Andersen <san@skov.dk>
> 
> Add support for specifying the quartz load in the DT node.
> The pcf85063 may use either a 7 pF or an 12.5 pF xtal.
> If the rtc has the wrong configuration the time will
> drift several hours/week.
> 
> If nothing is specified in DT then the factory default of 7 pF is used.
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 283c2335b01b..38163446664f 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -27,6 +27,7 @@
>  */
>  
>  #define PCF85063_REG_CTRL1		0x00 /* status */
> +#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
>  #define PCF85063_REG_CTRL1_STOP		BIT(5)
>  #define PCF85063_REG_CTRL2		0x01
>  
> @@ -180,6 +181,31 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
>  	.set_time	= pcf85063_rtc_set_time
>  };
>  
> +static int pcf85063_select_capacitance(struct i2c_client *client)
> +{
> +	int rc;
> +	u8 reg;
> +
> +	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "Failing to read Control1 reg\n");
> +		return -EIO;
> +	}
> +
> +	if (device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))
> +		reg = rc |= PCF85063_REG_CTRL1_CAP_SEL;
> +	else
> +		reg = rc &= ~PCF85063_REG_CTRL1_CAP_SEL;

That one is more straight forward, set it to the value from DT or leave
it alone.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
