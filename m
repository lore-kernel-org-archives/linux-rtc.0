Return-Path: <rtc-linux+bncBDS7HNEFSALRBQOL4W4AKGQE5TD52XY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 69si182889wmn.1.2016.04.21.16.44.01
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 16:44:01 -0700 (PDT)
Date: Fri, 22 Apr 2016 01:44:00 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Cc: lee.jones@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: add Cypress FM33256B RTC driver
Message-ID: <20160421234400.GG29844@piout.net>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-4-git-send-email-jlp@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461150471-23163-4-git-send-email-jlp@gomspace.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Looks mostly good, a few comments below

On 20/04/2016 at 13:07:51 +0200, Jeppe Ledet-Pedersen wrote :

Please always include a commit message.

> Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
> ---

[...]

> +static int fm33256b_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +	int ret;
> +	struct fm33256b_rtc *rtc = dev_get_drvdata(dev);
> +	uint8_t time[7];

Use u8 here

> +
> +	/* Lock time update */
> +	ret = regmap_update_bits(rtc->fm33256b->regmap_pc,
> +				 FM33256B_RTC_ALARM_CONTROL_REG,
> +				 FM33256B_R, FM33256B_R);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(rtc->fm33256b->regmap_pc,
> +			       FM33256B_SECONDS_REG, time, sizeof(time));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Unlock time update */
> +	ret = regmap_update_bits(rtc->fm33256b->regmap_pc,
> +				 FM33256B_RTC_ALARM_CONTROL_REG,
> +				 FM33256B_R, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	tm->tm_sec	= bcd2bin(time[0]);
> +	tm->tm_min	= bcd2bin(time[1]);
> +	tm->tm_hour	= bcd2bin(time[2]);
> +	tm->tm_wday	= bcd2bin(time[3]) - 1;
> +	tm->tm_mday	= bcd2bin(time[4]);
> +	tm->tm_mon	= bcd2bin(time[5]) - 1;
> +	tm->tm_year	= bcd2bin(time[6]);
> +
> +	if (tm->tm_year < 70)
> +		tm->tm_year += 100;
> +

I would advise against using that construct. It doesn't work well with
leap years and you probably don't care about dates before 2000.

> +	return rtc_valid_tm(tm);
> +}
> +
> +static int fm33256b_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	int ret;
> +	struct fm33256b_rtc *rtc = dev_get_drvdata(dev);
> +	uint8_t time[7];
> +

u8

> +	time[0] = bin2bcd(tm->tm_sec);
> +	time[1] = bin2bcd(tm->tm_min);
> +	time[2] = bin2bcd(tm->tm_hour);
> +	time[3] = bin2bcd(tm->tm_wday + 1);
> +	time[4] = bin2bcd(tm->tm_mday);
> +	time[5] = bin2bcd(tm->tm_mon + 1);
> +	time[6] = bin2bcd(tm->tm_year % 100);
> +

I would also prefer that you explicitly enforce the range of supported
years and return -EINVAL for out of range values.

> +	/* Unlock time update */
> +	ret = regmap_update_bits(rtc->fm33256b->regmap_pc,
> +				 FM33256B_RTC_ALARM_CONTROL_REG,
> +				 FM33256B_W, FM33256B_W);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_write(rtc->fm33256b->regmap_pc,
> +				FM33256B_SECONDS_REG, time, sizeof(time));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Lock time update */
> +	ret = regmap_update_bits(rtc->fm33256b->regmap_pc,
> +				 FM33256B_RTC_ALARM_CONTROL_REG,
> +				 FM33256B_W, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops fm33256b_rtc_ops = {
> +	.read_time	= fm33256b_rtc_readtime,
> +	.set_time	= fm33256b_rtc_settime,
> +};
> +
> +static int fm33256b_rtc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct fm33256b *fm33256b;
> +	struct fm33256b_rtc *rtc;
> +
> +	fm33256b = dev_get_drvdata(dev->parent);
> +
> +	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->fm33256b = fm33256b;
> +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, KBUILD_MODNAME,
> +					       &fm33256b_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc->rtcdev))
> +		return PTR_ERR(rtc->rtcdev);
> +
> +	return 0;

You can use PTR_ERR_OR_ZERO


> +}
> +
> +static int fm33256b_rtc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct fm33256b *fm33256b;
> +	struct fm33256b_rtc *rtc = platform_get_drvdata(pdev);
> +
> +	fm33256b = dev_get_drvdata(dev->parent);
> +
> +	devm_rtc_device_unregister(&pdev->dev, rtc->rtcdev);
> +
> +	return 0;
> +}
> +

The whole fm33256b_rtc_remove() is unnecessary.


> +static const struct of_device_id fm33256b_rtc_dt_ids[] = {
> +	{ .compatible = "cypress,fm33256b-rtc" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, fm33256b_rtc_dt_ids);
> +
> +static struct platform_driver fm33256b_rtc_driver = {
> +	.driver = {
> +		.name = "fm33256b-rtc",
> +		.of_match_table = fm33256b_rtc_dt_ids,
> +	},
> +	.probe = fm33256b_rtc_probe,
> +	.remove = fm33256b_rtc_remove,
> +};
> +module_platform_driver(fm33256b_rtc_driver);
> +
> +MODULE_ALIAS("platform:fm33256b-rtc");
> +MODULE_AUTHOR("Jeppe Ledet-Pedersen <jlp@gomspace.com>");
> +MODULE_DESCRIPTION("Cypress FM33256B Processor Companion RTC Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.4
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
