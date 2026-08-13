Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361863C660C
	for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643308; cv=pass; b=Q3zIzYynQ/OIMOJXvzUGYVP38UvrStPBn8CVfu6nlmYWM3LJufDxZ/wdEdBxiSl/XHRvfbyg6eji8W/KrJpf3tO8C1Xo8DqpEQ4jdtJFXc4n7KwryhmPxrGioVF3CRuiXSJNIhvdyZsUdEOsVFI0gR5CpMsgGMx/bK5XdjreVI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643308; c=relaxed/simple;
	bh=fJN0yajHdbKNJg/Sb8r8Ae8JV9wC/JHTUgtXKZ3D0bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXlBubSUBPKRLG33lvywh1c8/k7VV2mj0ZNXjEiQzTjjX71y85QwSUiQ2rfieWDQgVNAXv6G7gaPZ6G17tWKMLurARJz0/LiAVYqQmwLhmtOKrnn+VqJZ2ozJ6Jr2JVM/SLxn+FvWW6xQdsHTmheaFf7FnnbY7QuYu3oydxTjb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ9NO7AS; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ9NO7AS"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6679d88abdcso213059d50.2
        for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 10:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786643290; cv=none;
        d=google.com; s=arc-20260327;
        b=psJNE+cUHldHO5vSTtplEIh0T8XHPvRtJqXgDN2/KDhEjgtg4blUSJ2h5HRv/EgKKg
         uRwvGk07tzxA0E2B+0W1AE/8uAkkjw+BwHK51K8vXtJ9lFgqD3JsEfBQKNYUbFBcA8oZ
         qoW91pf+tfBp4VK3n93PUk6OqtawxNxyKwPNA/ngh666VyWwQuN/ft0u9jRlSJMQC2Ih
         JSGkeWWC9WjsBWwXCNmU3TURYQxZEFmPf/xXPEiHyCCMCNFVdhKsPZv8wUHu8hQvhRXM
         g5uqUxw7Whv2UgsFNfDlaSgMf0w5LsKCXUwY0gmxl2nFNYEzcHRRlXgkCOWI6lkEHc56
         tYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xKBoZsKQChWoyWTHFeaA8fhBCl9pWtBCM4FH4MsoEI8=;
        fh=kjDTLwogGK5RDWlm2g+AbDGk8fHbdBNa8oK9sKsLO98=;
        b=JZiTcyTZAKG94zOgN5U73IoJN/u6uz+gs7EJEBB69T00UVW1fa0ogvKd7ph8ZFN72C
         JoBqJuzdJhPXY0C5ErVKC7gb5HTpkBKqC6q/liipnjwuMoicu7+rLwzRqP5pyz/n+o9j
         /nOuiPL6sK9AkNAPqcY3IDnp84DdiHB0+skvavw9mBiULsXqkc2NOmgMfvZ5fT6/XN8A
         Zg2VhlfR82InK0XcjAXmu7VAva0hMpLx/3Yl9K1xwDzSG6T14rJDm1/vTWWnlN9mhl2Y
         RaWqzhy8siQXCyUdwl2OAUyS5xY9iK/fW3kFswqsDhCAzKEyQFJIcMSRwNZArpJFyO8R
         0Hng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786643290; x=1787248090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKBoZsKQChWoyWTHFeaA8fhBCl9pWtBCM4FH4MsoEI8=;
        b=YZ9NO7ASaOX4Gj9lC9QUFWE3Rt1OeX8dMJ7V7HoqrLD6LiMWrjz/Z394NlJZGmFg1M
         Hj80QBvUCyQj8hQhDprlKVKsS37baIlbq/PAC8fYYq1U3/PgHFeQ/zJbJYYbBRHId9Dj
         53VEfG3l6Zsxt+xmcrhshQwTHQ3Sw+1uCluzXZwBpxix3KV25YxYvzvbCoV7J7+vdYP2
         LjXBXaYNVx+XtWm4U4Dzb5A8nCig65YNj06WMauEZX926U6hp0ZgG62o2MbfB3V8qfgR
         V8O/CTua0Qyzd8CtG3HLATSUTuZt4ExrFCRljdo/ouoBlqj9O6xhtRRd8wulYD/TdJoP
         1CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643290; x=1787248090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKBoZsKQChWoyWTHFeaA8fhBCl9pWtBCM4FH4MsoEI8=;
        b=TwXeBNX8b+5yYCCRdmELEELjL3TO67rASdBPOj2ufTdsOvLzCkXUPQOvK6AtELWQAM
         FkhuOiySVLuclxDmGNLpaRNCdg14ibuxk/WX71luB+PyAaSOVQzBDy3VDcwXy80CEeeX
         TJwxMsd7Wm0hyDEwfGsF5B3Zsf5Qja5KJ8qW0iYlm48F56+r8oLoBRei01WlTMyzQ4TB
         3iNTPGSv9srbHqSuMVDlvnDogeG5u2lCcn3id8vcf4mTLOJMoCfEt1LOa3yop+CaBuOO
         7rTQ+6V+8Xiw9v54Sw+a59gA58dkwsQuPD+XK+j0dfEdJwq46Xuzr1Z5hmrismxnltqQ
         mY4A==
X-Gm-Message-State: AOJu0YzfiHMbGK+kYklKN9rPCJoIwq5Z5smMOuicY2m6Vqo/fLukkkW3
	C7b/j8YuhE3RlTpt1YKAFTuu9YSZIzJQnshGGb+6esuDEmRkuUa3HNDkPJFNPub/qL9PLbDpiqi
	5aBrQyKESOIOzOWdtQW6XimtMqIh/gr4=
X-Gm-Gg: AR+sD12OCH21m4tkP8zEUmAfos6JJCP3CoPzzKgYpM36MSF+FWPqGrrXnb/+25Zm/Xu
	o8YdOrao/OvhgYhwiGOOTDzYX4viqJYOUQFDYJQ/iunGwocQ010gTAevQTCq5jsWT4ES6g6Y8Q6
	eqo3DDUFst17fM0yHIUSbgz7KUx+VQYK51nYUf0wkvsp2REgZiLiw9OEjVvmElTJEX0hF50JOnF
	QVKxfTDixUUgrf76sxT0I6B4D6CLQv67Lu5suFBFRiilh4WCeKNBC1I7aOtnQjCT0in87tb3wPb
	cL7n8CQkvRdj7F1Sf+yoqj4AgGqjcvdxio9bVOYSCd574CPV5Hf18C6PGMIqjftlIt7sT2AZf9K
	b
X-Received: by 2002:a05:690e:4091:b0:66c:486c:aa1b with SMTP id
 956f58d0204a3-66c72d2719bmr59581d50.38.1786643289594; Thu, 13 Aug 2026
 10:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624055648.127399-1-challauday369@gmail.com> <178406687202.3036881.4468660016404184803.robh@kernel.org>
In-Reply-To: <178406687202.3036881.4468660016404184803.robh@kernel.org>
From: Uday Kiran <challauday369@gmail.com>
Date: Thu, 13 Aug 2026 23:17:56 +0530
X-Gm-Features: AUfX_mzsIi5SDyWoPwPYp7HUoDgTG5O7YDFhgh4xYm4uaptfNPMewu0uSRvCY6M
Message-ID: <CAAj-GBnn8rGD6o5HmVfYtEksXsL8ZPKcc_AbfKUEHtTsN1pN-A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: microchip,pic32mzda-wdt:
 Convert to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	skhan@linuxfoundation.org, tsbogend@alpha.franken.de, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:37=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Wed, 24 Jun 2026 11:26:48 +0530, Udaya Kiran Challa wrote:
> > Convert Microchip PIC32 Watchdog Timer devicetree binding
> > from legacy text format to DT schema.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> > ---
> > Changelog:
> >
> > Changes since v1:
> > - Fix example indentation
> > - Correct example clock specifier from REF2CLK to LPRCCLK
> >
> > Link to v1:https://lore.kernel.org/all/20260620172354.155565-1-challaud=
ay369@gmail.com/
> > ---
> >  .../bindings/watchdog/microchip,pic32-wdt.txt | 18 --------
> >  .../watchdog/microchip,pic32mzda-wdt.yaml     | 44 +++++++++++++++++++
> >  2 files changed, 44 insertions(+), 18 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/microchi=
p,pic32-wdt.txt
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/microchi=
p,pic32mzda-wdt.yaml
> >
>
> Applied, thanks!
>

Thank you, Rob. There are similar microchip, pic32mzda patches related to s=
pi,
sqi & rtc which are reviewed/acknowledged.

1. microchip,pic32mzda-spi.yaml
https://lore.kernel.org/all/20260622-ingenious-finch-of-fantasy-7bafaf@quol=
l/

2. microchip,pic32mzda-sqi.yaml
https://lore.kernel.org/all/20260625-omen-stark-6bb827ebcc43@spud/

3. microchip,pic32mzda-rtc.yaml
https://lore.kernel.org/all/20260703-identify-cringe-ef88079923cd@spud/

Please let me know if any further action is required from my end to
merge in the
mainline.

Regards,
Udaya Kiran Challa
