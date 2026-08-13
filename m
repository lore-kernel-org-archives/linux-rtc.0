Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAE47A879
	for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625718; cv=none; b=Hg/ja/3IjchKEL1ZLWOg6qG/BgI1+HnNi5r5cWKC2MRyl3/OFQu6J0hsxaUC399m3KS/uymmcZMa6bftiAfjKCYUedxXZfcv6rj4KOfM+K4vRJeDrdWVmog0JbW+UH+HxaW3qtG0KZseNnw3ikBY3qRoV/G3RzH/FQperrph94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625718; c=relaxed/simple;
	bh=HrpuHtXRs3lkzPV2KF4jr4RPVBEPyIUfTr35gw5M1iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQklAOVtX6DFjMLaE4yF97Emk4ErRDjPIqUPhDFSYmBCh+gUS7GIx0Sg7nLLWaYXDZKoLURfUZ4Eigja1FrYbnMCVBv6ZCfl/7HVITf58sU25nTBAUgUt7Cc2EfZA6XGzhWzdlG5IPnjYfQK9/xUMh3mLaUhn8ahIaaQQ3Bal0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOn0wESQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOn0wESQ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2aab18795so726883e87.2
        for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786625714; x=1787230514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jhcvNWSwuNAllGIhB4lzw/CqsOc6VTmvp2k274Uc3o=;
        b=BOn0wESQ+2KXUfLqYEyKA7tfVWjGL0NzreOazkA7IAImC5ucSAw39LOMfRQ3UEcvEv
         wj3Rna02ifbHSVQffk3mukJmy+YYpoaa1kKKstx2j81X7rSSEANTzC1U7rUJ9qNm3JCN
         ommatv8rgP5qeRD+TuT52BSwfgkz4UnOZDUQZZHDnlp2gasjvEI9GaikuWeBbHJUdBkg
         63J+xha/o4O8sN6tQHm/SAMjYzHtNjd1AEVkpWnAEMIxjx6oFhZLntwfUERovklFT7bX
         SlcSo2AMaJjObiH5DpfPlcGQYwuub9X//jvfJXCsQewrat1qAnynTf9H7PPT++REqjBR
         x1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625714; x=1787230514;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jhcvNWSwuNAllGIhB4lzw/CqsOc6VTmvp2k274Uc3o=;
        b=PxftRnbrOHPNd/OED16pvbxLVhuruetopySJOwfkF+3gxZn20ueBG61hMzQcqtQCbD
         nk8arNvxT1SIAC3VKOfWvmaRdnVRqCzQhBJD9BeNOiuKCRCeFN78/BPQOCueVl9xeYOg
         Ohr5M9/LI7CARP4TVIQAJrTgI1+gSptaWsRJWsbLNH73bWUvF4giRv5+6jTChLjfxl0/
         Rcdy0Z/uP5dV66KzeLmVPrO03al5Ky/GBLpd33Hon3zzwPQpV0OApMFTQccgBY4EwBdF
         27O/OugeGiTSjSn6b2hPunjhbJ9SEDWMDZVpkK8lcBmHm0/xsx4g9wQDLGPDBq6gMDHa
         gBrA==
X-Forwarded-Encrypted: i=1; AHgh+Rpnnh+xUCMhtg1m/UQVYYy4MFAW/ASscM33pcEPgUe6eAFqqYzDXlTmWrg/EIw5pyoOcRdzMMstKqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+6VH/Q3m4yT707hbD28hUyzIJMvT1Af+3d/EtSOksmuiPPqt
	ERvL6BWHJ/UpeIqDCWLZz1IUKturdRYpuE/vckl9aL4825W5D7rXahAD
X-Gm-Gg: AR+sD10sB5uPBFyhqLiQcmVFx3JEA44zo61/pSywN0EuSdlW5KQBQ1Bev+GmHxxvjjt
	fX8p+Y13+fWnOBbc4vezjvm8cOdVjrEBQmvWq7UZLc/oXkl7NfdCkcgaMX//5Dx14nsF3Wpd+ar
	P4wrP5hj9OKDGqk5VKxp2NMT4ec/yRwgbGr9cG1/H5a2htNdcdWoNhuVPN5PD8gFJAHvzVFbp4B
	voX+DMclTuJKEKIH4CAht6WeZ9FULXdw4IMdygQQZwJjv3pkT++Ne+AAaxNU4Oj7UBrWpw/j09A
	4bAfxzu6qqnoSKcY9Bu/gc4PSqbeiYzwZ2dKcS+m41CQv7siLr3/9Kjl/3dtDWmEL1IjK6Fwv8w
	rSmKmSoK9+BrRZO24FECUv/HkdTXpD8G80aU6QbXi4F4OSR3IrLzl2p9UMshlYlEGBuq/U4wAgf
	GzPZIeDhUY527Qdkn3+QxK5LTo4qIYaLGhXL+JNehnfzHB2H4bm3IiYFsGBqR0QOHWulgdwaVpA
	KtT7ACIZeOttXNmhtf3EXX+vo61a8tnOMxCB9jPEEQVCwQbyDt1BN3H
X-Received: by 2002:a05:6512:1284:b0:5ae:b0c0:16bc with SMTP id 2adb3069b0e04-5b453f77a1dmr809693e87.27.1786625714101;
        Thu, 13 Aug 2026 05:55:14 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4539ea237sm456405e87.18.2026.08.13.05.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 05:55:13 -0700 (PDT)
Message-ID: <12f70e0f-5cef-4035-9b44-e2cb252932cf@gmail.com>
Date: Thu, 13 Aug 2026 15:55:12 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Linus Walleij <linusw@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <9774b8d6663ea55b1682b32f825ec5689be3e1d8.1785838585.git.mazziesaccount@gmail.com>
 <CAD++jLmatJFfqhNWfgx=qUW2fEwuatxmJR7NyJLAv45LfLHZnw@mail.gmail.com>
 <f5c241a2-00a8-4a32-bad5-3c89fb204b25@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <f5c241a2-00a8-4a32-bad5-3c89fb204b25@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2026 11:34, Matti Vaittinen wrote:
> On 07/08/2026 23:29, Linus Walleij wrote:

...

>>   * @fixed_direction_output:
>>   *                      (Optional) Bitmap representing the fixed 
>> direction of
>>   *                      the GPIO lines. Useful when there are GPIO 
>> lines with a
>>   *                      fixed direction mixed together in the same 
>> register.
>>
>> It seems you can set up the fixed_direction_output mask from OTP
>> and just use the library, right?
> 
> The BD73800 uses different registers for 'out' and 'in'. So there aren't 
> really "GPIO lines with a fixed direction mixed together in the same 
> register".

...

> I think the BD73800 can indeed use the gpio-regmap, by keeping the pin 
> direction information in private data and adding a custom xlate, which 
> errors out if get is requested for output pin, or set is requested for 
> input. I am not sure how much of an improvement it is compared to the 
> patch v2, but I'll give it a shot :) I believe the new -rc1 isn't that 
> far away, and hopefully the gpio-regmap -stuff from the next will be in 
> it together with the regulator stuff bindings depended.

Gah. Please, ignore the erroring-out part. I don't know where I picked 
the idea that the hardware would always return '0' when reading the 
GPO_OUT register. I think this might have been something I have 
experienced on a setup where the pin was _not_ set to GPO by OTP. 
Furthermore, the xlate will never get called if user tries to set value 
for a GPI pin.

Anyways, implementing xlate with op-check allows me to support this 
PMIC, even though the register to read for pin status depends on OTP.

So yes, v3 should be able to use gpio-regmap. I will probably delay 
sending it until v7.3-rc1 is out so I get (all?) dependencies in.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
