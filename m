Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427E34752B;
	Mon, 12 Oct 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779995; cv=none; b=K0mvmqqL5A1uueNgOpULah8zKGqjTbFoUMzlq0Xta8Ll4M+Fv7qbqdmYymtN6WJln+t0AfeqYLa81ThY0oiFRz2P6PSpamyv/Of7Cdd54Yz1YOQkEhLYRDWabV4+qlO8ymMHcKFnYzgGX4JADkEZ8qV3uXXuWJyBW6Hi/B0YAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779995; c=relaxed/simple;
	bh=dirM521YRVSMZY8bl4xbLol5kYV3NoCP7ao7NV/k/IA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kHbSqVFH9eC7i+YMiwmThj6WTs4+ASsLTUYFHAHIkxIhrplyG/FpLtFU9TLNvzeMqaOKwhlBEe6jJvw/MRgYD4MtekB+GZ+sy4/JaD8vI+t+YAj5Fx6+NEPlUy0lB0njuS8shbcK3+k+qvnOO/FrBRNB9detKvDhXTdUk1e9ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fKPUG1nj; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="fKPUG1nj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85E0A10766F;
	Mon, 12 Oct 2026 06:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1791779991;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0TgXhJT94KIcqVPvPjHOeU2+K4NFmyanIB1TJEL565U=;
	b=fKPUG1njfnKBiM6gSaReqwx0jlQLqRyWr6NnbjQ6CWD1llCIw2jfuz75K0YmXkNrmdj+k3
	hvcXWEWqPfhai7NtymLE64UuuTLgM6mpi5jroH3kizhM6+8jqEpTneYtSjEH3JEG8+1/jF
	BD4h5h/f4XT+I/cYw6XBpWwGCZmzth1EHTYXIRJVwhH4V+ii6/rXkUu/iUaBldN6C06A8c
	Zme9YZmfRM3Xm3hczuOvE0WmB8sDBz3qSi5g6HFs4W3uIpuEpnwjc3F92qduHIi2U1dE8c
	8tofZ0rhR+C8RLmTd6/IDx5zsmrYvSoFFXK+glsv0l0Q9gSIEpke7YtnSiegGg==
Message-ID: <9993b6fd-95c0-5c0e-1e57-4d07eaef67c1@nabladev.com>
Date: Mon, 12 Oct 2026 06:38:52 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] rtc: rs5c372: add Ricoh R2223x support
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org
References: <20260825071927.4090460-1-hs@nabladev.com>
 <ef8a31e2-dd1e-f37d-7747-e4fe0db4c7cb@nabladev.com>
In-Reply-To: <ef8a31e2-dd1e-f37d-7747-e4fe0db4c7cb@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 12.09.26 09:41, Heiko Schocher wrote:
> Hi All,
> 
> On 25.08.26 09:19, Heiko Schocher wrote:
>> The Ricoh R2223x is an I2C RTC from the same family as the r2025sd and
>> r2221tl which the rtc-rs5c372 already supports. It shares the R2x2x
>> control register layout, so only the new type must be added to the driver.
>>
>> The ricoh R2223x drives a clock output and offers an eco mode that
>> lowers its current consumption while running from the backup supply.
>>
>> The trivial-rtc binding does not cover this, so give the device its
>> own binding in patch 1. Patch 2 adds the R2223x to the rs5c372 rtc
>> driver, and patch 3 implements the eco-mode setting.
>>
>> v2 answers the sashiko review of v1 and a local run of the same review
>> prompts. This resulted in 2 changes:
>>
>> Patch 2 now handles the new type in rs5c372_ioctl(), where RTC_VL_READ
>> read CTRL2 bit 4 as XSTP although the R2x2x parts have PON there and
>> RTC_VL_CLR did nothing at all, and in the two offset helpers, where the
>> R2223x fell back to the coarse trim resolution.
>>
>> Patch 3 now applies the device tree setting in both directions. V1 only
>> set the eco bit before, so a board that dropped the property kept running
>> in eco mode, because CTRL2 is backed by the backup supply.
>>
>> Not touched sashiko reviews (some from local run):
>>
>> - #clock-cells stays out of the required list. Requiring it would
>>    reject every node that does not use the clock output; the other
>>    discrete I2C RTC bindings with a clock output keep it optional too.
>>    Also the clock output can be disabled per hardware pin CLKC. So
>>    #clock-cells is optional.
>>
>>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=1
>>
>> - additionalProperties: false together with $ref: rtc.yaml# means the
>>    properties from rtc.yaml are not allowed here unless they are listed.
>>    Only start-year is, the others can be added once a board needs them.
>>    microcrystal,rv3032.yaml is built the same way.
>>
>> - ricoh,eco-mode is a vendor boolean. Whether the RTC may run in eco
>>    mode depends on the backup cell the board is fitted with, so it
>>    describes the board and not a runtime policy.
>>
>> Changes in v2:
>> - Added Reviewed-by from Conor, no code change in patch 1
>> - Fixed the sashiko review of v1: handle the new type in
>>    rs5c372_ioctl(), rs5c372_read_offset() and rs5c372_set_offset()
>>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=2
>> - Added sashiko review for patch 3 in this patch, as it fits better here
>>    https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=3
>> - Fixed results of a local run of the sashiko review prompts: apply the
>>    device tree setting in both directions. v1 only set the eco bit, so
>>    the mode stayed on when a board dropped the property.
>> - Leave rs5c372_probe() through goto exit like its other error paths,
>>    instead of returning directly.
>>
>> Heiko Schocher (3):
>>    dt-bindings: rtc: add ricoh,r2223x binding
>>    rtc: rs5c372: add support for Ricoh R2223x
>>    rtc: rs5c372: support eco mode on R2223x
>>
>>   .../devicetree/bindings/rtc/ricoh,r2223x.yaml | 58 +++++++++++++++++++
>>   drivers/rtc/rtc-rs5c372.c                     | 52 ++++++++++++++++-
>>   2 files changed, 107 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
>>
>> ---
>> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
>>
> 
> gentle ping.
> 
> Any comments to this series?

gentle ping, thanks!

bye,
Heiko
> 
> Thanks!
> 
> bye,
> Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
