Return-Path: <rtc-linux+bncBDS7HNEFSALRBRUURS3QKGQEGRJH3BQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g81si143571wmi.3.2016.03.11.10.11.17
        for <rtc-linux@googlegroups.com>;
        Fri, 11 Mar 2016 10:11:17 -0800 (PST)
Date: Fri, 11 Mar 2016 19:11:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: pcf2127: conver to use regmap
Message-ID: <20160311181111.GC4620@piout.net>
References: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
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

That is nice to see interest in those RTCs. Do you plan to submit more
RTC drivers? How many do you have? :)

One small comment as I didn't have time to read the datasheet.

On 12/03/2016 at 01:22:14 +0900, Akinobu Mita wrote :
> @@ -228,16 +200,113 @@ static const struct of_device_id pcf2127_of_match[] = {
>  MODULE_DEVICE_TABLE(of, pcf2127_of_match);
>  #endif
>  
> -static struct i2c_driver pcf2127_driver = {
> +static int pcf2127_i2c_write(void *context, const void *data, size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_master_send(client, data, count);
> +	if (ret != count)
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +static int pcf2127_i2c_gather_write(void *context,
> +				const void *reg, size_t reg_size,
> +				const void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +	void *buf;
> +
> +	if (WARN_ON(reg_size != 1))
> +		return -EINVAL;
> +
> +	buf = kmalloc(val_size + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy(buf, reg, 1);
> +	memcpy(buf + 1, val, val_size);
> +
> +	ret = i2c_master_send(client, buf, val_size + 1);
> +	if (ret != val_size + 1)
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +static int pcf2127_i2c_read(void *context, const void *reg, size_t reg_size,
> +				void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +
> +	if (WARN_ON(reg_size != 1))
> +		return -EINVAL;
> +
> +	ret = i2c_master_send(client, reg, 1);
> +	if (ret != 1)
> +		return ret < 0 ? ret : -EIO;
> +
> +	ret = i2c_master_recv(client, val, val_size);
> +	if (ret != val_size)
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_bus pcf2127_i2c_regmap = {
> +	.write = pcf2127_i2c_write,
> +	.gather_write = pcf2127_i2c_gather_write,
> +	.read = pcf2127_i2c_read,
> +};

Do I understand correctly that you have to define that because
regmap_i2c_gather_write doesn't do the right thing for this device?


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
