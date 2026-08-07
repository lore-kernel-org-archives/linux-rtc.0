Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB331390C90
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123431; cv=none; b=uN3VZKllWSiQmU95t5biOWlDVQ5WdQqKuFfk7AZGMp1yf8ejdtm0MClawdiVWVIHrC8mo61hbn87vRTwFFrUCMbHVWMEShlENwtl8PGbsemMz698b+TJbKmedJRk/1zToh/uN+LSskzgyPyAH2sKnozutvcSCrT2SWYyogofmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123431; c=relaxed/simple;
	bh=b5+6s7cRaD+WPG+s4777S00qOcnE9y5+EtT1GZhZ2W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfuNaGPafvJ13PyzGAMs23f46p/g6gseT8jdvqaVJi1vv5QyhWWNSPI0/WG3dunJ2c5ZeK9iVtrjmsy5eQjSln80Iv2PdWfSL5eQGx+1DczUkEgbZdsE2355uO53ko9ByAYdLZHxz8c90WGrmtQ8CY04+GcmRG5a7tu0ETvEB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWo8BwuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWo8BwuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBF81F0155A
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123428;
	bh=b5+6s7cRaD+WPG+s4777S00qOcnE9y5+EtT1GZhZ2W0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fWo8BwuNcmOGAUWFQLkWMWs5FyFp/Bw7kBHQPomavEjqezdgKmwOzWu+ZfGhVbLEh
	 GqbJmxzMzrdfDLA6EmLFaiICOTVZ9DQnkwzZILiAO6yZTLqF71dwiPmCjlnATbnyfT
	 tyZc5WxF3GnhG661H9bBufjr9/+N539IQsP5RjCEexLH1pEUy0Mgf3MRLJk4bsdv/p
	 1fblhJV07mhSrLh0zQfuLou/F8Gs+JlQ8Rls8fxhoGlwu8OctUVaRV/3L0drArtkz+
	 4rTJdZJVGyuzUnGOEfuHfIrc9p43UYxa2NBNzSBYFMWbYWoFIwjzGa+RO+WVJxtxZf
	 W7YqGcistO2bw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so29020251fa.0
        for <linux-rtc@vger.kernel.org>; Fri, 07 Aug 2026 10:23:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqhyenRtvoAKuA2A4k62lYeNmQqT/CH9vnPXLUxviPEJ/7EJyIkSbGfCDj2/PfKSvtRkjVkF1TRcyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0KYRKlvZEjD5tz4VHnKW4hIcgQnnW/HDsM2CUyd9y0WETF+b
	mM+4vcHMcZhDfK/sCHK0amFNVirCODvOZ/YSbS0kqROriNzo4yCym/QraOHeISbaGOBEk09zwnR
	NivifigryKhG2rnw/QviReisq424ejgM=
X-Received: by 2002:a05:651c:2122:b0:39b:119d:aa02 with SMTP id
 38308e7fff4ca-39fbae0b8f8mr29204031fa.5.1786123427162; Fri, 07 Aug 2026
 10:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de> <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
In-Reply-To: <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 19:23:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbp5v5oy9oas3q=nDEvdvmPZpX71eHwEUgSKkn4bfCkQ@mail.gmail.com>
X-Gm-Features: AUfX_mwxc-wD_DVhl85t0-cdNZC5rlPz-YW3X4nrBUoCVUhyUW7RnE0ImXvu-o0
Message-ID: <CAD++jLmbp5v5oy9oas3q=nDEvdvmPZpX71eHwEUgSKkn4bfCkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Michael Langer <michael.brainbug.langer@googlemail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:32=E2=80=AFPM Markus Probst <markus.probst@posteo.=
de> wrote:

> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
>
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

This is a bit unexpected but I really like how this looks
and how it is using pin control!

Yours,
Linus Walleij
