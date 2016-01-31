Return-Path: <rtc-linux+bncBDS7HNEFSALRBW7FW62QKGQEHJTRX4Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si134857wme.2.2016.01.31.03.41.15
        for <rtc-linux@googlegroups.com>;
        Sun, 31 Jan 2016 03:41:15 -0800 (PST)
Date: Sun, 31 Jan 2016 12:41:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 7/8] rtc: implement a sysfs interface for
 clock offset
Message-ID: <20160131114115.GJ20165@piout.net>
References: <0000-cover-letter.patch>
 <8361752a4e0c524e15cbed36d03eb3eb9b187815.1451929910.git.stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8361752a4e0c524e15cbed36d03eb3eb9b187815.1451929910.git.stillcompiling@gmail.com>
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

On 04/01/2016 at 10:31:25 -0800, Joshua Clayton wrote :
> The file is called "offset", and may be set and read in decimal.
> For rtcs that do not have read_offset or set_offset implemented,
> read always returns zero and write will return -EINVAL.
> 
Can you expand rtc_attr_is_visible() instead of having the offset file
always present?

Also, you need to expand Documentation/rtc.txt, section SYSFS INTERFACE.

I'm fine with having parts per billion as the unit and I hope we won't
ever need anything more precise :)

> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  drivers/rtc/interface.c |  2 +-
>  drivers/rtc/rtc-sysfs.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 57cd928..c064eb9 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -959,7 +959,7 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
>  		return -ENODEV;
>  
>  	if (!rtc->ops->set_offset) {
> -		offset = 0;
> +		*offset = 0;
>  		return 0;
>  	}

>  
> diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
> index 7273855..622a0dc 100644
> --- a/drivers/rtc/rtc-sysfs.c
> +++ b/drivers/rtc/rtc-sysfs.c
> @@ -211,6 +211,34 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(wakealarm);
>  
> +static ssize_t
> +offset_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	ssize_t retval;
> +	long offset;
> +
> +	retval = rtc_read_offset(to_rtc_device(dev), &offset);
> +	if (retval == 0)
> +		retval = sprintf(buf, "%ld\n", offset);
> +
> +	return retval;
> +}
> +
> +static ssize_t
> +offset_store(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t n)
> +{
> +	ssize_t retval;
> +	long offset;
> +
> +	retval = kstrtol(buf, 10, &offset);
> +	if (retval == 0)
> +		retval = rtc_set_offset(to_rtc_device(dev), offset);
> +
> +	return (retval < 0) ? retval : n;
> +}
> +static DEVICE_ATTR_RW(offset);
> +
>  static struct attribute *rtc_attrs[] = {
>  	&dev_attr_name.attr,
>  	&dev_attr_date.attr,
> @@ -219,6 +247,7 @@ static struct attribute *rtc_attrs[] = {
>  	&dev_attr_max_user_freq.attr,
>  	&dev_attr_hctosys.attr,
>  	&dev_attr_wakealarm.attr,
> +	&dev_attr_offset.attr,
>  	NULL,
>  };
>  

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
