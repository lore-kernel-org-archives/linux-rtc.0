Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D956B871
	for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098448; cv=none; b=tLR+F+ccdrZEERWt245PQDcScwxGoJF3Xz/aM4ZhU6WeFdgUbplHykvOOvj3+ByERuC+IeuiBFSbBOb7WkLW4AjHsRWoHFkJp6AqluQN39svLAL2ZHtn+P+2yTUYXZaCt9SPSrZ1PxjmOeC890hKGwwlQkDrfAJ0e/mUUmFpCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098448; c=relaxed/simple;
	bh=k62lXyffQpfvoXLrJkljRwAuyGHOT0TxBUmsYyaQxeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgGgyJeE45lK0mgOb0IzCiou0VW+Gcmf3eilQCmZ8ux+kBWna0cr2TXmLlgiQw6FzdFDN4zM+lNthopTDlZrlzHL5zD8S64ZIMrVKJypOl9NnhSuZasOGfUlqyZZjvGG7Q1HAbIEkyqV3VjdLnR+cB3Z40vUZN2cKPhL1dD5gJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+qbLcma; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+qbLcma"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f12so6964e87.1
        for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098444; x=1790703244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuuzD7pETxcjGtdgpLYjcgyqt6WFmTw9RRQGOf5Uv14=;
        b=F+qbLcmaca+A7AyWZWOQhPVmars/c7oXhjRoRSh3f6XJiaHgyYayW1M5gB7JLqxQO3
         FOi08tQR4/bFXkcFOtYmcNWxHlTlATsXQvqk73/17WNRlK5Ix1ar4kL8uOPJDcltRRO+
         C6iYgA2Nwkme39zmExsY/8+CFOSAuYGgQp7gs0C32f634ByBEXEG98E4ZTvxnmjDofE2
         93ot/k8pK1oTcAWOpUBZDvStgL/UWssKK89wlvBiz1N226zZiCec77wldh5syBlIrq8/
         Rk9oK+MdMv5fWT5fYqDxFgG8UP/Muz7AjPnDWaQr+pzb/IHFLKu48BYEcCror0pxUdog
         S3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098444; x=1790703244;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuuzD7pETxcjGtdgpLYjcgyqt6WFmTw9RRQGOf5Uv14=;
        b=ycba13760n8SisEnxpTm6XCeoS07eiN39VQ/ByQET7DZduoVAD2qFy3BXa7TKxOiAm
         nNpeyhKktxr7ekh99VS28fj5LsSnFdopDerMFLQBaZhv0fIYEbk8r0IUuJ1xShQmWRmR
         nP2FkrVK4UspjOwfxJmYGaFtalrwm0bQdZQEof9JchcseoJrLivAVUO+zkoRDVXklvU6
         D2dTkv2um5iIKQjFx2mOibL3CHqP7Yx+QaeLyjw0ZyJI8a+H9R5yLXBNSclyXrlqS0CG
         rvbynEhEos9KuFyrEnObJAStTQp0rXnHY3fhiqRVKBgsjgwb+RXAqAszUZAb+BTjz46s
         61OA==
X-Forwarded-Encrypted: i=1; AKwUvBwFwicQ+f+S+Pf76grlMUsfx4sA/x3O9xJS0DqRQTUoJ2uYb5A/c3lZYdN++WLv1x7MqVAhW1SMi/o=@vger.kernel.org
X-Gm-Message-State: AFuF++lf/CL7Ru1n+xJxjx6TuS19a8GuqNnbTCBeecRk9+8kNIPDOq2Y
	9nNd5jyLLTwRzK/6sX2FPqIC35MHu0yyvu/wy6J4APEUC3JFUlU6j7e8
X-Gm-Gg: AYBFou3h3ZsAngxN/9eyuSHn0yiDfrctE1UZS9kjONPXFojQzRFFJ07D4cLc1VSZCk5
	ffJiUNxk8PgYNPTzEyubE93p7i08NclrUxrBv2biDBFWMNI2aGPHwJC+YVHMWhUlhJOAuq57OsS
	IF2bjfhihPruhDUM7y661ijdU53LJj6KvCXnS9XMBQhx7ev0s3DSWPvG6adz2FNWBjKQp5tZcnB
	O2vl/HRB+mFNXZ5/9qpkEm7roxgn86M+H7Mc0Xy4mHEMPoNJajbs6QiZlAMPq2U+KrWc9dhEXZm
	12lMEOXN8/psGkegdQ4eAEJsjQOP8BIc43Q2QxcPi7VUnlPlY6qXQry61oX7cs1D3+igfIZtrwm
	rurxVezn1a/Wtcny+qWDUReC7bBjT93vGkjhPfwfgrtuZ2wvjL7xSEVIOqHrMEfWfzdfks1P4Oa
	GtaBqca54I+mJRjYcAGgCIFwYIW1gMxS/KyEj7FE3QnFFYDu5Wvq1EGMX1Rh9NEOR9EN7hUMKws
	HtQy6KWOxMsurLnCJBPAy79mJjQhdLhOBc66COYOa0MEN9bgVWEfeQ=
X-Received: by 2002:a05:6512:6881:10b0:5b8:9963:12df with SMTP id 2adb3069b0e04-5b8d8960c1bmr764e87.9.1790098444004;
        Tue, 22 Sep 2026 10:34:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d858f129sm41541e87.63.2026.09.22.10.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:34:01 -0700 (PDT)
Message-ID: <df84b2b6-e4a4-4751-9923-6001f78db0a2@gmail.com>
Date: Tue, 22 Sep 2026 20:34:00 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] mfd: Support for ROHM BD73800 PMIC core
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
 Alexander <alexander.sverdlin@siemens.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
 <3e3a25abe337e3f68cde585674019dca439ac897.1789538455.git.mazziesaccount@gmail.com>
 <20260922154543.GA3438784@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260922154543.GA3438784@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2026 18:45, Lee Jones wrote:
> On Wed, 16 Sep 2026, Matti Vaittinen wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The BD73800 integrates regulators, ADC (intended for accumulating current /
>> voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
>>
>> Add core support for ROHM BD73800 Power Management IC.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Acked-by: Lee Jones <lee@kernel.org>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>
>> ---
>> Revision history:
>>   v3 => v4:
>>    - Removed extra whitespace from the end of a file.
>>   v2 => v3:
>>    - Translated this:
>>      https://lore.kernel.org/all/20260813105955.GA1820248@google.com/
>>      to an ack. Please, let me know if this isn't ok.
>>   v1 => v2:
>>    - styling
>>    - update copyright years
>> ---
>>   drivers/mfd/Kconfig              |  15 +-
>>   drivers/mfd/rohm-bd71828.c       | 147 ++++++++++++++-
>>   include/linux/mfd/rohm-bd73800.h | 306 +++++++++++++++++++++++++++++++
>>   include/linux/mfd/rohm-generic.h |   1 +
>>   4 files changed, 461 insertions(+), 8 deletions(-)
>>   create mode 100644 include/linux/mfd/rohm-bd73800.h
> 
> Looks okay.
> 
> Let me know when you have all of the Acks and we'll merge it via MFD.

Thanks Lee,

I think all of the patches had relevant ACKs/RBs already in the previous 
revision. Eg, AFAICS this is good to go.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
