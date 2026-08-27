Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184D3C09F3
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817986; cv=none; b=he6Pkh97HX/atWlWp4/o/wuTJe/VeGi5ZCVqTvM2DW2z3SYgfYq9PlI1laDVE4Pc38hyL/su8xixyIx+h4dyl6pX0qhx/Od1eeCDunpM3LZhhjXJXwHfvzQotvr9mxJwQ9Y2KpvZykgLVFeDozqkXyltvh1ADfLVwVzYDOReDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817986; c=relaxed/simple;
	bh=p1rygkfaeBiWsEPmduSBRveYDcWSFNEALXNMpUqkrI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQc/HaH7QZCzxRBb+zcdnn8J7J8MQmxX4FKdrXT20rfxi+Zod0doXDDJ5EJBdBVvDebxnv7TZk17e0Ze9PJbIlR03Qq3YQ1+LtAUXAAAC1ElLPh8d9ZWL+tmm9fQWDOpMPAew+0v3K8SpayyTN6qhiQ4409y/uorCEklcxx0CdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz8t1787817947t14a37887
X-QQ-Originating-IP: GhvqfVYhO1cVRb86MwSzYKPvggIfG1d271ZX2JXGX8U=
Received: from [192.168.64.241] ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:05:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7510365385451318356
Message-ID: <945CF85AECACDF48+367c132b-e5f8-41b3-94e7-27c564622486@kylinsec.com.cn>
Date: Thu, 27 Aug 2026 16:05:41 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] rtc: ftrtc010: fix clock resource leak on probe
 failure
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <16D871E1646724FD+20260827063019.3342085-2-liudalin@kylinsec.com.cn>
 <20260827064542.80B081F000E9@smtp.kernel.org>
Content-Language: en-US
From: liudalin <liudalin@kylinsec.com.cn>
In-Reply-To: <20260827064542.80B081F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OccmtviHNKX2dfgx/Hz4qQoZAZOGIfQpqgJ8Df49R/frGL0w7in1+4hh
	Lz96jAL1oYyU/gdpRV0zqXcOmE7Y8c4WMaW3qlpme2FWrwQn/wytu21xMg2KvPNVHH0Phvn
	4xsqIWEc34z00J1XH7IgqSoP5vdcCGUn1FElhJsBiARwfXCaUeQ1LKjsx1rrhZkuHavjZxA
	GuQxu1C4D50jrYamM/2VnoHlJm96oJBUMpIgCWmu2MmeePSALoVUGLd9h77yed2BEcVBi9t
	r/VQVOSvKf1T6gys5pQNMuWQD5L3UBfiT5vYPqRhN+O5xYRcUkaAk7Rp8gUVntZ1/yqm7pS
	zeEGwJ0xTs36uKPSTn2RCK961JJYBBpdI0UGppvYhpRgqPUXDxU9JyeevFEXYuXefbrGfRj
	kmNYjBpxn0rY5+GiaA9u36Ums5vYdPnhldxJaRqwGotbOcqST2e7x32+sL9yop9XlfCsHCd
	nyuTxujVvGMIAeiyOrJpRcJDpHUTP3xGG1QhCHCbrbAjmOaHeUoPzPtsYIlRsxH6jTAEIO5
	nYQoHpRWd4aEhnilErrtZP9t+bbSCX2xSHzxlrDCRhv+ow6sspzoqr6Pd53r7rmaqpV4tok
	y+uj9zH1T4/90nvCNAaVYr1TDYoOWuHuXByMCFUfDt9oPeuKcVkzBQXjOgl0RE3wJhtf0zX
	xGwMkwuRdrmhfZFnXOMMVy2KoywNIBHNeMDHwyoBpuNJu9lEpUlmSUJujJjV0/Pfwo8ovkI
	KbTJl6h54dnHYwdnBhXnEmovswhPHjGNy3zxoTz9oJgh9PLG/hlvZVvXDR+L2LIpLO6AzX5
	Vyp9cR2A2ScZihfOvDORe9qymggQL11/wJK+WJdluND1G+xHoZKBQ3R6sOLNBNZ5Am2QQut
	BAQ/O6ad2HfPUbl9Kf1w4+wG0BVufkXUlHZDWMAC1SKLGi73wIWykVwoOonTqUTWZhjsU4W
	8l4/trrs2t+xx7OD3CmdvEC6Xtjl96LilYlS/abeeuX8MAmK9R3S2kCFZT9hZEYW0q/UxRe
	33wgnA8w==
X-QQ-XMRINFO: NI4Ajvh11aEjwFUsBXzqVF8oBuDwSGMSng==
X-QQ-RECHKSPAM: 0

On Thu, 27 Aug 2026, Sashiko AI wrote:

 > [Severity: High]
 > This is a pre-existing issue, but I noticed the interrupt handler
 > unconditionally returns IRQ_HANDLED:
 >
 > drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_interrupt() {
 >     return IRQ_HANDLED;
 > }
 >
 > Since this interrupt is requested as a shared line just prior to device
 > registration in ftrtc010_rtc_probe():
 >
 >     ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 >                    IRQF_SHARED, pdev->name, dev);
 >
 > Could this defeat spurious interrupt detection?

Thank you for the analysis. This is indeed a pre-existing issue but is
not a practical concern for this driver:

1. The RTC hardware is never configured to generate interrupts. The
    driver only writes FTRTC010_CR_ENABLE (bit 0) to the control
    register in ftrtc010_rtc_set_time(). None of the interrupt enable
    bits (bits 1-4) are ever set, so the RTC will never assert an IRQ.

2. The Gemini SoC devicetree assigns IRQ 17 exclusively to the RTC
    (interrupts = <17 IRQ_TYPE_LEVEL_HIGH>), so there is no other
    device sharing this line in practice.

3. Fixing the interrupt handler is outside the scope of this patch
    which addresses only the clock resource leak. A follow-up patch
    could remove the IRQF_SHARED flag and the devm_request_irq() call
    entirely since interrupts are not used.

 > [Severity: High]
 > This is a pre-existing issue, but does ftrtc010_rtc_read_time() lack 
software
 > rollover protection?
 >
 > If a hardware tick occurs asynchronously between these distinct 
readl() calls,
 > could it mix pre-tick and post-tick units and result in corrupted time?

This is a valid theoretical concern but has negligible practical impact:

1. The RTC hardware increments at 1 Hz. The time between successive
    readl() calls is on the order of microseconds, making a tick
    boundary crossing extremely unlikely.

2. Even if a tick occurs between reads, the worst case is a 1-second
    error in the aggregated time value.

3. ftrtc010_rtc_set_time() is a privileged operation (requires
    CAP_SYS_TIME), so concurrent read_time()/set_time() races are
    not a realistic threat model for unprivileged users.

4. The hardware provides no latching mechanism or "busy" flag to
    synchronize multi-register reads. A software retry loop would
    add complexity without guaranteed correctness.

This is outside the scope of the current patch which addresses only
the clock resource leak. If needed, a follow-up patch could implement
a retry loop reading sec twice and checking for consistency.

--
2.43.0

在 2026/8/27 14:45, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The interrupt handler unconditionally returns IRQ_HANDLED in a shared IRQ setup, defeating spurious interrupt detection.
> - [High] Sequential reads of distinct RTC hardware counters lack software rollover protection, risking time corruption.
> --
>
> commit 6944a6b7d4e12941b5612ab5907724e5485e82a6
> Author: Liu Dalin <liudalin@kylinsec.com.cn>
>
> rtc: ftrtc010: fix clock resource leak on probe failure
>
> This commit addresses a resource leak in ftrtc010_rtc_probe() that occurs
> when devm_rtc_register_device() fails. It captures the return value of the
> registration function and jumps to an error handling path. This ensures
> that the clocks obtained via clk_prepare_enable() are properly released.
>
>> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
>> index 02608d3784958..f398d6dc85ae4 100644
>> --- a/drivers/rtc/rtc-ftrtc010.c
>> +++ b/drivers/rtc/rtc-ftrtc010.c
>> @@ -181,7 +181,11 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>>   	if (unlikely(ret))
>>   		goto err_disable_extclk;
>>   
>> -	return devm_rtc_register_device(rtc_dev);
>> +	ret = devm_rtc_register_device(rtc_dev);
>> +	if (ret)
>> +		goto err_disable_extclk;
>> +
>> +	return 0;
>>   
>>   err_disable_extclk:
>>   	clk_disable_unprepare(rtc->extclk);
> [Severity: High]
> This is a pre-existing issue, but I noticed the interrupt handler
> unconditionally returns IRQ_HANDLED:
>
> drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_interrupt() {
> 	return IRQ_HANDLED;
> }
>
> Since this interrupt is requested as a shared line just prior to device
> registration in ftrtc010_rtc_probe():
>
> 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
> 			       IRQF_SHARED, pdev->name, dev);
>
> Could this defeat spurious interrupt detection? If another device on the same
> shared IRQ line asserts an interrupt but its handler fails or is not yet
> registered, this driver will falsely claim to have handled it. This might
> prevent the spurious interrupt detector from disabling the faulty line and
> could result in an unrecoverable interrupt storm.
>
> [Severity: High]
> This is a pre-existing issue, but does ftrtc010_rtc_read_time() lack software
> rollover protection?
>
> drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_read_time() {
>      ...
> 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
> 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
> 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
> 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>      ...
> }
>
> If a hardware tick occurs asynchronously between these distinct readl() calls,
> could it mix pre-tick and post-tick units and result in corrupted time? Since
> there is no hardware latching indicated and no software retry loop to verify
> consistency, an asynchronous tick might cause an incorrect aggregated time to
> be passed to the RTC subsystem.
>
