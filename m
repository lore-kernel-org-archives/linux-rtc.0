Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAB3A1A27
	for <linux-rtc@vger.kernel.org>; Sat,  7 Mar 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889134; cv=pass; b=XCH4S4dNEuPgYiDhrqdlj6XnnOGZca1AyOOOtgQthIQO6LVpIy1mj2o481aoJIQG2OIZRDCwN7z15LHPM6InBiUTlJ13yuRjWeqs/+ITkDHmEvO1pFMDZT+B3s+JUugShwPQAmKmbjbM1lCeClv1C7TSBfJ4mnmQAXQRSXzPZN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889134; c=relaxed/simple;
	bh=VIWFI1y5VRLZ373RQL/JnbZVRkgBAGhKPHT1hx5Q3QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbmKCDv8qYZAhOp6DHYeJpP+RwiuvuRuLxVOTkYq2T1mXZfui4VFi0ChAzBk2KEtqRLhh4kV6rwyN7ZxTxpbR0kynyTAHDGD8mPNgEAkfXt+l3cIxkjUZgFfR7dTskK2yupP1fXPdDclL03vFniNMRkBJZQ7cFtKHx0SQFqQ+Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5dp/pr; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5dp/pr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439af00d33cso7003528f8f.1
        for <linux-rtc@vger.kernel.org>; Sat, 07 Mar 2026 05:12:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772889130; cv=none;
        d=google.com; s=arc-20240605;
        b=F5KV7+i9rNCZ+k8K+EGwXK1XaCm6WB/7OKxxaud0Bcz1cG0DowjdrZjJJUT8uqmbYa
         a1VZjw8y2fjukrwjsHs1yez0V77+XY3msYYS7FkBApXtwRhHfg/sDrSkgfMw/gb/cpUY
         pzlc1hrYb87wC0jCbOlANzut4GQZGBayrDrQaZDjpWAJx42qV4wqIh/c6zN5QamTTN7m
         0J5JvywAN6TYC84RIT2H/ItPEEMVtIwppld0R1jBXLhugZhf6kOKoVagn7oGxUPrKwqd
         6fYc64ck+30DkCh0C6Nt5lzwQeas8/8JrgzTMV5+/ikNoJPECYgf3yU2+i6DU4JB1HF4
         CrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        fh=//v/864PHR9DYrBVmnCI19BHwjOPr75az3PUFbU9jss=;
        b=WtRVb8OgLMOjh7nVi6NKZOzTVwuJoZPvXY+rZ2x0FZojJRNxlYz6GldX/bIjCgbT9G
         gjSu4yMK0dh3i7FxPyx7R25Qr5eUtLn2SqBedFufxoL27NGJWXAirPpS0azSftPK5+z4
         b72zFcl3qJWP8xbz78rJ4qvBZiXFo/L48V1zg33nphde+cx/9hP+GM/5SjZP2Q2lzG0Q
         unK5D6obY2Vv2SuzeX/2jkzTamwMD6aLtuW3fFIngPVli0Eg7UIhazl0YY6xgrvS384l
         frTFAF0aYQLRZ56eScHtGjQOhrMCVhxeveBqZ+io4mNcyb3TfK61BKlBGxeUtOvNTrOs
         TYIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772889130; x=1773493930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        b=NJ5dp/pr8J6GiCRh5o4uhYUrKCGUSZQzU6KQ2fdqE51GxWIADL5d2+iq1PlF4m3iFx
         xPLpX1/++m89Atunk0PZpshSbhUiP7NHGZ3H45uM19lskys4UdlgmxKPvRAIIaZU3i2A
         PM77oNh4Hf28RXz/B9v40eZDsJA1W5vaSuyj1mriAhSpwLvpbnsfrMnZKUVsiXyQ55YI
         YDOLeQNc7p4bA+nZi+TihsGKxuSX3tXrkua8sFEQBpbmDnKjtjYoHi9VTN9QRdngOezK
         9UL/Ndn/QhsCtmsFzhCVKhckESk6MprtmVFXgUyqMqIrmnvb/VHmIMssb/++L0iLcCZx
         Vu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772889130; x=1773493930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        b=l54SPyVN13lE7mv9yHea+XArGktDxhxZaYl2YHxCm95zMXvdgzPCfCEkhxhVEoDUw6
         1zBBbpUjaWp+8CgJ3yXvls3G5pSAHL6KfvU5dj0roh9C90cjCUU5JmknxaSMJMx46HcC
         qBq+CCOK5eIaQxdjlirJ6omGqaXLiYzp9U9PBjbnyUaShS39w5saCFo7QI5ekQ0FJaFt
         80UgNQ/PVpWgrrakPBRxKbo9wJHMws2tbxrg7xwiWG4VnWE0D0vb1C0sQWpbvh59XuLl
         lrF7fKf2QOfrIeoD3xC/KCQNi+VREcHy35Ni4wPLYa2tRaF/9ZM6dPQlkNk7xvH1OvO1
         hGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfYXF70yCu9Nxz7lT/0Xj0dNGIvQfvmda+AhaxBQmXJeudQcZavzECcu6EOd6RrPieLufYvd0cz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJGig4tHs7t1UDpSAxV8LmSpBes3D14Lb5m5+JHg/ypEPeiZ2W
	h75hYbbojJEt2mifssyQnUnzQHeRp7DxHME2doyk9Sfi/B0EpRutFz2lIZlvIAVtM8FxGHCH4IX
	qjbQHtsKqHZhdQxwB/ReXWiY82uCK+sY=
X-Gm-Gg: ATEYQzzQx8k15h2vv2RD+4a8ch8c+n7F4g4PqgJIUHzGaj9Bs4LECbs82TRLAi1ACqP
	LejIPykzifmBiLeIag9mGef39EXYOg1Y5G1usKPIYIB7N/sWWDV8QSaIuJpuSq1o0hRXsX7H6rd
	5rkgGUjotqxiytsyKlJf/hXRfZbb/J25QzyBbDz68hOkf6r5YuXDSiSESEZcDvcctqw04zOEm8g
	7TsYTwFZiTkWunvfBAGXxGRulizHIHiQiWh+8gZtRKD5pHwGgTekyOoXUXGQGk8nQp+f/qFXmQO
	RKiv+FDy
X-Received: by 2002:a05:6000:258a:b0:439:cbb7:3c19 with SMTP id
 ffacd0b85a97d-439da880b24mr9456804f8f.27.1772889130119; Sat, 07 Mar 2026
 05:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306133351.31589-1-clamor95@gmail.com> <20260306133351.31589-4-clamor95@gmail.com>
 <20260307-azure-quokka-of-abracadabra-cebde4@quoll>
In-Reply-To: <20260307-azure-quokka-of-abracadabra-cebde4@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Mar 2026 15:11:58 +0200
X-Gm-Features: AaiRm52JT8p_3rf_HqGYMWaWzNT7LpzzUhIeETfJmIKaZ646udUvob7af9WUE-w
Message-ID: <CAPVz0n3Qj78B9Ga=p5wixu5umY+uVP=Fs7K3nwix1NT2eNgtrg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: gpio: trivial-gpio: remove max77620 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 7 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:43 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 06, 2026 at 03:33:48PM +0200, Svyatoslav Ryhel wrote:
> > Binding for MAX77620 GPIO function is covered by the MAX77620 schema. G=
PIO
> > controller function in MAX77620 has no dedicated node and is folded int=
o
> > the parent node itself.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/trivial-gpio.yaml | 2 --
> >  1 file changed, 2 deletions(-)
>
> This should be squashed with the converting patch for this compatible.
>

Acknowledged. Thank you.

> Best regards,
> Krzysztof
>
