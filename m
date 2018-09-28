Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:56952 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1S2a (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 28 Sep 2018 14:28:30 -0400
Date: Fri, 28 Sep 2018 14:04:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: isl1208: access i2c client via rtc parent
Message-ID: <20180928120451.GR16644@piout.net>
References: <20180928114832.27383-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928114832.27383-1-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello,

On 28/09/2018 11:51:17+0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The move of atrim, dtrim usr sysfs properties from i2c device
> to rtc device require to access them via dev->parent.
> This patch also aligns timestamp0.
> 
> Fixes: 03df75dd03301307ec578ccd4e8c1c0117b8e65c
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index 15094df12985..ec5ef518a09b 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -517,7 +517,7 @@ static ssize_t timestamp0_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
>  {
> -	struct i2c_client *client = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
>  	int sr;
> 
>  	sr = isl1208_i2c_get_sr(client);
> @@ -539,7 +539,7 @@ static ssize_t timestamp0_store(struct device *dev,
>  static ssize_t timestamp0_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	struct i2c_client *client = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
>  	u8 regs[ISL1219_EVT_SECTION_LEN] = { 0, };
>  	struct rtc_time tm;
>  	int sr;
> @@ -649,7 +649,7 @@ static ssize_t
>  isl1208_sysfs_show_atrim(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> -	int atr = isl1208_i2c_get_atr(to_i2c_client(dev));
> +	int atr = isl1208_i2c_get_atr(to_i2c_client(dev->parent));
>  	if (atr < 0)
>  		return atr;
> 
> @@ -662,7 +662,7 @@ static ssize_t
>  isl1208_sysfs_show_dtrim(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> -	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev));
> +	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev->parent));

Oh right, I actually had that but somehow, I stashed the patch instead
of squashing it.

If that is fine for you, I'll fold that in the original patch (I'll ad
your SoB).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
