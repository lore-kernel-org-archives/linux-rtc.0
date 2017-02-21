Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBLNFWPCQKGQEC723NCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 14si1227418wmn.2.2017.02.21.15.52.13
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 15:52:13 -0800 (PST)
Date: Wed, 22 Feb 2017 00:52:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv2] rtc: cpcap: new rtc driver
Message-ID: <20170221235212.hik3whcytw6xyevd@piout.net>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170221061650.12636-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170221061650.12636-1-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

The patch has a few checkpatch issues. Some of those should really be
fixed. Can you do that?

Else, it is mostly fine, a few comments below.

On 21/02/2017 at 07:16:50 +0100, Sebastian Reichel wrote:
> +static int cpcap_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct cpcap_rtc *rtc;
> +	struct cpcap_time cpcap_tm;
> +	int ret = 0;
> +
> +	rtc = dev_get_drvdata(dev);
> +
> +	rtc2cpcap_time(&cpcap_tm, tm);
> +
> +	if (rtc->alarm_enabled)
> +		disable_irq(rtc->alarm_irq);
> +	if (rtc->update_enabled)
> +		disable_irq(rtc->update_irq);
> +
> +	if (rtc->vendor == CPCAP_VENDOR_ST) {
> +		/* The TOD1 and TOD2 registers MUST be written in this order
> +		 * for the change to properly set. */

Does this mean there is a race condition?

> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> +					  TOD1_MASK, cpcap_tm.tod1);
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD2,
> +					  TOD2_MASK, cpcap_tm.tod2);
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_DAY,
> +					  DAY_MASK, cpcap_tm.day);
> +	} else {
> +		/* Clearing the upper lower 8 bits of the TOD guarantees that
> +		 * the upper half of TOD (TOD2) will not increment for 0xFF RTC
> +		 * ticks (255 seconds).  During this time we can safely write
> +		 * to DAY, TOD2, then TOD1 (in that order) and expect RTC to be
> +		 * synchronized to the exact time requested upon the final write
> +		 * to TOD1. */
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> +					  TOD1_MASK, 0);
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_DAY,
> +					  DAY_MASK, cpcap_tm.day);
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD2,
> +					  TOD2_MASK, cpcap_tm.tod2);
> +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> +					  TOD1_MASK, cpcap_tm.tod1);
> +	}
> +

> +	err = cpcap_get_vendor(dev, rtc->regmap, &rtc->vendor);
I think this means it depends on the mfd tree.

> +	if (err)
> +		return err;
> +
> +	rtc->alarm_irq= platform_get_irq(pdev, 0);
> +	err = devm_request_threaded_irq(dev, rtc->alarm_irq, NULL,
> +					cpcap_rtc_alarm_irq, IRQ_NONE,
> +					"rtc_alarm", rtc);
> +	if (err) {
> +		dev_err(dev, "Could not request alarm irq: %d\n", err);
> +		return err;
> +	}
> +	disable_irq(rtc->alarm_irq);
> +
> +	rtc->update_irq= platform_get_irq(pdev, 1);
> +	err = devm_request_threaded_irq(dev, rtc->update_irq, NULL,
> +					cpcap_rtc_update_irq, IRQ_NONE,
> +					"rtc_1hz", rtc);
I don't think this IRQ is actually useful. It doesn't really harm but
the tests should pass without it.

> +	if (err) {
> +		dev_err(dev, "Could not request update irq: %d\n", err);
> +		return err;
> +	}
> +	disable_irq(rtc->update_irq);
> +
> +	err = device_init_wakeup(dev, 1);

If you use device_init_wakeup, I think it needs to be called before
devm_rtc_device_register() to properly work.


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
