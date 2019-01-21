Return-Path: <SRS0=tSN2=P5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F62FC282F6
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB3220861
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j+EfVOEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfAUIjH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:39:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39870 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfAUIjH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Jan 2019 03:39:07 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190121083904euoutp01a303a0c92ac92404feaeabe28a1cf6f4~70FFQQNAw2666526665euoutp01V
        for <linux-rtc@vger.kernel.org>; Mon, 21 Jan 2019 08:39:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190121083904euoutp01a303a0c92ac92404feaeabe28a1cf6f4~70FFQQNAw2666526665euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548059944;
        bh=dSVbWKG9eYCZJgdPPlLA3ylRuXAavxKyGZTuNHt2cqU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=j+EfVOEGpoAZ19UMvWQvK/92ogKocdHskZKuKy+65h2UqYAspv4FK4hyLey41vf0v
         dxBiYd0yGfas30B12N5JNPYUb0rd+64QNykw6YVR8DlkKaMeiRxivV9gOxGyME37pP
         HOCXXe2Htc8zLXrqP/8dkgdirPmDiYWjk6PVfKWo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190121083903eucas1p163a7b9415b586700189ef25e41685e83~70FEgDPMc0317603176eucas1p1T;
        Mon, 21 Jan 2019 08:39:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 77.56.04806.725854C5; Mon, 21
        Jan 2019 08:39:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190121083902eucas1p14b1cbaef92936d7738ddd5dc69b23c12~70FDnEfn30318103181eucas1p1c;
        Mon, 21 Jan 2019 08:39:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190121083902eusmtrp1c2bb920cf831179fdd2f3ea630c27ade~70FDYrBk22656026560eusmtrp1n;
        Mon, 21 Jan 2019 08:39:02 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-1c-5c458527c7b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.9F.04128.625854C5; Mon, 21
        Jan 2019 08:39:02 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190121083902eusmtip219314608b270973599f62fe406fe7098~70FC8NvfC0697106971eusmtip2u;
        Mon, 21 Jan 2019 08:39:02 +0000 (GMT)
Subject: Re: [PATCH] rtc: s3c: Rewrite clock handling
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a2bbd0c1-826c-f55a-5c33-488794cf8574@samsung.com>
Date:   Mon, 21 Jan 2019 09:39:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119201702.GA3590@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7rqra4xBr+7ZCyWXLzKbtH+bhm7
        xcYZ61ktzp/fwG5xbPUVNosZ5/cxObB5zFtT7bFpVSebR9+WVYwe0+f9ZPL4vEkugDWKyyYl
        NSezLLVI3y6BK+PG2tvsBe/1Km4fUW5gPKbaxcjJISFgItG/8SMziC0ksIJR4ues8C5GLiD7
        C6PEszcz2CGcz4wSV18eZYPp6Lk4lxUisZxR4tiVY1BV7xklts9Yw9jFyMEhLGAqsX6tMkiD
        iICmxPW/38EamAWuMUpM7bjCBJJgEzCU6HrbBTaVV8BOYtPqLWBxFgFViQVtIDdxcIgKxEi0
        XuaCKBGUODnzCQuIzSmgJ7Hqw1KwcmYBeYntb+cwQ9jiEreezGcC2SUhsIpdov3kLUaIq10k
        Hi/tZ4GwhSVeHd/CDmHLSJye3MMC0dDMKNE+YxY7hNPDKLF1zg6on60lDh+/yApyETPQO+t3
        6UOEHSUm7mkDC0sI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2
        C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSef0v+NfdzDu+5N0
        iFGAg1GJh/fHPZcYIdbEsuLK3EOMEhzMSiK8r91dY4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        VjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUw7p//Ldr+79myR53tNSvzMngXsShFSZzY/MH/4a2v
        +7fc1/M4mvu/sfOWl3Roy+YfJpcmTt/jcYU3KkN2vcLKGbWSQY2b6u7r3drpsPVXs/nJWTd5
        5hyxTjipMzGNvzPnX//+pz/9JRqnOH40O/nGo5RrRc+60iI1b86nuQtipF7Nmp2WUDO/RIml
        OCPRUIu5qDgRAH00bwQ2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7pqra4xBpNPy1ssuXiV3aL93TJ2
        i40z1rNanD+/gd3i2OorbBYzzu9jcmDzmLem2mPTqk42j74tqxg9ps/7yeTxeZNcAGuUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaNtbfZC97r
        Vdw+otzAeEy1i5GTQ0LARKLn4lzWLkYuDiGBpYwSHYcPsEEkZCROTmtghbCFJf5c62KDKHrL
        KPH6zXGWLkYODmEBU4n1a5VBakQENCWu//0ONohZ4AajxOrjX6AatjJKbLx2hgWkik3AUKLr
        bRfYBl4BO4lNq7cwgdgsAqoSC9o+MoPYogIxErOe9LFD1AhKnJz5BKyXU0BPYtWHpWD1zALq
        En/mXWKGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJ
        ucWleel6yfm5mxiBkbbt2M8tOxi73gUfYhTgYFTi4f1xzyVGiDWxrLgy9xCjBAezkgjva3fX
        GCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaBvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFC
        AumJJanZqakFqUUwfUwcnFINjMb3HzD/u2B7nruzzaTN9fqf+3mXPCK0dDdyeZdX1xXM1GdV
        SV6wki2u34/FY6YiJ6/iz3deO1P0561YGlRrbmzKLaI0sW6TUvmcqouFaxdbmfUW7V9q9DKT
        7WLYw5nZ7l23msO4f2zv11nhvXabz+LG/R++nFWs1Y+fkZP3furbncukFcRYlFiKMxINtZiL
        ihMBpj0HysoCAAA=
X-CMS-MailID: 20190121083902eucas1p14b1cbaef92936d7738ddd5dc69b23c12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c
References: <CGME20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c@eucas1p2.samsung.com>
        <20190118132754.15660-1-m.szyprowski@samsung.com>
        <20190119201702.GA3590@kozik-lap>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Krzysztof,

On 2019-01-19 21:17, Krzysztof Kozlowski wrote:
> On Fri, Jan 18, 2019 at 02:27:54PM +0100, Marek Szyprowski wrote:
>> s3c_rtc_enable/disable_clk() functions were designed to be called multiple
>> times without reference counting, because they were initially used in
> s/used/used only/
> (if I understand correctly the logic)
>
>> alarm setting/clearing functions, which can be called both when alarm is
>> already set or not. Later however, calls to those functions have been added to
>> other places in the driver - like time and /proc reading callbacks, what
>> results in broken alarm if any of such events happens after the alarm has
>> been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
>> to rely on proper reference counting in clock core and move alarm enable
>> counter to s3c_rtc_setaie() function.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/rtc/rtc-s3c.c | 67 ++++++++++++++++++-------------------------
>>  1 file changed, 28 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
>> index 04c68178c42d..e682977b4f6e 100644
>> --- a/drivers/rtc/rtc-s3c.c
>> +++ b/drivers/rtc/rtc-s3c.c
>> @@ -39,7 +39,7 @@ struct s3c_rtc {
>>  	void __iomem *base;
>>  	struct clk *rtc_clk;
>>  	struct clk *rtc_src_clk;
>> -	bool clk_disabled;
>> +	bool alarm_enabled;
>>  
>>  	const struct s3c_rtc_data *data;
>>  
>> @@ -47,7 +47,7 @@ struct s3c_rtc {
>>  	int irq_tick;
>>  
>>  	spinlock_t pie_lock;
>> -	spinlock_t alarm_clk_lock;
>> +	spinlock_t alarm_lock;
> Maybe add short comment that it protects only "alarm_enabled" property?
>
>>  
>>  	int ticnt_save;
>>  	int ticnt_en_save;
>> @@ -70,44 +70,28 @@ struct s3c_rtc_data {
>>  
>>  static int s3c_rtc_enable_clk(struct s3c_rtc *info)
>>  {
>> -	unsigned long irq_flags;
>>  	int ret = 0;
>>  
>> -	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
>> +	ret = clk_enable(info->rtc_clk);
>> +	if (ret)
>> +		goto out;
> The out label is now empty so just "return ret". It is easier to read -
> no need to jump anywhere to see the simple return.
>
>>  
>> -	if (info->clk_disabled) {
>> -		ret = clk_enable(info->rtc_clk);
>> -		if (ret)
>> +	if (info->data->needs_src_clk) {
>> +		ret = clk_enable(info->rtc_src_clk);
>> +		if (ret) {
>> +			clk_disable(info->rtc_clk);
>>  			goto out;
>> -
>> -		if (info->data->needs_src_clk) {
>> -			ret = clk_enable(info->rtc_src_clk);
>> -			if (ret) {
>> -				clk_disable(info->rtc_clk);
>> -				goto out;
>> -			}
>>  		}
>> -		info->clk_disabled = false;
>>  	}
>> -
>>  out:
>> -	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
>> -
>>  	return ret;
>>  }
>>  
>>  static void s3c_rtc_disable_clk(struct s3c_rtc *info)
>>  {
>> -	unsigned long irq_flags;
>> -
>> -	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
>> -	if (!info->clk_disabled) {
>> -		if (info->data->needs_src_clk)
>> -			clk_disable(info->rtc_src_clk);
>> -		clk_disable(info->rtc_clk);
>> -		info->clk_disabled = true;
>> -	}
>> -	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
>> +	if (info->data->needs_src_clk)
>> +		clk_disable(info->rtc_src_clk);
>> +	clk_disable(info->rtc_clk);
>>  }
>>  
>>  /* IRQ Handlers */
>> @@ -135,6 +119,7 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
>>  static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>>  {
>>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>> +	unsigned long flags;
>>  	unsigned int tmp;
>>  	int ret;
>>  
>> @@ -151,17 +136,19 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>>  
>>  	writeb(tmp, info->base + S3C2410_RTCALM);
>>  
>> -	s3c_rtc_disable_clk(info);
>> +	spin_lock_irqsave(&info->alarm_lock, flags);
>>  
>> -	if (enabled) {
>> -		ret = s3c_rtc_enable_clk(info);
>> -		if (ret)
>> -			return ret;
>> -	} else {
>> +	if (info->alarm_enabled && !enabled)
>>  		s3c_rtc_disable_clk(info);
>> -	}
>> +	else if (!info->alarm_enabled && enabled)
>> +		ret = s3c_rtc_enable_clk(info);
>>  
>> -	return 0;
>> +	info->alarm_enabled = enabled;
>> +	spin_unlock_irqrestore(&info->alarm_lock, flags);
>> +
>> +	s3c_rtc_disable_clk(info);
>> +
>> +	return ret;
>>  }
>>  
>>  /* Set RTC frequency */
>> @@ -357,10 +344,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>>  
>>  	writeb(alrm_en, info->base + S3C2410_RTCALM);
>>  
>> -	s3c_rtc_disable_clk(info);
>> -
>>  	s3c_rtc_setaie(dev, alrm->enabled);
>>  
>> +	s3c_rtc_disable_clk(info);
> I do not understand this change - why do you have to move the disable
> clk? The s3c_rtc_setaie() takes care about clock enabling/disabling for
> the time of accessing registers.

This was micro optimization, s3c_rtc_setaie() increases clock enable
count, so by changing the call order we can avoid one disable/enable
sequence.

>> +
>>  	return 0;
>>  }
>>  
>> @@ -491,7 +478,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  	spin_lock_init(&info->pie_lock);
>> -	spin_lock_init(&info->alarm_clk_lock);
>> +	spin_lock_init(&info->alarm_lock);
>>  
>>  	platform_set_drvdata(pdev, info);
>>  
>> @@ -591,6 +578,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>>  
>>  	s3c_rtc_setfreq(info, 1);
>>  
>> +	s3c_rtc_disable_clk(info);
> I cannot find the reason why this is related to this particular change.
> I mean, it looks reasonable because previously the clock looked like it
> was enabled all the time... but maybe this should be separate pach?

It wasn't enabled all the time, because the call to s3c_rtc_setfreq()
disabled it (remember there was no clock enable reference counting!).
Now once we have enable/disable reference counting, we need to keep them
balanced.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

