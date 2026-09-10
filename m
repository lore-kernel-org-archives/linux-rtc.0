Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775130FF1D;
	Thu, 10 Sep 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058006; cv=none; b=t827zmfVv5lK9NFm0huekIZUTBfcPV1TeH1Dz78kadisMQAQakV9y+XCwuRwu+VOKVfA2yWRyLayiV0ykkxGQLUiOgD1y78KGAbvme3kxFpT8dVEZzkIk/85wt9XyvnTE1/P4L2QhhWgnwdioGbeuoaPdvD6tqNlXWLTK5xJ/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058006; c=relaxed/simple;
	bh=+ayH1FX3kVunzMh8TkCRg4WHR+LOdAedYf19O/irScE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJFTnvvSX/dyJv2VOGhnAFtVsn7I8yxP9hU69q9wEE1UKFaJFYmnVyXSzzvTbXb6l7UIzhfBn7mt0eByba23OwdghHfCpeXBW7GFOkTy6ytV3tQyuwsRABXqwaJ1709xjVSlm3Da/ygYhYngXKjbfCs9RkZKjLzx3GMv/aJDksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CsALhKGH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CsALhKGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1789057996; x=1789662796; i=wahrenst@gmx.net;
	bh=+ayH1FX3kVunzMh8TkCRg4WHR+LOdAedYf19O/irScE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CsALhKGHgv1DMNVdAsHxGUQOKEbAyMAuYzAVafXOfp+iyx3rC1uqCCPysCHjbiPl
	 BN8OPKUltuTiNBHXWSKe2wbHdx8aBB9Z+CGlHg7gscyl8eey1+2ZCzpieWxCiOusx
	 01QUqoQVzrY/kudRT/ik3IU2DikLRR2Nzz1NVC0TSz+h/i5pR7K9KHLeOYrLpSHU0
	 apJe5HhLHA3Wjsgqq3iRG3ZkIksNgVLJVW2t05grXdo8kVWXJOiwko4lzEaeXlN2x
	 AS2DTYMbca6MiDW5BzKKjVF2RhEZJzq57fJ7db4t11zpn+uzmplrSIA89EvTPk2Z7
	 maONeKfBUoW5DLt/Bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1wvO3S2SW2-00Gw1q; Thu, 10
 Sep 2026 18:33:16 +0200
Message-ID: <cae27e7c-1903-4a0c-aa80-b05f9f3d1d2c@gmx.net>
Date: Thu, 10 Sep 2026 18:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
 <4c237cd8-024f-405e-a00e-e22ff9529d08@kernel.org>
 <8cd19ae8-372b-444b-bd2a-dc01221b5896@kernel.org>
 <CAAOJLPHNGgC7B=7ESCifZ1FPcR6V=Hcg-q-aaVg_9M_-d6Fh2A@mail.gmail.com>
 <718e88b8-3f3b-410e-8e76-90c370ff920a@kernel.org>
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
In-Reply-To: <718e88b8-3f3b-410e-8e76-90c370ff920a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dkbTynnLTZUsNIb4c9Q3WO41pMr8iiv7drOofwBgIYYXeYY9UYg
 nfBGblnKFxb5oZ++ZY4Y+OSFLxcDvKvINKp3QIs+UWiibTd3OpMsckPOOJVsR6PpiBlzVPX
 lImEZ4XPkCMn39HpeniisSsyB6b45SUIR7/1VA+xDC1JBMF2uYzGuZmuyqta1Kbg/Ugfo0y
 6lo3rcKgzGFhJnLd7b+mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:28hUPTmvF8o=;Lvawf45V1FHTBBTIqqDAiBKatLA
 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

Am 10.09.26 um 09:08 schrieb Krzysztof Kozlowski:
> On 09/09/2026 22:24, Sander Speetjens wrote:
>> Thanks for your response
>>
>>> And more important, where is any interface to actually control the RTC=
?
>>> I see nothing, so your firmware is? Then this is not a separate device
>>> and you just added DTS for your driver, which is a no go (see writing
>>> bindings).
>> The RTC is a physical, battery-backed RTC, but the Raspberry Pi firmwar=
e
>> exposes its register interface exclusively through the firmware mailbox=
.
>> I initially used a firmware phandle so the RTC driver could obtain the
>> existing rpi_firmware instance.
FWIW Based on the official announcement [1], the Renesas DA9091 is a=20
PMIC which has been customized for Raspberry Pi. So currently there is=20
no datasheet available (yet).
But it's very likely that the GPU firmware of the BCM2712 communicate=20
via I2C with this PMIC. Also this IC offers additional features like RTC=
=20
and power button. So this driver only handles the RTC part.

Best regards

[1] - https://www.raspberrypi.com/news/introducing-raspberry-pi-5/
>>
>> Based on your comment, I think it is more appropriate to model
>> the RTC as a child device of rpi-firmware,
>> referencing to the existing firmware clock/reset/power services,
>> and have the driver obtain the firmware interface from its parent
>> rather than adding a phandle solely for driver plumbing.
>> Which also means moving this to arm/bcm/raspberrypi,bcm2835-firmware.ya=
ml
>>
> Whether device has separate node, depends on it having dedicated
> resources. I don't see such here, so unlikely it should have a node in
> the first place (see writing bindings or DTS101 where exactly this
> question is asked).
>
> Best regards,
> Krzysztof

