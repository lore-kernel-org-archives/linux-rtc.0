Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56841F5C4
	for <linux-rtc@vger.kernel.org>; Thu, 10 Sep 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027829; cv=none; b=Vmf7dEPIVSppDS5fncb2Qfht7uhj1ChZDQBwHRYi/Tjn7Jw9sfmcbdzMTWyzMIAeWoZqiSv0m1L9XjQal5JckHwL8okwUS8VY5irBGa+MVODPDBPCkROfAdNIsfq2fqsrjkp+M+2vM8yKbtDjM7AJJExzxrR4uVY4Nbjb/Gaxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027829; c=relaxed/simple;
	bh=8jpHkBGkDlk0BhsLtQYMkZreKEwh1HaVMg598UXAopQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri17yvCMEMtkUlr2oRkqgLLyj6+1b1X1H1L40maQ62rKi6LLUPlWxLG1iz8q5Zl3Lh78YOUeKMGdx25CqSz9UkyFreVCgdWnGbvdAUMYXQu7tly1RDd4lY2JKMRqDaB+m/XtdXbz20BSYVDHdmiSwZ2rUJQJGSjiAP1yThDrekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBVXhBjP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBVXhBjP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso71789745e9.1
        for <linux-rtc@vger.kernel.org>; Thu, 10 Sep 2026 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789027826; x=1789632626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INcpUno4CMeCoSWa31fGGnXJCg6HwNsUBH/ehD6uQzQ=;
        b=YBVXhBjPSHGIvYau5bnc5Ye3YFt602wgkjHjBGbgVWdWT3wcefS8iBT9ZIeBlqeu7P
         RLF/FY2Bg6/D8TupSmC0WJJ/dvJTAphNQr4qJQnJhECg6/UJABtH9u1IdawrEUn3xBMf
         DWJEYyY2yIm16RzJEMwzsGWOMvqInlsaOwjaL1KlkNYOo9CZwLc2bMar/8YdFKe6uDjs
         eRkjCsejP7yGEvy4cY64dIoEa4PVwbZHpwbi10y2zctBuRyKKrfJDPhHbpOq/JHhTHrm
         iTQ5j30boTYhY032f8ihxWyx+ExcDyrwftrHlLcHbifB2kBeP6+f+qAEK7WnGXuT6zuP
         7Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027826; x=1789632626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INcpUno4CMeCoSWa31fGGnXJCg6HwNsUBH/ehD6uQzQ=;
        b=KpUAIDvVNzpPdeSz5UYGbdrYcoKp7Old7MMLixpldPK/BRDPbhMmtsodn5S+jmjHtQ
         myTN52RLjSfS4PnealyB6dhViI/HjhJjRUdlIG4wkRg8VDjoS9aLIUeAFYu5Mx+4yW4S
         j4z56Zu/u8kHxURLyzZjg1EYOiR+xJnn3enTXjlpb1taU5V/YIXsNaYOeqaJy89kusyh
         ZTf0peH+IBcCZnfmX3xpcOGlWc+G+YvGPEUwEFBj6Dh6nTsrfCKXJY62kHe0n22hZikz
         bV+ArSVTNGwN1dnsFQfBbB+OLFhHE48FpJo+vFknqfVJXEkYw8GbTSnp3/A0N7Sslwpt
         mt7A==
X-Forwarded-Encrypted: i=1; AKwUvBx+nEP1aR4obJtiJ5q1e9jhqOiLgF6SH+Q4mwPlkEkrz6NGEevhGHMhZPdY7HxIax1woKH50vwgAkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mDzSsBAGuAMWH8fpXNadiKZUgdR3aWjf3QEoS4aRQpHpKDNgCd
	MTnvTOqwAMuDxZp2gghrQcsHn3j/MkIuJVqPnebgPcpXdcZE4w4QuVxh
X-Gm-Gg: AYBFou09BruKv+jTXxXMtVl2pH5hbUdd68JMDBELtnZnIREDDlbFl5TepdgxFWo1IjK
	/QruyeQgfhfUkWC7mtmWyQwhitWedEq7oiy5FBsiF+wK+0XdeTwSuxN5kD+ISKSLOPmMUIcLhlB
	nIWzOVJ6cH6qTnsl9e+/1yLyA9mTOQFNaQy9JmSTe0Ta5MZ9s44oic7B7IE5Db9Hp9wbE1Y2Acr
	SWqojcm2wxglSAL1BNpOLjKbIPfKRgu3z/xXy6aYWLygySFFbcdCrM/kOTk+8b5gS+cHBJKPeVP
	4nYl2bIBavaXuCvYFIyXEPeKE861Lmi3ioRNS5v8Uj0PByKBRtSo3SHoKVJEaYdL1I2RvZ7AEpR
	b11grCT6rCEJ2mLP71DFzzkFZb8vyMbRMkljl5HVhALeApX1EZ5bNOIMMzUy/xyqQYDUOAhB5BH
	03hSIbQMb0gi1hltmfB/gPRoJqhq2NU5ODpKLRwLC4a2hYt4uJUO9nQscazJW2aZlMf2Gwekcev
	cJJ0aEAWu9H
X-Received: by 2002:a05:600c:8707:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49cfc6e8efdmr368618445e9.19.1789027826071;
        Thu, 10 Sep 2026 01:10:26 -0700 (PDT)
Received: from [10.128.189.58] ([185.195.28.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc1be3sm55241535e9.4.2026.09.10.01.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:10:25 -0700 (PDT)
Message-ID: <05f93f31-08d6-4d9f-a897-a36a96af1629@gmail.com>
Date: Thu, 10 Sep 2026 10:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
 <4c237cd8-024f-405e-a00e-e22ff9529d08@kernel.org>
 <8cd19ae8-372b-444b-bd2a-dc01221b5896@kernel.org>
 <CAAOJLPHNGgC7B=7ESCifZ1FPcR6V=Hcg-q-aaVg_9M_-d6Fh2A@mail.gmail.com>
 <718e88b8-3f3b-410e-8e76-90c370ff920a@kernel.org>
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <718e88b8-3f3b-410e-8e76-90c370ff920a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 >Whether device has separate node, depends on it having dedicated
 >resources. I don't see such here, so unlikely it should have a node in
 >the first place (see writing bindings or DTS101 where exactly this
 >question is asked).

I think you are right there is no extra node needed (only 
the trickle-voltage-millivolt property) and it could move directly into 
the rpi_firmware node without creating an extra node.

Kind regards
Sander

On 9/10/26 09:08, Krzysztof Kozlowski wrote:
> On 09/09/2026 22:24, Sander Speetjens wrote:
>> Thanks for your response
>>
>>> And more important, where is any interface to actually control the RTC?
>>> I see nothing, so your firmware is? Then this is not a separate device
>>> and you just added DTS for your driver, which is a no go (see writing
>>> bindings).
>> The RTC is a physical, battery-backed RTC, but the Raspberry Pi firmware
>> exposes its register interface exclusively through the firmware mailbox.
>> I initially used a firmware phandle so the RTC driver could obtain the
>> existing rpi_firmware instance.
>>
>> Based on your comment, I think it is more appropriate to model
>> the RTC as a child device of rpi-firmware,
>> referencing to the existing firmware clock/reset/power services,
>> and have the driver obtain the firmware interface from its parent
>> rather than adding a phandle solely for driver plumbing.
>> Which also means moving this to arm/bcm/raspberrypi,bcm2835-firmware.yaml
>>
> Whether device has separate node, depends on it having dedicated
> resources. I don't see such here, so unlikely it should have a node in
> the first place (see writing bindings or DTS101 where exactly this
> question is asked).
>
> Best regards,
> Krzysztof
