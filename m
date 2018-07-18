Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:38430 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbeGRIB4 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 18 Jul 2018 04:01:56 -0400
Date: Wed, 18 Jul 2018 09:25:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] rtc: sysfs: facilitate attribute add to rtc device
Message-ID: <20180718072508.GG3211@piout.net>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-2-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180710090710.9066-2-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello,

On 10/07/2018 09:44:15+0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> This patches addresses following problem:
> rtc_allocate_device
> devm_device_add_group  <-- kernel oops / null pointer, because
> 			sysfs entry does not yet exist
> rtc_register_device
> rc = devm_device_add_group
> if (rc)
> 	return rc;     <-- forbidden to return error code
> 			after device register
> 
> In case groups were not yet registered (kobj.state_in_sysfs == 0)
> rtc_add_group just addes given group to dev.groups,
> otherwise it uses devm_device_add_group.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  drivers/rtc/rtc-core.h  |  6 ++++++
>  drivers/rtc/rtc-sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
> index 0abf98983e13..81d1c3ce7a96 100644
> --- a/drivers/rtc/rtc-core.h
> +++ b/drivers/rtc/rtc-core.h
> @@ -40,9 +40,15 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
> 
>  #ifdef CONFIG_RTC_INTF_SYSFS
>  const struct attribute_group **rtc_get_dev_attribute_groups(void);
> +int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
>  #else
>  static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
>  {
>  	return NULL;
>  }
> +static inline
> +int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
> +{
> +	return 0;
> +}
>  #endif
> diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
> index 454da38c6012..9a177b8f761b 100644
> --- a/drivers/rtc/rtc-sysfs.c
> +++ b/drivers/rtc/rtc-sysfs.c
> @@ -317,3 +317,42 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
>  {
>  	return rtc_attr_groups;
>  }
> +
> +static size_t rtc_group_count(struct rtc_device *rtc)
> +{

I don't feel this function is necessary, you can include it in __rtc_add_group

> +	const struct attribute_group **groups = rtc->dev.groups;
> +	size_t cnt = 0;
> +
> +	if (groups)
> +		for (; *groups; groups++)
> +			cnt++;
> +
> +	return cnt;
> +}
> +
> +static inline int
> +__rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
> +{
> +	size_t cnt = rtc_group_count(rtc);
> +	const struct attribute_group **groups, **old;
> +
> +	groups = devm_kzalloc(&rtc->dev, (cnt+2)*sizeof(*groups), GFP_KERNEL);

Please use devm_kcalloc

> +	if (IS_ERR_OR_NULL(groups))
> +		return PTR_ERR(groups);
> +	memcpy(groups, rtc->dev.groups, cnt*sizeof(*groups));
> +	groups[cnt] = grp;
> +
> +	old = rtc->dev.groups;
> +	rtc->dev.groups = groups;
> +	if (old != rtc_attr_groups)
> +		devm_kfree(&rtc->dev, old);
> +
> +	return 0;
> +}
> +
> +int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
> +{
> +	return rtc->dev.kobj.state_in_sysfs ?
> +		devm_device_add_group(&rtc->dev, grp) :
> +		__rtc_add_group(rtc, grp);

Using devm_device_add_group after RTC registration is racy and should
not be allowed. I would merge __rtc_add_group in rtc_add_group and
return an error if rtc->registered is true.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
