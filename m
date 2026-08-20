Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C573876C4
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201979; cv=pass; b=LCy3zQOnnH540LFDRRyGHelEX29V1vRREy2uuFzLmRlG8DydhcNxgCtiQD6jkWeQEEJMFCOZ9GkbbAYgNakApaeVcbHJd2Ap0tTKqsXuaIiPCxwMozF50RA8PsxQjavQT4WnBWG3G6bm9yqwRwklW17TCJJ2+NdyOR4FWpSmQFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201979; c=relaxed/simple;
	bh=zufc4WX0Sg8gho1/+Y5XWkaUuA6TVrZwSLGFlBgxd/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY6whS4MNqiATPyRA4TPMq7Yy6xeLezx6X4VcGBFYM+Y8eB/RLcl4juTruOh/IvTmONkamghdI7ugyfrkPaCPRQhgDiUujw+JMTeJRZ+SqPQMTZJ7zUQDPBkqnjV4zkuY1Qj1uW+c1rPKJwo6S3FPEcGLfVbIc5/7YYuwHjAtaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMB/tPJR; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMB/tPJR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so20376675e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 21:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787201976; cv=none;
        d=google.com; s=arc-20260327;
        b=FaerQMh1KMa6LiYNw73Fhji95WUm/OXYWsa0EFgOOj4PXbjtXlXNB1lKr7k683L4ot
         4yYjZ07WNEPYHF+VmIRgoYscBscubMOST+R8jn0Z+CQ8SlauiggzfpEBiDwrhhDW+RLR
         sCOSzywueUF0Sr9EZ3m2Jc5zNIcMYfn15C3nqpOL5H8UPoEUHWSkbdyM5FsanyZccvXI
         ONUrR+BVQPTYlMgqVddioBRYMEMoZGWulu7nvjozNLb/5rnH5rdB0e+/Whr2UELBErIN
         3DcyBM0B/LCpgpFeHp27IgBbK4klWFL0YmPMxjid9FRBkle9IvAFfEg/NB53g9UJVRqO
         zp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zufc4WX0Sg8gho1/+Y5XWkaUuA6TVrZwSLGFlBgxd/I=;
        fh=6crY+wEDsY938832OYLe4xVHjEhydvOqLWX6tAoN7nA=;
        b=snjAcXgKb8bBWAO6CoqXbPtnTFjetR7tPf3LI5GxWjzk//zfdKGwTQe8cCb9NEGUsl
         ounHZZach6ky337N47B35eqbhCdZdDM+2zfkAX1BMcLf8a8aje/59ZzBxCfhuKaNxu8m
         izf74SMFZOtOFzqhJzCT3qeFbKXr4YFKk8UaREGMaeR3A7VFOdZ0zZBWg3ZlK9vjVjld
         5ja6rzjeiQJibaFdbooJNQ5UOr3PESW2V28CtD4+qg6ylPmWjPdWrNnm9GkKcI63BN5b
         TJVCdCjgV9Sz2W+EEBEgWm5rXJ6eVPHyOZqMYpIQcDVUt0TuZ1kgrZyi397+G3QHKAjP
         hTBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787201976; x=1787806776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zufc4WX0Sg8gho1/+Y5XWkaUuA6TVrZwSLGFlBgxd/I=;
        b=AMB/tPJRpP0yo/7wc/KwrSsoaov4t58vg5AVy7djDas6d/DZc/hwAAidTfhkEAbo9U
         Z/an9Hf8qGkUe937AY5oQ7GcfdwDuUnUh+khKjvAPnqPdURYkYpEL536SJlQFfP1T62p
         vpzxHkjxuCdu96pDXHnIhn88kyMG2dxMVDMQORxZzS7mcfg4fxuqc/NnX6acGNAdwf5s
         OGkmWdqHCJE01m1GeCs/uiiKYoWxScKsv+1YSxXNFsglepdN5wT4FI+UShRdqk1F4CIZ
         F8aCsb9cazwhngKGAH3W8IcaqLCOCSCekWWIg++mdDDaEfxCzDBsbD95PfbwfXmA1LII
         a1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201976; x=1787806776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zufc4WX0Sg8gho1/+Y5XWkaUuA6TVrZwSLGFlBgxd/I=;
        b=ESW5dqHNJ1cZaTAtZmkJBWYID7UaFJ7xAB9n13E9/X/5BIsxfYqcA7UCzcHK1SdbWx
         cncW8apj34w4kXBF+gdNmY50mHz36hqM47530faChgtnzMbUvBkwh46ZQLuM2FF5PYXp
         EZ4hvo2HJBUXty8UraYs1DoODlKSOGMs+OQ2T/jQPkDBXEukKGIEgAHO1yCmkG4nyOxp
         4t6oJsMhM671cNslg8azegt0h/HVtHjnMW5LWeQOwKFGr3/9Xyp/BpbUsMp6qz4Y06Yi
         yGsMtU4R6rvA/0tIexf/9oW8koFJqTIFe3h4vUOEfHbyAHJcnnHcHY1SkWT3iBhO9MPY
         Iy2g==
X-Forwarded-Encrypted: i=1; AHgh+RrLM9M8X7UeF6TxYjaLP+eMWv43CLIcTHIoI9qCfAmwPnyaFXWJZyHuH/jgxU1ZCDglMXS7QNX9AP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDLIvxqs9cOky6jyYM2liEDa5IcD8rarRyVB6j5uKoikhCQjm
	WRF7fDQeuwKU6niZm1MpYjw9pTuAuAbfm7co2vMfcDJ8FssKCnrPegs8HOcEQtqCBvwFe7Ipyzb
	8mU8sUYe2S6wTePSje8jWLuIIfqH+uVk=
X-Gm-Gg: AR+sD12B25UgmJmfZ+n8jU+beDuslIiAT3G8S2vk2hf+8eN1yVl7NSZoiL4LUlUVXAn
	VzDKaxU/ar7iDaSiPQnZyDESips8cwN5lrgIr0EjOpsoKxx2aEKDgFWrOlnNhpumNwfaAC04sKC
	01KfAaFawMiBcitz163kaY2+0bYKVS3NNQIddBEC+/ZAVHh7tHfVXs9EEt9f6h1givdb1QzEvut
	7LKstiMOIZAWJwcObaATGmITBMmeIN17xvZNt6V1OgTPiU4YGhEOGuVCojB/5PsH6mgS0/vpLqu
	L3TlrazDP70h/KyXwTcYdE73SzGO1Qb1beBX22o0smM5+8lqiWy8XLJr95hYbFFjNYkqnYRA3Dq
	iegoIAULZbC2CKpCikTK61nDfYPHq4K4=
X-Received: by 2002:a05:600c:4ec9:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-499aa167256mr164468515e9.7.1787201975975; Wed, 19 Aug 2026
 21:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aoWsgnsw5gC6TCj5@shikoro> <aoYIF8zAoPNyJxXM@ninjato>
In-Reply-To: <aoYIF8zAoPNyJxXM@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 05:59:09 +0100
X-Gm-Features: AcwNN1W7S4-c--YpoPqDr1HOqwCpIkde2HyjoAoIKaemmqpjbHFxtS1AgXlkzFE
Message-ID: <CA+V-a8uuGAASraLTEk6PGWR-NrAn0xEAZBtY2_P6-6m5O9ihzA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add RTC support for Renesas RZ/T2H and RZ/N2H SoCs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 8:46=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Thanks for the quick update. I have done the review now, but still need
> > to test it on my N1D board. I can do this maybe this evening, but surel=
y
> > tomorrow somewhen.
>
> rtctest still runs fine on my N1D, so for the whole series:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
Thank you for testing this on RZ/N1. I'll look at the remaining items
and send a new version.

Cheers,
Prabhakar
