Return-Path: <rtc-linux+bncBDKZNNNLXAHBBEOLXPBAKGQEBAWZ2QI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wj0-f196.google.com (mail-wj0-f196.google.com. [209.85.210.196])
        by gmr-mx.google.com with ESMTPS id l66si2744434wml.0.2016.12.12.09.59.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 09:59:44 -0800 (PST)
Received: by mail-wj0-f196.google.com with SMTP id xy5so12779554wjc.1
        for <rtc-linux@googlegroups.com>; Mon, 12 Dec 2016 09:59:44 -0800 (PST)
Date: Mon, 12 Dec 2016 19:59:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: rtc-linux@googlegroups.com
Cc: Venkat Reddy Talla <vreddytalla@nvidia.com>, cw00.choi@samsung.com,
	krzk@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
	ldewangan@nvidia.com
Subject: Re: [rtc-linux] Re: [PATCH] rtc: max77683: avoid regmap bulk write
 for max77620
Message-ID: <20161212175940.GA7302@kozik-lap>
References: <1481543085-19540-1-git-send-email-vreddytalla@nvidia.com>
 <2080923.yQbi47FubE@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2080923.yQbi47FubE@amdc3058>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Dec 12, 2016 at 02:28:11PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > @@ -259,6 +262,32 @@ static const struct max77686_rtc_driver_data max77802_drv_data = {
> >  	.rtc_irq_chip = &max77802_rtc_irq_chip,
> >  };
> >  
> > +static inline int _regmap_bulk_write(struct max77686_rtc_info *info,
> 
> rtc_regmap_bulk_write?

I think max77686_regmap_bulk_write would be nice. This might still pop
somewhere in the backtrace so the prefix is useful.

> 
> > +		unsigned int reg, void *val, int len)
> > +{
> 
> Please keep arguments (except "info" one) in sync with regmap_bulk_write():
> 
> int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
> 		     size_t val_count)
> 
> > +	int ret = 0;
> > +
> > +	if (!info->drv_data->avoid_rtc_bulk_write) {
> > +		/* RTC registers support sequential writing */
> > +		ret = regmap_bulk_write(info->rtc_regmap, reg, val, len);
> > +	} else {
> > +		/* Power registers support register-data pair writing */
> 
> Hmn, maybe this can be handled be regmap_bulk_write() with proper
> regmap setting (map->bus == NULL?), can anyone with more regmap
> expertise comment on this?

Good catch. This does not look like a property of this device driver but
of the bus it is attached to.

Best regards,
Krzysztof

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
