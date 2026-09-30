Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948551B163;
	Wed, 30 Sep 2026 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793887; cv=none; b=PVm/ICqT6FH1iERkxsXwAjH9wG/G5GYvYeNYl4cZLhX7yNkX1xctk+pVvXXhyl26fJORf0kEmUSMSBAPcXpvVo8bM6Ocq1BNVXdpq9oWxAbYWLaDpNN2hCjqZlR2n9p72sPTg28HnRXI2Pe0muk84+xh+346913lgjAVlgOnNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793887; c=relaxed/simple;
	bh=61Gs06PWtL2TyJGkjV26Z9Jo7iWrYxYHYfMErUQ3O8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbIXwUnIAOkWmYFnyQCdB/KX74MwDr6l079fiNiKZy7b/7uG3EoUhFdnS4zpSpPdrzoVvBD0mlbKz9IN48LiTvFvoGs28EQ+gqowFgduBzqeQxeVXTWEQquoP9DGLLd6IQEyxLlmjHXYQ+23F0GY9ogcoklc7PI0bECrbreIdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AC0iUQ69; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AC0iUQ69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790793868; x=1791398668; i=wahrenst@gmx.net;
	bh=61Gs06PWtL2TyJGkjV26Z9Jo7iWrYxYHYfMErUQ3O8U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AC0iUQ696uyBHGTZVMJ4B4SPigpPPshR+yUBB/fg6yn3GiEXAevcgHlM63p5oDzY
	 haknseycJJXOgFfM1eHTwFmsdpQ+SkxDJgRRi/y6zot8U0Jj1Bq0yzKFQhy+UhR4p
	 0RePxHJTMlUigWSq8UleBKBUYqbyLnv0hBjVdkCLrrc1DMo/yXFbOQ9qrG2kmWvgK
	 s7U/J6Px7xCmgM4cWwlVSJ68RNVRtZWNC11l3+E/jsJj0ndLKDZ8LVwenBnw4p7k9
	 mVLUoegqX0HjLa8KoZhJKMJHDIP20chDroKJl0QV6HSWQehel9ZvRYRuDLmRzr4FX
	 YiQSR+LT0195T5YDPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1x7qhD1KiZ-0064yz; Wed, 30
 Sep 2026 20:44:28 +0200
Message-ID: <550045ab-fe74-4445-8f6c-4a031f5b436b@gmx.net>
Date: Wed, 30 Sep 2026 20:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rtc: Add Raspberry Pi 5 RTC driver
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com,
 Dom Cobley <popcornmix@gmail.com>
References: <20260930095203.492949-1-sander.speetjens@gmail.com>
 <20260930095203.492949-3-sander.speetjens@gmail.com>
 <7441de5b-e9a6-4080-b312-d6c7123fdcde@gmx.net>
 <2872a37d-4f24-4429-aba5-34f020740821@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <2872a37d-4f24-4429-aba5-34f020740821@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SXHOOm8lNy1EusNCGXiNQ/icdsKa4sPXpM7gBXfOFQ2Usqwf97J
 RXzaeXRK3jU8cBAXh8xJll2n7WV8R8FsivlRhdw0vGf8elttTuZOHcpPY3W+K+O+2Liurxc
 EE++J/wHx4ifHN7aAtrMK178v/OTzklA1L6s5Tm8I/yMbyabYriBqoZkqOWdDksJesbQtf0
 S9GnvsKiaFggmfPYdv2NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LB5Xoeesj0U=;XQFKMqzrKefoRKWqXWNwJHgXdU8
 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
 Z5txmkInBId2n

Am 30.09.26 um 19:29 schrieb Sander Speetjens:
> Hi Stefan,
>
>>> +=C2=A0=C2=A0=C2=A0 // Check if our model is a Raspberry Pi 5, as the =
RTC is only=20
>>> present on that model.
>>> +=C2=A0=C2=A0=C2=A0 if (!of_machine_is_compatible("brcm,bcm2712"))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> I don't like the comment, because it doesn't check for Raspberry Pi=20
>> 5, the code checks for a BCM2712 SoC which could also be on a CM5 or=20
>> a Raspberry Pi 500+=20
> I changed it to BCM2712, but isn't RPi 5 the generation/platform name=20
> and RPi 5b the specific board?
The specific model name for the Raspberry Pi 5 board is "Raspberry Pi 5"=
=20
and it's devicetree compatible is "raspberrypi,5-model-b". Both doesn't=20
have anything to do with the generation. "brcm,bcm2712" is the used=20
System on chip (SoC), which is common for all board of the 5th generation.

So you can write something like
// Check if our Raspberry Pi board is from the 5th gen ...
>
>>> +#define RPI_FIRMWARE_GET_RTC_REG 0x00030087
>>> +#define RPI_FIRMWARE_SET_RTC_REG 0x00038087
>> Was there a specific reason to not include these defines to=20
>> include/soc/bcm2835/raspberry-pi-firmware.h as all the others=20
>> firmware tags?=20
> No specific reason, this is how Raspberry Pi originally did it, I=20
> moved them to raspberrypi-firmware.h
>
>>> +
>>> +enum {
>>> +=C2=A0=C2=A0=C2=A0 RTC_TIME,
>>> +=C2=A0=C2=A0=C2=A0 RTC_ALARM,
>>> +=C2=A0=C2=A0=C2=A0 RTC_ALARM_PENDING,
>>> +=C2=A0=C2=A0=C2=A0 RTC_ALARM_ENABLE,
>>> +=C2=A0=C2=A0=C2=A0 RTC_BBAT_CHG_VOLTS,
>>> +=C2=A0=C2=A0=C2=A0 RTC_BBAT_CHG_VOLTS_MIN,
>>> +=C2=A0=C2=A0=C2=A0 RTC_BBAT_CHG_VOLTS_MAX,
>>> +=C2=A0=C2=A0=C2=A0 RTC_BBAT_VOLTS
>>> +};
>> Hm, an enum suggests that we simply can add / remove items, but=20
>> that's not the case. The Raspberry Pi firmware defines the values.
> Should I also move those to raspberrypi-firmware.h or is this not what=
=20
> you imply?
No this wasn't my implication. One way to make this ABI more explicit=20
would be to use #define. I think there is no need to move to=20
raspberrypi-firmware.
>
>> In case rpi_rtc_set_limits() fails, both limit would be initialized=20
>> with 0 and this always fail. Maybe we should dev_warn to=20
>> rpi_rtc_set_limits()?
>
> I added a warning for failing to set the min and max values.
>
>> Just to be sure, both calls are optional and not critical for the=20
>> drivers function?
>> Why does rpi_rtc_set_charge_voltage have a return value at all?
> I removed the return value
>
>>> +MODULE_ALIAS("platform:raspberrypi-rtc");
>> Is this really necessary for module autoloading?
> I'm not sure, it was used in the previous versions when using the=20
> platform device register on the register_clk driver before it had a=20
> custom dt node.
You can test by removing the line and compile it as a module. In case=20
the RTC driver is still automatically loaded, we can drop it.
>
>
> Kind regards,
>
> Sander Speetjens

