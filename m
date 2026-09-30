Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DC3D3CF5
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795225; cv=none; b=Xn8ApQ6RFw+LFuiOhYA9/BqJ4lqRrCaRGjGseqw+dYTAsGQW1PcqSLAkVuo6zyvDu4/DymO88/7a/E+PS8gwgXq280GxCmUkuP7kz+BefdQiHW6jMDtQ3hXPboS5UJTHdNTZyxdF0d+ZgTTRxDNsV4hL9Qwxa+hZgNNXmUI9CrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795225; c=relaxed/simple;
	bh=f6JSGPTTRlczwCRIa38h9sle7WFZiKUTSLRApuHUzSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IP6FwdG0XZAgqnyQocBq9WaO/M6sHXbqndXCNr9SfB6amECJbZQUIFddbldBchfoQKkDiFoJGl9NtJLt/CmzfDWDY66MOh50EUOg2aXijskhWGEUQksttci8G4ESq80ID/Gw7Iz3lfwH/3rNJ7fcFUanQl94Nrx4QS9ntBuYXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Cg7z7r; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Cg7z7r"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so33146645e9.3
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790795222; x=1791400022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCDOWVvvPjn4Zn7DxkNlW8KIDmqPC58h+Qgu1lcXnuQ=;
        b=a6Cg7z7rYOvaRONQPBufra77MsylkaHppxwpcka5OsZ9KCyfjQOmsk1eY6dHgG3EIq
         HH8LtLxy2ODmBnIiVebYm3zpNDZNMZZyI0TiGxSkDFWrTmzZk+wprTjEqoUyZ7Eob3qt
         7gUawi/MIiFUPAb8i2SmPI4XsBQ7JL2wRIFPcGqA/bHkHkvCeIoAzEBtbct5NBitGQ0q
         WLDym5GIXLWbWP+9tfMRJv/QRNtH+WMZgiimDZWY9Ayev+w3g7TzDCr2HK53xT/eiPDt
         1CjmBzGsJv/SMUH/+L1h2b7pGCuITCyIwOrDkXOnXXQECddPRUvA9tsTMDFqgps21P0Y
         Eveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795222; x=1791400022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCDOWVvvPjn4Zn7DxkNlW8KIDmqPC58h+Qgu1lcXnuQ=;
        b=Bg5LiiUse/qXS71rfKcxQCDwapujSdxlW9TwD9i8pCRQ5QyebmTpN5DTkudQb1j+96
         AYPbBWc8noY7OSCoDx0ZRKqLKeDdrvsyrv1fqiUBRSMR7qLLb8OMWu9F3FTaDoW8WzaJ
         Xo/FbqMPNRYO/9qL81ik2mWVe+MWERn9b+4T1bGMAJKhJcTfDSZ9ATNyGX89C4ZsiYeA
         rc0eieDCG1bzeHVCOJHXcxMeiqpecbR2c6UWODhMAFe8xtRopJQIs6YW1QWQSBdEMnKm
         it3bYeEzgPv5DJ9gLu+CV35ftc+pJIse7Sd4EkMLfp4V4tIIGStDzQEvbRXaTKkk8xov
         kCDw==
X-Forwarded-Encrypted: i=1; AKwUvBwvdT/pH0FZEYFde7qHod3Wwcnp0m9g67LkkED5CuKV7UcUOe3Edq9BuWbqQK5ruCLtxmfRybmWJak=@vger.kernel.org
X-Gm-Message-State: AFuF++nPWYEwdcSkVww9bRx6pVqJmzOSQkU2uvX9HyBUx7dAulGiYS1p
	tRkxg4o45iscNLD4qGHyYOh9CIg20JXQVvJaYiS9qUMgM/cdGxYf/cvv
X-Gm-Gg: AYBFou2r+X2h39rhrBHS+4nHa+GdV2J6jRTc5peJe0SsyWwSEnZ6CB26y+bPxZTs/+b
	qtEq6je2EdM8EuiXOFOtslOMRxC2Bv7oH9Jtaf4hO18CzmtaOALCQhpAxrdIAc3reo21Ey49YIL
	x7P0uBxZL46JoshYe1oMpx/MdabUFbWqVYecg+y4RXKtGzkYEcdDIWbbugMJxXqnBQcejU1ygIh
	3EMKe5UtYh05bcNCG9OL+j10ZhQ+Ls50r/fkDAF3syn7TMbc0fbKphIPm7p6jwCvbjN5bCTmJJo
	2hjmeL0jHrLl5N09hXPSoyonn+FWyUv7CD1ef6VcrSCu2kDOzq7fGeoCM/suZJWv5v+Oi/h5ctv
	ppkE2UBHSkHU+SEkG3GY3w6XKfNN+kJmMs0eS+y5jLZy4vHzxrp+HCMsFOR5GpHWuv3m6ohbkhp
	Ak82ee2xeSDq7+OdsqpaXJwYV5vv0jy2CVIMlmMVOpRfRiu9dmv7w80cmW8flk/un5ch2s1QG7s
	bV2prJLZg15mJhwwXkLXgt1rcklJDIFs4GVALnN8FY=
X-Received: by 2002:a05:600c:a05:b0:4a0:6bb:237e with SMTP id 5b1f17b1804b1-4a01b01b407mr37229355e9.29.1790795221532;
        Wed, 30 Sep 2026 12:07:01 -0700 (PDT)
Received: from [192.168.0.40] (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f957b83sm3700185e9.15.2026.09.30.12.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 12:07:01 -0700 (PDT)
Message-ID: <bd02376e-f42a-4251-8e7d-7c4e7579a845@gmail.com>
Date: Wed, 30 Sep 2026 21:07:00 +0200
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
 <2872a37d-4f24-4429-aba5-34f020740821@gmail.com>
 <550045ab-fe74-4445-8f6c-4a031f5b436b@gmx.net>
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <550045ab-fe74-4445-8f6c-4a031f5b436b@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> +MODULE_ALIAS("platform:raspberrypi-rtc");
>>> Is this really necessary for module autoloading?
>> I'm not sure, it was used in the previous versions when using the 
>> platform device register on the register_clk driver before it had a 
>> custom dt node.
> You can test by removing the line and compile it as a module. In case 
> the RTC driver is still automatically loaded, we can drop it.
There is no DT node for the RTC. The firmware driver registers us as a 
platform device at runtime (we deliberately avoid a child node per DT 
maintainer guidance). Therefore the platform alias is still needed for 
module auto-loading.
