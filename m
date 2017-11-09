Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56464 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbdKIB1N (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 20:27:13 -0500
Date: Thu, 9 Nov 2017 02:26:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: Re: [PATCH v2 2/2] rtc: sprd: Add Spreadtrum RTC driver
Message-ID: <20171109012653.32zkqyh5p4jqhftr@piout.net>
References: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510132279.git.baolin.wang@spreadtrum.com>
 <6482283a3ae8c6ec35d0a7a078420151a69b8aca.1510132279.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6482283a3ae8c6ec35d0a7a078420151a69b8aca.1510132279.git.baolin.wang@spreadtrum.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 08/11/2017 at 17:16:15 +0800, Baolin Wang wrote:
> +static int sprd_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct sprd_rtc *rtc = dev_get_drvdata(dev);
> +	time64_t secs;
> +	int ret;
> +

I would have expected a check for SPRD_RTC_POWER_RESET_FLAG here.


> +	ret = sprd_rtc_get_secs(rtc, SPRD_RTC_TIME, &secs);
> +	if (ret)
> +		return ret;
> +
> +	rtc_time64_to_tm(secs, tm);
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int sprd_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct sprd_rtc *rtc = dev_get_drvdata(dev);
> +	time64_t secs = rtc_tm_to_time64(tm);
> +

And you need to reset SPRD_RTC_POWER_RESET_FLAG here

> +	return sprd_rtc_set_secs(rtc, SPRD_RTC_TIME, secs);
> +}
> +
-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
