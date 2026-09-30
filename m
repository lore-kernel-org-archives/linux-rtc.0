Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F964ED1A1
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789351; cv=none; b=OzXF+yEhxiMowNvuHh3d5MFXKEZxAX+P3wT+wV+LhTO74eKkF/2tHSxK3UbPJZ/EOw4cu9puB95RxJ07QEg8EYfeEcSGh4kvlM5RgAAnFBXGffBpCXnFYZ6ctBVl5hQZkHze6aNeimIDnmDZG40ZvhMSybulzh4M3lr0GrSQx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789351; c=relaxed/simple;
	bh=0aLGH8brg+XpbfBkJ1rJBnFSAQBvKP4PG9k8JVs5lU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTZDeHbmcui3ooIe5qz0JrbVb8mWlwzuv0k7/JgxpWcy3e/v3ICbW8JYfRcqrm8eQK3U3bgnVwOCS3ba0Q3KqdCzYG/1FjU+uLFPTUr/sf5Dfrm21HnWslO7f2uq9swAAknnp+uBL15CCbf2HgOTHHfHdDDuSFWyHwuz6olqrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHcmdEv/; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHcmdEv/"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af929e59dso1348380f8f.3
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790789348; x=1791394148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wG87avWDvYFoGPnCxGXtYfkNymSrwnb7XNMJgIjYo74=;
        b=hHcmdEv/eJrdDL8ZnauWx1n8dx9+Tw5NzRILZHU+rah1U1cEje2lyISr99YMcUWgwJ
         7wBdZ8E/ahyj8VecEviTdOmVQSPlvRGh7hztOozKIsXYcSlobuoP+Bfq6f8ADOB8B7F+
         Ni1kpnyv5POEGBX92DlSlUCCNmY0GbqT/rkj5hROxz5T53BprGCE8yF0QMJTsavScNJe
         X+Sd6wZtCtFAwFYwrt7XbuE0/pTex9Ku4e6wNIuETZe23dk+26A9r/Bo+kzgYtHxir9J
         ipWXmwwKTfyBjPCaCYzD9U/OGlY0gvWaJAa0M0PXHFun0GVeuB71DrtcBmU2kqoXYYv2
         Jm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789348; x=1791394148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wG87avWDvYFoGPnCxGXtYfkNymSrwnb7XNMJgIjYo74=;
        b=uy0AsQNu6KVsHbzkwOudZ3lq6RHMByO7JtIhTUd3fTXq4KWp4HohyVdU8pEQST68V8
         1RVOcctzZMwW1gB8pI526UGQLieL6nLTnO6TfWWJaQfNb8HRr6acyARo/iWJdT/T4FF4
         ebhEW0IAPHExZOj9BWSKM5jtukaHyaQpvfCNp+vb1FS91HHPCSyOzXHAUSzs+NT+nYtY
         +TqRqTQHgEs6zEe/YHVagv2awTWOgZAx2WIe7nN/9NmPFX14k7RiY6W+FGcoIDUq5uyS
         C0TMshVS0K+wlKXSOOlc2DlG2hlUqlhXeA8KE0NE1347waFWVG8gIUzBtY/GD2NO5xoY
         F4Gg==
X-Forwarded-Encrypted: i=1; AKwUvBx5RnUWPuWdQwdzpNTq+upqJlxqhG/0vkQGPi+poLfUben5UlaSZJzdiyZrnJybUtcT5vQZNUmQOcQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLryIGFBzxawlvX+FjA+TYdd91AGT0kLCevCe2Ved22dUM1ww8R
	lJulzHh1kFV9CIQLujCj5FUln5yBknj8MAhPD36pkW0ifXEW0Srqwt+L
X-Gm-Gg: AYBFou2bhMQ81woVITANcbo0/8lCKDcbDhA6DzbFcZPTRQjA4c/8oFA5YNAKlQCbcUR
	+xZro0/KFY8VfKETp2j9xNixS5Qj+T59b6I/tGV+DMA3fQTgRG1C3sm+J7mAEBgEiviM7Y1FDD6
	YKwQofx82Jt5nz43ifCuP65WeoCWFarKvpLy1kaD6hjwpL6GtOOJOhdamTHyWIzzdefUPluGff7
	CLcQNFncoGFKeFgCO+1p08/p7rD+xUveZhSz9Uirt89zf3E9tYdpfpO0ZC2rJbkZ4QCpOq2YcNF
	OGjB+EcAhjMr6NQ4YR7jWahuHzAvnjr4AogBCFh5/rk7YsmqYqLARcO4xlr0vI+EEHYNvPerSix
	ESlVdtrooNKonfKwavDNBNDu4l/tbqm+QG0WsX6ELVopD7fql2autGuIziho12SbvreUF9rTnG1
	pSTa+ibQUtbKQE/he12jojY/7tzQpk8jWo+smGUOwS/9yq8VOkiCKMGONOI68MV/EvZoYoUW6wI
	mCMyA+UPbvHe0kTnKoONLvhkbCE4W7m42nnRsS7Zt0=
X-Received: by 2002:a5d:5e8e:0:b0:488:83b1:16a1 with SMTP id ffacd0b85a97d-48b0242562emr4834485f8f.7.1790789347964;
        Wed, 30 Sep 2026 10:29:07 -0700 (PDT)
Received: from [192.168.0.40] (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2fca3sm527144f8f.34.2026.09.30.10.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 10:29:07 -0700 (PDT)
Message-ID: <2872a37d-4f24-4429-aba5-34f020740821@gmail.com>
Date: Wed, 30 Sep 2026 19:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rtc: Add Raspberry Pi 5 RTC driver
To: Stefan Wahren <wahrenst@gmx.net>
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
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <7441de5b-e9a6-4080-b312-d6c7123fdcde@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

>> +    // Check if our model is a Raspberry Pi 5, as the RTC is only 
>> present on that model.
>> +    if (!of_machine_is_compatible("brcm,bcm2712"))
>> +        return;
> I don't like the comment, because it doesn't check for Raspberry Pi 5, 
> the code checks for a BCM2712 SoC which could also be on a CM5 or a 
> Raspberry Pi 500+ 
I changed it to BCM2712, but isn't RPi 5 the generation/platform name 
and RPi 5b the specific board?

>> +#define RPI_FIRMWARE_GET_RTC_REG 0x00030087
>> +#define RPI_FIRMWARE_SET_RTC_REG 0x00038087
> Was there a specific reason to not include these defines to 
> include/soc/bcm2835/raspberry-pi-firmware.h as all the others firmware 
> tags? 
No specific reason, this is how Raspberry Pi originally did it, I moved 
them to raspberrypi-firmware.h

>> +
>> +enum {
>> +    RTC_TIME,
>> +    RTC_ALARM,
>> +    RTC_ALARM_PENDING,
>> +    RTC_ALARM_ENABLE,
>> +    RTC_BBAT_CHG_VOLTS,
>> +    RTC_BBAT_CHG_VOLTS_MIN,
>> +    RTC_BBAT_CHG_VOLTS_MAX,
>> +    RTC_BBAT_VOLTS
>> +};
> Hm, an enum suggests that we simply can add / remove items, but that's 
> not the case. The Raspberry Pi firmware defines the values.
Should I also move those to raspberrypi-firmware.h or is this not what 
you imply?

> In case rpi_rtc_set_limits() fails, both limit would be initialized 
> with 0 and this always fail. Maybe we should dev_warn to 
> rpi_rtc_set_limits()?

I added a warning for failing to set the min and max values.

> Just to be sure, both calls are optional and not critical for the 
> drivers function?
> Why does rpi_rtc_set_charge_voltage have a return value at all?
I removed the return value

>> +MODULE_ALIAS("platform:raspberrypi-rtc");
> Is this really necessary for module autoloading?
I'm not sure, it was used in the previous versions when using the 
platform device register on the register_clk driver before it had a 
custom dt node.

Kind regards,

Sander Speetjens

