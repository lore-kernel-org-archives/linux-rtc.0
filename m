Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C958B6AC
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986299; cv=none; b=U3hloVss3iBUqO18pwIgiakGAm0ub07a+WbAIPnpVYe7i1uwaAXrEllQTvzXpBJbjz6TrtgaQFLZJFO4on6sBSvkXDeoAlEsoFBKq1uT0z/Vgfv3AsRgBGWG1Y4RFibRimR3/AyPWBPR2eoNALXisEQkFn4Qt1OggAZTbZ2jaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986299; c=relaxed/simple;
	bh=8AbxnatoXUifDGjwqaRizi+Qr5E765H8Y73G5gm5o0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdPKFc4HlWmXx2vLDxfpBU6+38u/EkGjYMVT72ZO4Jvobq/bfmg5CYQi50d9krtj16yDfYeIE+2zxzUBodJs/mhnDcuJejpDXC4FWcqxhfpVmaPy+ZIzDMyQdaXSwoPHB8+Xfrq3hrZx9VbM0A+KmrvkRyNf+KAGGfQLo+EvMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1ZUVrBC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1ZUVrBC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso91720005e9.2
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986287; x=1789591087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7afDL+31SJFMeOGNst+LXN4XK7ERQT0EAu5rJfALKU=;
        b=j1ZUVrBCTUr6ssVDgFsnNBe/bfoX4Pw/ntRyU86Ka+7BQgDqExaYZsFnJ71vGkU770
         aDf+Ggl3HQ6RGoIe+G3SDbDA6U9+EKVDCcrNU/qczhMSqQmsNJxH3CwfDEQQNUpuS5kt
         hAoxDWyvxavJqBphdjER72rTUhC+MtKIBbus4VCnc/Wv/Tw9S+7LjFf11mO5F3GporlR
         eBaGy1wy6k+cdUYUHqB8ZqfjRxr3j0DbR705v70GpJ76dELf9vx3waYJBOC0Y+lcCphC
         TspCInNgabfcYsVIlIcH0liZhbxQ4dAv2DPa+hSar3G91sJD0E/TDX0EGD/Su2Q9HHf0
         RXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986287; x=1789591087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7afDL+31SJFMeOGNst+LXN4XK7ERQT0EAu5rJfALKU=;
        b=HH+EaqXqzZ7vqs82jAx6bz6lrEhlfaYKwO7egIWHeuva5aBuKxuqu/05XIbMszFgd+
         e2R6l/uzNCQRCbCapdS3M9wWUnBd+HZeYA283tRcd+exMPGqcIvTcqp0TG+Apr9M/BtP
         5mhId6zP3z1I6ISylP2FOzty3ZAo+qRTrjHu0FmbSX+zsQsCqzFg8LCd/WxPidjYJxuN
         Qxk0zFf53OEzN0kv0aRGAoBCZhg+YeyxkOLrPoy7uGUrFt4MR152El9fBk7D+dkls9vR
         MiJQvLUOqAnXZgq8ygcKGfKlY+7/2Rlx8UVHpbFaU52WEPkdwO2O5EghekMbmDzJU1ur
         z1UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIWvI43fNRTKJAT+TUScviHoaIQNSZNFno2Q6rR3tR+FPCXFsV2N272+6C4LTrL6Q5j0mi9esQLI8=@vger.kernel.org
X-Gm-Message-State: AFuF++llQzFi3bOQEYKCdSs5pz19fjQO+GYGRVJb9YXbmKgsrJS5A9cc
	I1S9njdvUtR/HacjkQ8UKayUzFqcckKlpa1mGP93fzW/yUp/NeaMBb7S
X-Gm-Gg: AYBFou2pQMNg4BApnd10C4i0GDA4HWelBU03EnSvTLdWDEbikxp1jjkJIW0DrXybvnC
	RTNUYNh2r5IEi87NJva7hJmRg0KM/tda6+zRyTG/E3v9qYa8RjLo+9U7A/90/W84tuMQGHi1FrE
	o+D6cszMNtqLyd41SO3hn/u7eA/60JhjHWsiMU0lrUsOJ3kxqRLpTwcG5D/g7k9qC8JoRZa4nbP
	F/pg3Mv5B7wNrVyrnfa0Z6rNNMHTQX1wBMmWfF4U2BoKmYwOT6QAIDFs6mM2OmwVCWCCnPvUkRp
	r6diEPc2+JWy8sKE8hzRC4qJ3tCUSnhcl8Pog2TQEa8C96rbju3iGycFjMoLGHI6t/3rj+b3alw
	FEK0KWsMfZWmGQfoX4uE757C1vkEb4H+UuoaKmmkZwjTZReA35bW20AfpvtECxv9ii+dgjabW7q
	TSf00kWBqwO/JF3YcPH1q5HppJ1qbsYxrDDJoRtmY4+8G+8a/u5lhnsgaT6pmiyjhEP6W5TQPPw
	i8LG11hqDEawthue38W1EgrHIQOr5UiwIhW9v9HdRM=
X-Received: by 2002:a05:600c:3b02:b0:49c:fa21:1c7d with SMTP id 5b1f17b1804b1-49cfa211d76mr359028785e9.18.1788986286889;
        Wed, 09 Sep 2026 13:38:06 -0700 (PDT)
Received: from [192.168.0.40] (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20daed90sm6913595e9.2.2026.09.09.13.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 13:38:06 -0700 (PDT)
Message-ID: <af6cf493-c84e-41a1-a4d0-0460101f33a6@gmail.com>
Date: Wed, 9 Sep 2026 22:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
 <4c237cd8-024f-405e-a00e-e22ff9529d08@kernel.org>
 <8cd19ae8-372b-444b-bd2a-dc01221b5896@kernel.org>
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <8cd19ae8-372b-444b-bd2a-dc01221b5896@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > And more important, where is any interface to actually control the RTC?
 > I see nothing, so your firmware is? Then this is not a separate device
 > and you just added DTS for your driver, which is a no go (see writing
 > bindings).

The RTC is a physical, battery-backed RTC, but the Raspberry Pi
firmware exposes its register interface exclusively through the
firmware mailbox.

I initially used a firmware phandle so that the RTC driver could obtain
the existing rpi_firmware instance.

Based on your comment, I think it would be more appropriate to model
the RTC as a child device of rpi-firmware. The driver could then obtain
the firmware interface from its parent, rather than adding a phandle
solely for driver plumbing.

This would also mean moving the binding to
arm/bcm/raspberrypi,bcm2835-firmware.yaml.

Best regards,
Sander

On 9/9/26 17:54, Krzysztof Kozlowski wrote:
> On 09/09/2026 17:47, Krzysztof Kozlowski wrote:
>> On 09/09/2026 16:12, Sander Speetjens wrote:
>>> +
>>> +  firmware:
>> There is no such generic property. You need vendor prefix. Wasn't this
>> already discussed for Rpi? I feel like every time contributors send
>> downstream DTS ignoring what was discussed upstream.
>>
>>
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Phandle to the Raspberry Pi firmware device.
>> You said nothing more than property name and type. Explain what for.
>>
> And more important, where is any interface to actually control the RTC?
> I see nothing, so your firmware is? Then this is not a separate device
> and you just added DTS for your driver, which is a no go (see writing
> bindings).
>
> Best regards,
> Krzysztof
