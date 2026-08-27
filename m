Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E73BED2D
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818023; cv=none; b=P+SLrPZTU7WmuvawxSdpxA5579cjyurZcfovY/1xcPHoK31L7JbE99RLEVWMAjepwyK2Si65G0I+h1fr2dRjNrhRTYugJqFLK1srJsLLzihD6xX8Je6XbmiWoTq4ptH4FiCpbFqdW5E+FHCmrbOwSMfI063Np8uEGRf9eUWQWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818023; c=relaxed/simple;
	bh=aKacfkQHn6PL7k3vf0TxcUTw91KGSpbeSvFMs4E+mmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jN6N1RCMwhWJDZxKT7NwvxiFUsEM5K6wrU5Uy2fNXQV+Vkri5zHOjCde/k9tjb9xfVmDy9wjL272g5spitl43uOplnmOpCti2kEddHHvNfx9cpvDul3sqjzDcIgpT7R1H7kRTfdYaXSNK4KXxWfbi22n5d3Y1bqJOFv0pfdyrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpgz11t1787817997t4487356d
X-QQ-Originating-IP: eP/vieI/zvw5fjLxklvmI+Hxnc8LaZ0DE7sXI8nhbYM=
Received: from [192.168.64.241] ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:06:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 655855182742176943
Message-ID: <0B2B828ACEF8E81C+387077bf-b850-4c7e-bb38-9c031e4ee429@kylinsec.com.cn>
Date: Thu, 27 Aug 2026 16:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] rtc: ftrtc010: use devm clock APIs to fix
 use-after-disable in remove
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <17C4ADB7B3B875B8+20260827063019.3342085-3-liudalin@kylinsec.com.cn>
 <20260827064300.7825B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: liudalin <liudalin@kylinsec.com.cn>
In-Reply-To: <20260827064300.7825B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmIUUz9KGMMdJyglVnQA0/ljZryFt+6wzKhqy2MSYfinuj1RY5+bykdE
	ZHQEIfRxJTTG/vMkptmFQsFCyshYswCrUBeoEN53bIwWdKbVn7oi+m89p5rF09LoMJ1QFLT
	4f8t68A67+ClXH90ARX7uBBx3sH8WDjPRcRwfUwh0Baoql7zH93wEiQgKNewHOUTNNG5dBX
	rqs5SJsazd9tLMsBJ7tHmbEGLV2r04VZ8i+Fa8JTvdzJMAY1gaTTx4NxojESO5WgFX1K74l
	XReZeDwCv7RrCRJYTTxNK4yam8lu8xmtTRoqnPy/1J6DAnr9+xoBJZ04hmI0I8iHMcBrjWp
	G8wnKShiiq9MO3+RpbRiHEbb8jwkEttTDqbAOnRl2JnFCOJTGpQ1XaUxhhoY2GWEVqMvK5s
	nIo1yXwZfXHpr9R/6Dqy6ZCJcTHSni2c5HpDAX5En1WPUKsL3PXD7SeDTmbg6uePA0fpJNV
	rPaQBQKXGLdo4UEv7kWU2I+Uq5q012wEduEJ/BKlaC/FVfOZ4nwLZN+hEqeU0WZi9kayjEA
	KeqEDaqAkpTWH8zuh0jz+gAINglxWRS9vYBFXyeKWaVs/dilVSSEH4bukzFWHfK49TRoe3c
	ZWSJLWvPcUkW2z+u0Q/4qT4fGfwU4N1DrqhyEyhPvdADVn/wvmZSvkhk85ur9BPv0FFs3Gr
	DAkHm2Mqmi+3x8QBGSF5o2cOwqZDLKCd7cXjKLigXdVyFkAaD1kuEvO3RnMIQzzI03xTQgq
	WJmRJquqPwf1XNn6l8AAst5UrsPuIAcG9BDR8n8lQBOQHUUSfwZjYUhY9PjFDzzS+8yzN90
	Dja/ubW1H9LgNPJjGydg2ppKXiNFI2yLq2A18SexoPzwqvrnVIOWwjLHtIbajD2GIYkn4R/
	mUhKgQ6ixoSyfaeGinGT0M+k+EXK18s+gKUI3NkWhQ4+YmihG+s9zU/B5ne0VXBHwhVaJ2s
	mwbTaRhDH9Nv/ByY9UV8Ji9oGZzk8Yo3USQjkde2KwYLA7n0PWXM11gt0W8n8fnk24VjhSo
	TrJAT8nb/neivj3ihhnIIWcHwYmFo=
X-QQ-XMRINFO: NyFYKkN4Ny6FzEd1DoGtcfjSGHs6P4K7Vw==
X-QQ-RECHKSPAM: 0

On Thu, 27 Aug 2026, Sashiko AI wrote:

 > [Severity: High]
 > If CONFIG_HAVE_CLK is disabled, devm_clk_get_enabled() returns NULL.
 > Doesn't PTR_ERR_OR_ZERO(NULL) evaluate to 0, which would cause
 > ftrtc010_rtc_probe() to silently return 0 and exit prematurely
 > before mapping memory or registering the RTC device?

This is correct behavior, not a bug:

1. When CONFIG_HAVE_CLK is disabled, the entire clock framework is
    compiled out. devm_clk_get_enabled() returning NULL indicates
    "no clock management needed", and PTR_ERR_OR_ZERO(NULL) = 0
    correctly allows probe to proceed.

2. The Gemini SoC (the only user of this driver) always enables
    CONFIG_HAVE_CLK via ARCH_GEMINI in its defconfig.

3. This is the standard pattern used throughout the kernel for
    optional clock handling (see devm_clk_get_optional_enabled()
    documentation in include/linux/clk.h).

 > [Severity: High]
 > Additionally, since the old code treated PCLK as optional (only logging
 > an error if it failed), what happens if the clock is omitted from the
 > Device Tree? devm_clk_get_enabled() returns -ENOENT, which
 > PTR_ERR_OR_ZERO() will propagate as an error. Could this break
 > backward compatibility with older device trees that omit this clock?

The old code's "optional" treatment was itself a bug, not a feature:

1. The hardware requires both PCLK and EXTCLK to function. Without
    PCLK, the RTC registers cannot be accessed. The old code would
    continue probe, map memory, and register the device, leading to
    synchronous external aborts on the first register read.

2. The devicetree binding (Documentation/devicetree/bindings/rtc/
    faraday,ftrtc010.yaml) lists both clocks as required properties.

3. Both compatible strings ("cortina,gemini-rtc" and
    "faraday,ftrtc010") reference devicetrees that always include
    both clocks. There are no known device trees that omit them.

4. Failing probe is strictly better than the old behavior: the
    error is reported clearly, and the driver can be retried or
    unloaded cleanly.

 > [Severity: High]
 > Does this have the same silent probe truncation or Device Tree
 > compatibility issues as the PCLK conversion above?

Same answer as above -- the behavior is correct and the old code
was buggy. Both clocks are required by the hardware and the
devicetree binding.

 > [Severity: High]
 > This is a pre-existing issue, but I noticed the driver requests a
 > shared interrupt with IRQF_SHARED. Looking at ftrtc010_rtc_interrupt(),
 > it returns IRQ_HANDLED unconditionally...

Please see the response to the same concern on patch 1. The RTC
hardware is never configured to generate interrupts, and IRQ 17 is
not shared with other devices on the Gemini SoC. This is outside
the scope of this patch.

 > [Severity: High]
 > This isn't a bug introduced by this patch, but looking through the
 > driver, is there a race condition against the hardware ticking in both
 > ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time()?

Please see the response to the same concern on patch 1. The 1 Hz
tick rate makes this negligible in practice, and the hardware
provides no latching mechanism. This is outside the scope of this
patch.

--
2.43.0

在 2026/8/27 14:43, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Incorrect clock API usage and error handling truncates probe on missing or optional clocks.
>
> Pre-existing issues:
> - [High] Time-of-Check to Time-of-Use (TOCTOU) race against hardware ticking causes time corruption.
> - [High] Unconditional IRQ_HANDLED on a shared interrupt line defeats the spurious interrupt detector.
> --
>
> commit 289123a8d46a85463292da46c4edfed7ee0a88db
> Author: Liu Dalin <liudalin@kylinsec.com.cn>
>
> rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
>
> This commit replaces manual clock management with devm_clk_get_enabled()
> to tie the clock lifecycle to devres, fixing a use-after-disable window
> during device removal. It also cleans up the probe error handling path
> and removes the manual remove callback.
>
>> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
>> --- a/drivers/rtc/rtc-ftrtc010.c
>> +++ b/drivers/rtc/rtc-ftrtc010.c
>> @@ -120,51 +120,33 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	platform_set_drvdata(pdev, rtc);
>>   
>> -	rtc->pclk = devm_clk_get(dev, "PCLK");
>> -	if (IS_ERR(rtc->pclk)) {
>> +	rtc->pclk = devm_clk_get_enabled(dev, "PCLK");
>> +	if (IS_ERR_OR_NULL(rtc->pclk)) {
>>   		dev_err(dev, "could not get PCLK\n");
>> -	} else {
>> -		ret = clk_prepare_enable(rtc->pclk);
>> -		if (ret) {
>> -			dev_err(dev, "failed to enable PCLK\n");
>> -			return ret;
>> -		}
>> +		return PTR_ERR_OR_ZERO(rtc->pclk);
>>   	}
> [Severity: High]
> If CONFIG_HAVE_CLK is disabled, devm_clk_get_enabled() returns NULL. Doesn't
> PTR_ERR_OR_ZERO(NULL) evaluate to 0, which would cause ftrtc010_rtc_probe()
> to silently return 0 and exit prematurely before mapping memory or registering
> the RTC device?
>
> Additionally, since the old code treated PCLK as optional (only logging an
> error if it failed), what happens if the clock is omitted from the Device
> Tree? devm_clk_get_enabled() returns -ENOENT, which PTR_ERR_OR_ZERO() will
> propagate as an error. Could this break backward compatibility with older
> device trees that omit this clock?
>
>> -	rtc->extclk = devm_clk_get(dev, "EXTCLK");
>> -	if (IS_ERR(rtc->extclk)) {
>> +	rtc->extclk = devm_clk_get_enabled(dev, "EXTCLK");
>> +	if (IS_ERR_OR_NULL(rtc->extclk)) {
>>   		dev_err(dev, "could not get EXTCLK\n");
>> -	} else {
>> -		ret = clk_prepare_enable(rtc->extclk);
>> -		if (ret) {
>> -			dev_err(dev, "failed to enable EXTCLK\n");
>> -			goto err_disable_pclk;
>> -		}
>> +		return PTR_ERR_OR_ZERO(rtc->extclk);
>>   	}
> [Severity: High]
> Does this have the same silent probe truncation or Device Tree compatibility
> issues as the PCLK conversion above?
>
> [ ... ]
>
>> @@ -179,29 +161,13 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>>   	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>>   			       IRQF_SHARED, pdev->name, dev);
> [Severity: High]
> This is a pre-existing issue, but I noticed the driver requests a shared
> interrupt with IRQF_SHARED. Looking at ftrtc010_rtc_interrupt(), it returns
> IRQ_HANDLED unconditionally:
>
> static irqreturn_t ftrtc010_rtc_interrupt(int irq, void *dev)
> {
>          return IRQ_HANDLED;
> }
>
> If another device sharing this IRQ line asserts an interrupt and gets stuck,
> would this unconditional return prevent the kernel's spurious interrupt
> detector from disabling the broken IRQ line, potentially leading to an
> interrupt storm and a system hang?
>
> [ ... ]
>
> [Severity: High]
> This isn't a bug introduced by this patch, but looking through the driver,
> is there a race condition against the hardware ticking in both
> ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time()?
>
> In ftrtc010_rtc_read_time():
>
> 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
> 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
> 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
> 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>
> If the hardware clock rolls over (for example, incrementing the minute from
> 59 seconds to 00 seconds) between the reads of two registers, could the
> software combine the old value of one register with the newly incremented
> value of another, resulting in wildly corrupted time calculations?
>
