Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090633AF667
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019394; cv=none; b=nsDkqKTHahCq/vlRHoeWeatir8jk8CUNTYxgB5y6gezSMw5/cPa8AFhtDselrMQWxbK4QHckUsd91BRshs3MvLGiiV3NGqVUqUUiHKzHtgNEYwk8JULNQQCXAEFCFNaH4rDBvxVAhqkD39C6LqdvarIqMT1qOpQth2ASprmY0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019394; c=relaxed/simple;
	bh=OaVkxkmraawHNTKTHsTGdgc0Vs97xI/bTkINePWEX74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0OZVSA2JYnTdHAuWmxj65v+9b26S0mwlrWjX7Lc50X6voJal+hIeIzcMYubY/1dWmct+ddNdbcRjC/dxNRe31weRUmV80qh/FzjZpihHTSxbH2RnYfclXb4OGQ0+xGiX4AHGg8mKi1y5OEBVTL7FwBGDkOegT8uHZBCrR0CnsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIfd9lf9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIfd9lf9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so25537785e9.3
        for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790019390; x=1790624190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGcvaZSPcorP6DNYm+a0nDXUDpyXPezZYvSZ9UhvaG0=;
        b=pIfd9lf9FrU+l8KQYa0sYtiSa9yESMeTa1/gvq4MPS433hEfZoKAD7WCF+Gy3gg9n5
         WGemnkxg0UZSi5tcOheCVKI94sWTWLZ/0HivkQGgAnnUtJnXVaRag36RzeZaN6fwCsNJ
         qnBTujA0Hcu8QvTykdTrkb9YA0xOmvbhEqPt4QdIx8mubxqxB6YzR58oYgXZd3ccMRXM
         ftObY82r8C3erfJli+7SPdmFWrp2AqjjT08ZhIu/qH8tusZbYSx/XPbBbx6kHqigB9eD
         5/NhIiugh4yKa/DUFufbb8GWxYj6bUmLpQymunQve4bJdY6UNSmmZz8l1bu5e3Xd4QC8
         //nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019390; x=1790624190;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGcvaZSPcorP6DNYm+a0nDXUDpyXPezZYvSZ9UhvaG0=;
        b=lViHAqTxhaotzSxqHkBEWgHb81gpZNBS/T26hFVa2/6FjGTnJqy68WovLjF8MhMQES
         QgFYBpKU6OP9p/BawnkVEDUvR0awcmHvtTHWx2ypVSuKXKngbZutE7RBtexz+td94v6M
         jK/01NnLU2u4OPOq9W3ffAd56+Rqj+cUjfVw3D8QigGxZfofxakK2dWPTjac1fItOGdh
         pPiSUCmMVDd/WxP3YgF2w6tQCYMX8TOiRY9wIBhYBr7eN9BguV2AALqfQEmVlU4L9vW9
         jw3pUUPQncKF4x5Plqco83P1Ds/rqJY9oPj603SqHWkIsuI5ekpZbbrUgvnf5b9+O7AZ
         IcJg==
X-Forwarded-Encrypted: i=1; AKwUvBwUtvsX1lADHne2Il8CakPPIc5ErLEh7Xb8gqLHwzZ1T5aDRPQhRoPddQL0VIIo7toYj1VQqekVhus=@vger.kernel.org
X-Gm-Message-State: AFuF++lB432zzrHjyZt9Uch7Ie1XEuqEvzz+J5D/fmp8s0dOKLL/GGiP
	gHGnxPXh4/79YjsKr+ypdIi9M5potX+nKI6sEEgA01AiIH68cjRiLpnY
X-Gm-Gg: AYBFou0pF6FtzTwOqSY46uGSTAODswp5Zx6zDYL/heobaLBe387gbJHwJ8VWCRVJWSs
	ab94xKRvN5jtzrHlVvVwrRAS7gRjt9HWkWvMr/BveRGbUPp7OAOC1jLWijkXAJd6UNbYtFUgGPm
	dkzUwUSVkGjNndOgjqKZIhKIYqC67EaB90/L5snPNE6KbNB/9zFeFrvD0PsRvcO0KYDnHmMHbgM
	QiaG/TqU+u7hHhEt2oTtp1xrvczvPH4ic6YpufsqrA4dk36fJN99CAupX2nQqv6n4vovGHFmahX
	NuCQS94HkN2vORO0HLSPluHEKQpvkKDJEg+OIZExOR3bj7RRtKjXTgIIhC43wqLsGxGekhTOZ7f
	hw/q9ikmK1JG4xirU/BI0uaVkmEzPO80kyq33QiqnmVXMoLffSuwIFmbfjf+kDIFsNQjoIM78eI
	670yy8LMYlFF1TDapcgX261tTR768DbkX5pwkhTW8FACRDdXp5mqu64ra+2q2NVpm8fusyS7TLN
	bLq6e5RBMVXcjNWDSjGWs9akzQINBdRRwvUUBzt45o4PkXxD1lloA==
X-Received: by 2002:a05:600c:4e8f:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-49fc574c2b9mr174061695e9.31.1790019389438;
        Mon, 21 Sep 2026 12:36:29 -0700 (PDT)
Received: from [192.168.0.40] (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8b96cefsm13450625e9.1.2026.09.21.12.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 12:36:28 -0700 (PDT)
Message-ID: <9dd42965-f39b-49e5-aeef-5d03647b2005@gmail.com>
Date: Mon, 21 Sep 2026 21:36:27 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rtc: Add Raspberry Pi 5 RTC driver
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Dom Cobley <popcornmix@gmail.com>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-3-sander.speetjens@gmail.com>
 <20260918-outrageous-myrtle-giraffe-80dfdc@quoll>
 <20260921185949d6debd17@mail.local>
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <20260921185949d6debd17@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> This was my comment on the previous revision, I'm not sure why it was
> ignored.
Looks like that email got lost on my end, I found it in the archive.

> This undocumented sysfs interface has to be removed.
Just to make sure I understand correctly: does "This undocumented
sysfs interface has to be removed" mean that
   a) the attributes themselves are not wanted and should be dropped, or
   b) they are acceptable but must be properly documented under
      Documentation/ABI/ before they can stay?

Kind regards
Sander Speetjens

On 9/21/26 20:59, Alexandre Belloni wrote:
> On 18/09/2026 13:47:22+0200, Krzysztof Kozlowski wrote:
>> On Thu, Sep 17, 2026 at 03:58:41PM +0200, Sander Speetjens wrote:
>>> +	return devm_rtc_register_device(vrtc->rtc);
>>> +}
>>> +
>>> +static const struct of_device_id rpi_rtc_dt_match[] = {
>>> +	{ .compatible = "raspberrypi,firmware-rtc"},
>> Please fixup white space issues, see existing drivers (missing space
>> before }
>>
>>> +	{},
>> and unnecessary ,.
>>
>> Just take existing latest code as starting point, otherwise you
>> reintroduce discouraged patterns.
>>
>> More important: undocumented ABI.
>>
> This was my comment on the previous revision, I'm not sure why it was
> ignored.
>
>
