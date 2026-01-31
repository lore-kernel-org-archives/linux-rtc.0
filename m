Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CD366DD7
	for <linux-rtc@vger.kernel.org>; Sat, 31 Jan 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888934; cv=none; b=S3yAPfi0atHiFP2DzYmp8Wxzny3QwZrPohMYJFIXdFUiJTTk/bkP2ovnabty/Itr2hOU10r9ktXvSbEZ2WHT3chzsvHEi0UaSKSSn5v8d1DWaKVfghB5DudrZP8x2Vekcgl2Lmb2EhbbLZTlsciS77odL29jPMunM1bvPeWtXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888934; c=relaxed/simple;
	bh=dPpm3l3WPw7+UtDy3mOZiDg1GUUhyRC4lyTEv3mW62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+g4DqzGs8yG01IBkqxyFbczi3U/GxLT6PRa5VuXms7mqV/cyyikcG2EfOReHFWbCvhmzxqhtnEro8gB1D0gHROO9KpyORJFQMnBNRzTebzQLzfiBQuD5EC2y9DNvizIGspeDb8gqqoh4qaQchB27O2wzvXGtw2baWHDWr2ry4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E0yl4gOO; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E0yl4gOO"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cfd8ca8191so1281464a34.3
        for <linux-rtc@vger.kernel.org>; Sat, 31 Jan 2026 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769888931; x=1770493731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=E0yl4gOOFJpyySVsDmn/hpM5PSAkXhwDmN9vu9ibhwoX3SIpxHFAmf2pflTYaKtDtm
         AYu4l00lCHJz1k7nAYHzHA58SXe6YDVPOgq3+K6ygl84RCCfWQNYwj1fCbmIVYcJ6QG6
         urTM6ZT+706m23jvUGoDLMc2HgpxbbwWVqQpNXevw0ffTzxpQPaI5lqJK7qvVf3F8iYJ
         T9ZDnE1wyUl96tjA1xkw26atNQphlfRMD9+EyoMYas37+ojq0jc3ZB2px2e90PpVQ2d+
         J/2ClZEYAFJZjDkVIFqR40XT6+zEsnciAbNGJUVcJV3ZYTh2RveYHNroMvyjhaA4EgB1
         qegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888931; x=1770493731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=dgDNrExtce61+ucKM21jGAoFbdvVJHyXV/SxfAbVaBNZy3vrEQRfXGDfJAM+neVPyB
         2dxlOLD/AjrRLnv94cifekTGvm2wnkgt2b3Mr/rDPVNpn45MN6Pt19T+v4A3hZBgPEp3
         f88cIy5o7ZwxBbmg/tzHN20CdgI05bM5hlJBjRBG7OHwcVe59hjSHfofBbk1WNA91mY/
         zosN9nKnYM7W6F70Em7gQPqeSGVobMOcyxb0xf37xcqcGcPxkgKZwp97prgaM0EqXQhO
         u8X3ml+XmWv0SyxlkKtgxJf0nE29jsE+O6DNgpGxgn7+cl7Ofq4i8vj0IPWVCbcYilM4
         lOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0piI8qA0jyJVTqcPlY64+sCx/2SV+y26N2Se/C0IvEVGuRIp90QJDf4J1A1i4PBbYku8ouW0Nvmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EzCCsnPmi0xVlmPH8rhvwLeO3EWTKMvLV4rci5pHMVCMmLO0
	sRIF9+ncjpOooXopaC2tyVntEN/pGr80yhlbrJEAYZQyC3MD842VYViTl+/dDz6rRC0=
X-Gm-Gg: AZuq6aJX1ietx5L6rIC5vAb6EQY9ta1f+tcVRFDIZp/oeQ0oLdmCjUKvPkM0I2h0n8W
	cj5TmYU8FX5Tzabh7Qe17bJ7rVbken3fl8YLuKntSl/VIUVHeBmaSvKO8VlIt+9VAPednf0XoWt
	eIyE+TxeaqXkgkAYPCPlaJOmPli/2cQqy1AuLX3VtCThmM7ittCpWgWWK5fIUYulC5w35kXFig0
	U7ZAkNecFTm6Wuvf4tpaUE+2G8nlmbxGUdfNAuCA0ykEjTvKU5NUKY6L6shhdeYxGg9FMu5GjM8
	Pff2G4BUUJCumFiHEQwd8wB/uDJbNKACTJ+nqnWv4YlWYWXUEx9XXezFZuse3dHG7F9kJrkm3eu
	726MVHzwNym1hVC2Zq/PB4pe3gX5Bd/LP9UrRdV4d0W7M/InsD+PdYSHZx6izSmic4qodIdzP/2
	m00/rhDj/BBgIlNoyGhiU0Ya8n6I9F5kLg6jTu/jPiV2EHcoRFCAO4Tj681H3O
X-Received: by 2002:a05:6830:82a7:b0:7d1:91c9:9e5a with SMTP id 46e09a7af769-7d1a5232569mr4532126a34.8.1769888931469;
        Sat, 31 Jan 2026 11:48:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm7778648a34.6.2026.01.31.11.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:48:50 -0800 (PST)
Message-ID: <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Date: Sat, 31 Jan 2026 13:48:49 -0600
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Add compatible for ADC used in Mot board. Separate compatible is required
> since ADC in the Mot board uses a unique set of configurations.
> 
Logically, it makes more sense to readers to put the DT binding patch
before the driver change in the series.
