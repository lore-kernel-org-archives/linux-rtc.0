Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCB3E5ED1
	for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100857; cv=none; b=KIIPt5K9IaJj5SO2HirYVTEL7dtcqm0edCxD0bE2MhayGOvJMr1cESUZh52kQMvj94AJ4K18rkrvi3qTxZ9F3wAvTx5SJwPBXBUKwWe1UAm3/nSQcBXeoxEL61C4UAE25Pl8B03q3SWJwaUIiXSQVdytDhPXKho40MiaMDI9liI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100857; c=relaxed/simple;
	bh=KjXa5CpY0t7/Sea2aeIy9K61ObkwGdgMdzuD+QojuEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl5IItgzP3MqPZyFZCaE9J65cMamvv/TMZbP23tkD4m1ih4HLd8p+GwWKvUn2PWbIGl0p3npKwSiiTKaG01kQ47BcoTGtYtIbwWO3cx5wKpSyHmPH41zm6+rO3yjVAnH1V5vdPyWSvvcRrwWt5eDJrABVRO7ps+3yysJo7kQ44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzXa+3wp; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzXa+3wp"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f12so470116e87.1
        for <linux-rtc@vger.kernel.org>; Thu, 10 Sep 2026 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789100854; x=1789705654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeQKP5JwuVTGflKEgsNGx/HQonSB5aJLQdw22Qx3ZnY=;
        b=KzXa+3wpOAhFJfdBZDYNR3Dt4r/SAU9rer05WadCZKIY+bvwGqsQM8lAF7OdcS4duN
         zsRRwYb1qomO/+9w+SiV2rZ5PJ3GYUXHNYkRuGMHKiIYde4HYUzubGvYYCPAAg+Fb90l
         r+fLNEKR0sZeJ94awn7m2Gk96YkJNloduzFmy7C3hzn9lnfZBUHs7DJ/nk0jhnU0n50y
         RhepHT+IDsyCBo/iuJyHRxr9N1YipU3610CPH/k55eao//JYqfGz523y0K9whByZMF+v
         Ou204Jby6LqYpFAljxhERG3OF8QJzCBUf8QLnoz9lODLswTVxsDB9LGi0biTrXmkbbwG
         cx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789100854; x=1789705654;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeQKP5JwuVTGflKEgsNGx/HQonSB5aJLQdw22Qx3ZnY=;
        b=LSKTlg/ucVQflZP2WXsZKPoUozM6XqW8yKDI2ma+p+UsQmcIozrz1QBJ1pCEdnYnPW
         9i7RzfZKIeGAofolTRqneFfYw60k/T02WtAF2CyfVzQGbHeghl3MuEg1yVEK3LhcBXJz
         ca6foTvu0tsoucjk/RCkPUrIrDjgJ9zBJmGywKK44e4zxR5wyQjYMS5ra8wcs3aBab5Z
         3fN3Z1vHy2dPxVdT9KmSSCpFlZThYkoSaTHXMsk4/MW/GguNe53XBuax3Y0fD9RRJcbK
         UMFRFms8Ld9znab+00Ha7UnBxiDSvyr4I9WL3iL4ZS1S/eLsgVR1/jn9THkzKEf73rsU
         3Bjg==
X-Forwarded-Encrypted: i=1; AKwUvBz+sT91mYih9UyqWGKvbPAKJ7DQG0bXTMZdK4C1iJNamfTIVib7wi/xDR21mDP6AwK/Q6K1Yg+PlF8=@vger.kernel.org
X-Gm-Message-State: AFuF++n7jGVXhbZWRJ/rI8K+a5vECzl7couekW6gqIUYefspThFFRxbl
	8uqQ9tppNbFhQQ38kY9paC2UZ2niDJurWX/35DGseaCdjHvgIpZBRf9Z
X-Gm-Gg: AYBFou3yzt3RAEqRR5JD93uS60AcEWuprGb7PP9/hJu06BTmwZNR1mJMad01xbPltCy
	mO7b5ckapk/jdrmRw0ZgowF/jsgaQ/UjH7HZqKrC4UGmq6wrqJC6zAKqr5X48U6KfCvi8xkZcS1
	3dw89A97hBFsgM2q823Q00RVU1buXVaA+QmHGkiTlGbb9vtWFC77kqhIbx0xKRN8DRL3s3CysrU
	U+yQ2f6YccKyyvN5Hh/aC7P6JxaqJpfsG5cI1n0uTctKuM0hZbrCnkAArVWGpOhEbBl0CWtF1W3
	wknMGT/c0uFlAkL+OJD4guw2UITnqpoOymv5XkLTC3kbZnygVjCAj5A5P45ox0+lecAD4HuTZBT
	1iPuX5hpe9NGdKJFUOM3VIIiVVDhl1qTZIuwI6ktsrDF4zMvonrLL+f1XLCNLjvRBvxhVA/qH61
	yJzyHt5uIEDCwN8cdPg6wgsbd2RSVEBRBqTDyGQRK/b6uBhZS6YOekEDkUiEj/j9mncu+84qXDU
	4ctaDDtCpZC++1k7vH8SFAJM1bmOBPUWMftLsE3j9t+N0L1I8MYke4=
X-Received: by 2002:a05:6512:3f23:b0:5b6:6af:4e0e with SMTP id 2adb3069b0e04-5b8a02dccabmr896014e87.3.1789100853635;
        Thu, 10 Sep 2026 21:27:33 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0466a5csm291547e87.46.2026.09.10.21.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 21:27:31 -0700 (PDT)
Message-ID: <eb18485c-50db-4823-9e06-362b968699cc@gmail.com>
Date: Fri, 11 Sep 2026 07:27:30 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Support ROHM BD73800
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
 linux-rtc@vger.kernel.org
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <20260910160321.GJ1051768@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260910160321.GJ1051768@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2026 19:03, Lee Jones wrote:
> On Wed, 02 Sep 2026, Matti Vaittinen wrote:
> 
>> Add support for the ROHM BD73800 PMIC and compatibles.
>>
>> The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
>> LDOs. There is also an ADC and operation amplifier intended for current
>> / temperature measurement and accumulation. RTC and 32.768 kHz clock
>> gate are also included. The PMIC can be customized via OTP and it has
>> options for operating as a main PMIC in multi-PMIC installation. Some
>> of the pins can also be used for GPO or GPI (including interrupt support).
>>
>> There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
>> the SW-perspective, similar to the BD73800. There is only some different
>> default values and OTP settings. The driver should be able to handle them
>> just fine.
>>
>> Revision history:
>>
>> v2 => v3:
>>   - Rebased on v7.3-rc1.
>>   - gpio: Use gpio-regmap as was suggested by Linus W.
>>   More accurate change-log in individual patches.
>>
>> v1 => v2:
>>   - Rebased on regulator/for-7.3 as it carries dependency:
>>     f29a8bf6fde1 ("regulator: dt-bindings: ROHM PMIC state-machine voltages")
>>   - dt-bindings: Various fixes, split generic stuff to own files.
>>   - gpio: Styling, return -ENODEV if no GPIOs found
>>   - MFD: Styling
>>   - regulator: Simplify dt-reading
>>   More accurate change-log in individual patches.
> 
> I assume there will be one more revision?
> 

Hi Lee,

I thought everything was acked and good to go?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
