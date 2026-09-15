Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291003B42C9
	for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466153; cv=pass; b=P6rNQJVvgEKPYoOnz52vumgQ+4vQhMwthRFT3GHKMR6n3ASIEZaRzAwDvMZ/QAvAfVVNK3x/nu/kQVCpavHdMtesI9u6LGmghZV62LvIlNDY3PykjY5E6LSW+h7MwLbn3pONspY7ukhz8dY7Eq/PAaSMrcQ4TDROdiOM5dC00zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466153; c=relaxed/simple;
	bh=HeKvvz7zvJFqfPpm00Pp1LjX9n3idorFhTOrtCSCiy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGutm2DPHBNttlqmMzkHZ1YhH+LFBA0iJ1p7TF/eMYCg8gcI1MxvcV/afxWcSCE5FYtya5Atv5mojKFh9ZCxZjzgKiec5u/KA59FVcKnEvIkIMxRCWzFYhFej87lEHW2a/18rg+/QBzKcAeAFAEXOzu9DuVB1HJ7Kq5necVYJSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1tBxgO/; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1tBxgO/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so55513f8f.1
        for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 02:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789466147; cv=none;
        d=google.com; s=arc-20260327;
        b=X/dWNGH+Zq0Kh+hJbVC3ldPCuRdb/69SOH8FdJ3AYy1dYXc4GK5esNVr8S8770B64c
         /o/uofLFc4PZvw0Q6pax+7iMILTVikfk99fICJjTOSVatWTNWPl7TPbm5ApRwJClIoX8
         urSt2lXTTxZ8CPyRefOqA2BH7M3dxNL1gQ/fokHJo+R2PCp1OsHGUB1VtSDQ5lAMwTeg
         L7SJb0q0XKhhxn2m3uuJDS0bkRRrljAbVKTzDLtL2VrU13Ou7VCD6W38vxjztsr9nWfQ
         xv11loPE017GcC4QiluHOhvO14B6M5czuOQLwOWhOTkIuv6EiFjP0O4LL6sfQHHIvSOo
         4jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SEsT6FzXLVxpOxGT+T1rtf6sipgLJQJWYr3e70XVh3I=;
        fh=egB6tHD/UT831ro5QE38VLAVGoPYE7sSCJPzepUWm+8=;
        b=K5I+s/1JSFREIZSGSLcXqPNdhKsCJ1y+dow21YVDE/39cxlb9I1BqEUgDRww6hN294
         2Xr6z1CyAyI0tU8ixNIroVa248DdTU5AnjGOEgm27OfADSldCqka4lbev56gDHWHioKC
         M3+C/Bd3ZDBEomV3kcJesUaE9igUBjaTVDqGmI6bVPden8t/9c/NivHAGRe7aPPCoPaa
         I+Lk4aCkAEQ6wmf0QSVU+XqcGY1wIDiDCRs77Imof7rPtBhrcQYt+k+pu5KKEEu9Cw3g
         gaAkfkMQ5KCrlLKScGh/hY9DTWc61GcfRCI2yHGk3exQ5Mpz8JL+cRn2jwNjQauLOIvC
         drag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789466147; x=1790070947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SEsT6FzXLVxpOxGT+T1rtf6sipgLJQJWYr3e70XVh3I=;
        b=A1tBxgO/a9ew1Z5XI4qBWUzgkmHIOgmnyx/fmxJSyV4ELaD3YXH2pJnG/fInjXgeeM
         AAauNGhpXX9tnzQ42evvtXpd+LjSDd5XTdG+FxHv8OEp/SEDvR45cPCsNfcLLi5qBDOs
         H5kR3g65mctsELME58MpZArA9KvR33ypt7/uhHLdXibbIRVICBJ7Igh/zQbRLGQLOr8A
         OWegkjajWUAE1xGSLve/vPOlzgPYVhtvOrAxGi2p3Qa4BEfGiRa629kEPTsscgz7NxsP
         4zwRwc99jvE9pFlr4X2pSbe8QreFRHSQ3gqq6og7QgYYGJLZnx760Y5QgjDNLpFfDPsi
         0+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789466147; x=1790070947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SEsT6FzXLVxpOxGT+T1rtf6sipgLJQJWYr3e70XVh3I=;
        b=D/BW7bZSKKZJDcBA54zV05xU2rkKjhbwGhK+DJ3snAD3SIwW+epRSFR6Al1hL+Lv6m
         uXeJp88JtZJYC4cPslilkml8ZyxqH6UrCb0+Dsl/c9t0XR+Iv5Okn6oYlSp13DpxUqy8
         kqG8rcQEICsen8rtmK8KXZm8ooURAfmMg8f3Oko/n7/jPK8MFuk6paKNuY3bS9u14ZLf
         UyhdrOcMFfXPc7dAcuAP3IF0QcdPh2UaQZmjBOsTW3cyD39aqPZ2g0WZ2bLAzVnONPEC
         kmIyGoWNuUX/KN75mxQyMwqBSQPv/PKmdBjizcoLejapHM5qJiMpjU5C00f4xS0mEy8P
         m/2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+cYxrOr2WmmiKd14NVBi3jOxEN/abIXUN/x+JHgD0HbvTVYW0UuVVj4J1jvsHFEp7dwGxc6O9SSI=@vger.kernel.org
X-Gm-Message-State: AFuF++klgot/nQCYhGAPzyQZgJ9xETst+vQFfv6/SMZ2w+XoFONuKoA1
	sZ/NGHkEvUnNmO+yEyJYPJ+DJ5tsZHQbAJSOwaw0JFgqccr6fX4329JWCaQjAJRE4rGQ+STCp9O
	jQ2ZHkEKJspqFko6BS7vEJixqmPARooM=
X-Gm-Gg: AYBFou26Q/gK5FepnOsLHyvtHfAmWUQgfbuwZY/HXGfXU3V+YGZ2OAFn8YWhC9H0wjK
	EQFxFDxpvqjm6rHwVpb9olg0Gctv+wEacP22dmt/Ixhw5b+A5SRMwRjOYkloeg84hu2ATWgVS3U
	8+JauTScFv+ci9PqhEMEyQCKF6x9YY2eq61dS6B1lOmKd+F9XZV0+6BfRBqHP1f3oMLCu1pu0rV
	oW63Mjabwp1rffb8sUN+VkGKidirltpdFpcG6j6xFbwPVdfyhtL04FT+tKrvF4otIlwk4iBzUef
	i4jWAu9GoCZonUjiQXELvpEUVQ9+GbRr69i4hj1h+N8zR5mWarqiZQSURID8WjrNbD+LFnR4tYV
	zwgXRQ+k+zxqDeVva7lRg1t4fKG7/VtPIXmxVwFfX
X-Received: by 2002:a5d:5e93:0:b0:487:780:6a27 with SMTP id
 ffacd0b85a97d-4870a96e031mr15335f8f.19.1789466146523; Tue, 15 Sep 2026
 02:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com> <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 15 Sep 2026 10:55:20 +0100
X-Gm-Features: AcwNN1URPhirRROilRI3Axb3KZdRwJ_HGHfQgBDgapACZQF7IQIhq-6HjrMnUzQ
Message-ID: <CA+V-a8ssNZ4X+e31V59YdqYmoap-S1W3Vfois9oNisVT3izxag@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: rtc: rzn1: interrupts are not required
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thank you for the patch.

On Mon, Sep 14, 2026 at 10:24=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Interrupts are only needed for alarms to work. Reading/Setting the RTC
> works fine without interrupts. Drop the requirement for interrupts
> because an upcoming SoC does not have interrupts wired.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index 7ea77cd0bee1..b426a34958d6 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -52,8 +52,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
Maybe we can add a conditional schema check for SoCs where
interrupts{-names} are required.

Cheers,
Prabhakar

>    - clocks
>    - clock-names
>    - power-domains
> --
> 2.53.0
>
>
