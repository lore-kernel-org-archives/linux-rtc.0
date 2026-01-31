Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488136A027
	for <linux-rtc@vger.kernel.org>; Sat, 31 Jan 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889046; cv=none; b=Dpj6+KbACpsjARugtU5T3bZIab+WGzW3F/5eE5T+RlIGJkhyIb6JmNTS3ke7O0H6xO7NDunBESshYOppONjVmLXQYbxlj0hhYLX1rshpQ9oMduBEhv3UDZ8xRKWwO55CxnMBRD6vzaAj+JJ+xTyo+y1/RIxxERriFrY2ZVbs2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889046; c=relaxed/simple;
	bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMRnT9H32vo3FhlHmWc59R5aPf2c6DILAbPpu3bCifLPKi4wzVVK2GHBXZKIXGc6gBBRiiYPCOCQcV7TWdk61vgbTFRYmAGMYVP5qrh0m60RsT9jmFVQgaZgJjEUQvauVAWSGJxv2gPEi10DU+F+h7uBDP2xf8OvU7tgb1fN2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GWIiRwE0; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GWIiRwE0"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-460f3f9fdb1so322071b6e.0
        for <linux-rtc@vger.kernel.org>; Sat, 31 Jan 2026 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889044; x=1770493844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
        b=GWIiRwE0swLPJFHbUxLmcXD7uZZgmXuGeN7oQvIG4uVEg+WJvCel0i0OAaks2afL9L
         6uezKwjBgoreIu/valrw15ASQ53++7OzIN4roQntTgf7bq6IfTpp9hM7d0/S6d0Xfegy
         cIgLOwoSZsv52q4SkXUrHLn4tqxBRjJAPrcwxYM1AdjdWfUtsQA1jz4qLp8E64gKgSOu
         Sl3xyJDu0Hxz6aQZty2j9HO/8SGDs6t0YgYdwpX5wNwf29Xwnisl1QW39KwYSA4smoE5
         uy8b7xlgItHHF/E/Ze27LEOd1ULSr9UK14LWeo5WqIJHH7pklFAzGSwJxO4n4cpQ+bna
         i3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889044; x=1770493844;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
        b=q6GYsZKCLyxdIW0piNrA9DHdL94e0VPeyjZEc5/hGRuXZ0GlMhEnlS8eYfXkxshUJI
         wBsAPtVM+5d28vlwkyrokzbvfax2bP3EJnspG2BEiPZH9l4f7ENc/ihoIJeeuBmJHj2P
         UA/orMxPLgbeFSdLZYXDHiS3KaVonbOZ7P6fY/KhBkez59xqJDi35HBlGqoLDstZjD7t
         swbcVnc92Rn2DF1BoYiK4c73R/yin0jaTMeOscNxuso9jXbkaHAS1j0pXdhU8PI0XjDU
         0s/C3wI5iIFgvovnNXCNqjYXGfAzVWk6arIx3b05qnqNqvskmtkDjh42AX/XYtrOLBiJ
         a16A==
X-Forwarded-Encrypted: i=1; AJvYcCXg5+I4kQixkZvlE3hly0A77AYU6ickuPNYUGYXedZHkuo3opbZwAdkUpcd0gzSF7tFmiqZwACEeAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Wh5znekUM8s4YofVZ0pPbxKqIsx8fsoFxZnEerq3KrRerqfO
	ZrOsD6JTaKhn+BXCG94yNgOD5yfJrCl0AdeAIoQxnr9DAg+3jYZ7I33XjoSbU4/yRs4=
X-Gm-Gg: AZuq6aIBk4aex0Jf7ZzSHdussoUPQoLcbLQ1K/tb8aqiFwfTMMaefbFIoPU76DoB1Oi
	WbJkdyGdNq9BP6JJaWppWGHoov6gByvyOqR5nXYRWX5zVBsp0r1kWahUK2mT27dtTSJARBq2s31
	xL74MvTbdj4WKDFWnRJ5tnraV3gm+rQN0xp2rC0bNke++bt5ZIsz9R9DK/NYU6t3onZyI+ZH0ja
	+adJvmKucD40BJW16jDntEg3RQTvEzxzMA5RyPzaGJhiUT2YuLnbJCzbsXrGcuIOG4W0wLucVZe
	RQzQXbtyFGh5pdfcD0OQxuqIJ0R7JSZQOOfZuNAcsQHaEVCCHh8DAeJMPVyr2yknhlhJQ/lXW0v
	L+n21YXcPgggMMpz2w6gtrdfGVwspJdnwQhrH8h7Q1Z4BQsfvHaC+UYAkG3VXnJZti41Nh1Zqzy
	bcczqGvqxwxuDnl24AuFTey51lVE9/qGDByc1Irxdh5ZiKuiiYbJSWXRmItCeI
X-Received: by 2002:a05:6808:2222:b0:45e:fff5:89b4 with SMTP id 5614622812f47-45f1e280e98mr5623957b6e.10.1769889043924;
        Sat, 31 Jan 2026 11:50:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c7ffa49sm7655737a34.20.2026.01.31.11.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:50:43 -0800 (PST)
Message-ID: <1ae1f69b-8a72-4831-a6f4-cd7dcf38f793@baylibre.com>
Date: Sat, 31 Jan 2026 13:50:42 -0600
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
From: David Lechner <dlechner@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-4-clamor95@gmail.com>
 <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Content-Language: en-US
In-Reply-To: <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 1:48 PM, David Lechner wrote:
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
>> Add compatible for ADC used in Mot board. Separate compatible is required
>> since ADC in the Mot board uses a unique set of configurations.
>>
> Logically, it makes more sense to readers to put the DT binding patch
> before the driver change in the series.

OK, I didn't read carefully enough that there are multiple devices
in this series. So you already did what I suggested. :-)

