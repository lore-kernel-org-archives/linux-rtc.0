Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45325 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753284AbdHTVMI (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 20 Aug 2017 17:12:08 -0400
Subject: Re: [RFC 2/3] rtc: Add Realtek RTD1295
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de> <20170820154017.GD24150@lunn.ch>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <5b607c23-92f9-a466-fd1c-92189177f174@suse.de>
Date: Sun, 20 Aug 2017 23:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170820154017.GD24150@lunn.ch>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 20.08.2017 um 17:40 schrieb Andrew Lunn:
>> +static void rtd119x_rtc_set_enabled(struct device *dev, bool enable)
>> +{
>> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
>> +	u32 val;
>> +
>> +	val = readl_relaxed(data->base + RTD_RTCEN);
>> +	dev_info(dev, "%s: rtcen = 0x%08x\n", __func__, val);
> 
> dev_dbg()?
> 
>> +static int rtd119x_rtc_open(struct device *dev)
>> +{
>> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(data->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = readl_relaxed(data->base + RTD_RTCACR);
>> +	dev_info(dev, "rtcacr = 0x%08x\n", val);
> 
> dev_dbg()?

Yeah, either that or dropping them altogether.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
