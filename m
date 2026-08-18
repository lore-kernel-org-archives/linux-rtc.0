Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33386360ED6
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063864; cv=pass; b=MsVQvos7AhvjGgn0ZxEVyqY9UocioiFUala8wd872RurqwTsBqIB399YdGCyjrIIrhbIHQkTemRkttg+83zZC2kDWJVcRrNtwBecilbKIJWCghWu/PmkyGr53r301RjiAN3vWOJsMyXSuKV3WS1vsJK1ZtegpOllkurfAHWhg5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063864; c=relaxed/simple;
	bh=IBSqBa5sZuE5sG2ci2wFJ2FoiGRJLttrL4EX81T6A7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI5BZOGNB2HZdzvNtOS1e/0MBfaMXo8CgoNsVFHbY5U1fUOGbx/6pFug3o87Bi452kcDMUz5yFV0JMq0oYyOuJwkhQewIIS9U6s04DT1geaR0hJj8X61IurNmPnagIZL/KUOcAmZnv30GighjEFLCmKnKCSlzCWgR5hBrwevuAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E24Sqg3O; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E24Sqg3O"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f904e80eeso4575094f8f.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 07:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787063861; cv=none;
        d=google.com; s=arc-20260327;
        b=CRYxHxZc5uBbqw1LB3TaYQ0JB9hdqa7Lr2HsjW+cXaqkTnn3XtJii3EYcd+/WAgJ1P
         lt/Uwr+1xtGN2jxS3qz1g56HCwnVY5im4/LZ2dHORVu3mq+/5xe14Sqyqe0NouK7Ssgx
         f6xa+dBNtNMPZQNJjD7maruPuCyWUQbyxMB4s+JG/ENBd0rsZ538GoQrcs36JvOqXNKa
         WHfJ2NrA62/yGfoWUSnzzK9auV1/6e23ZKlUzi7V+pFRBr5s9TnhsTBKO/bxXzzsnNJI
         WmYf1IELf4N9BCZzErIAk6uDFdPXa+kgWQIGIvZ4kU998lUEiQXipeiysVr5VV8dZUhJ
         MOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=neKK3Po+sGuDPlDODHxSwX7bifhtt0H9rpNkrMSfYKI=;
        fh=NsBedscNuy8CcXc7aJAMICmS2ljAblWw7emkDsM79PA=;
        b=nbTfrT6974vBvcCWpS2JXTu0axjtps8S7435J7NzhYrKxzBWJNhSSfcffo2xj9LPFJ
         KgSHeomssvzUxMt/e5f6bMqSAtnDpS1lx6qVSTkkdrUa6jHD0n8YjqwgrRkU51B1eAQq
         uiJxa+muFMV4rKV9VCEUUTNtLQIsP7R00CU0IdwOPSwIQGB8jvUb2SYGxB0VvlGv9gHD
         VZO24oxQJlkv4qxQtgWQ/TNFQfFHONKq+JRkFQSfe4e3NFAtamhZQEMhfUcBZkgkGPqX
         JUZZTZcqdiuy4A/jm3NPlK23XNbCuDUcAJ9fmxS+KQqtmif+JJdUft2sP058xhemMJD7
         rQtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063861; x=1787668661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=neKK3Po+sGuDPlDODHxSwX7bifhtt0H9rpNkrMSfYKI=;
        b=E24Sqg3O+3Jd511y+cKzRx3tpy+SZNq5wIYMFN30s9983UipPXlGuoABWRLSZHDwxw
         fAF3+DcsWsDH2A/u2h2jRfig7k8XGzCQM26JijOY2pnsTxaHEQAkdFcxqBUsBIdUARK6
         4P9Ce2+n/MRCT+IaMTMVjlo7VhveSu1c1pA2X+mez474R+4q7RRIMjLRJ/Yrj713b0b3
         fTF/+OjHOypaPn33buMGLoYU2rLbjpFH73WrzhfbxinHBbzJKWayznwhN1Ls1Tayz+Zp
         vTxdzPy41cqg+wK3OoxgSJVh/0ZBTnn5VaKa0cKih4v+RO71dbh96XjuJX1I2s9e8N8n
         uOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063861; x=1787668661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neKK3Po+sGuDPlDODHxSwX7bifhtt0H9rpNkrMSfYKI=;
        b=EhZyOq/0A9YNF9eM+Xp52dwHOweOZOaFQ84U5+lbyMhb67iPlqwYmG6qY4Q/vgNn4G
         rKiTqB0cfgHu51d4xMM5uRXwtcIY9MiQhwdgu82Yxrx38YFBj2au1myEAS7xBIV7CX8u
         pfjmRqqRDcWlHVN/y9ipXrfwUFQnXas5tBX5FvXU2L51TXgL24ePTicu/piJr5nFFqQX
         W9ZQTL3jblY+Mub3D+mvm8qLUMKV4dAQc6EDQB97hzX5Mkh8p5K5d1PdS3O4rKhCzrLF
         1erT13ajUqe/jgDrkGqe2rWKduf64WrN7tENpTheHGqQl2z4Kg7khnrlGUW5l7A8LGqZ
         r+mA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/8Mjc8aRPDdTc3mm7zf5B/F4chi2SVqO04VhEcm8480xlepOA3iGSn+crvF5dWu17HEkWSxWLhok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC85qr79lIowAZZpT/DesDezsYAfaF2DoVATqJA8i9s7TACvTd
	ylllNV7Wc048kb9EkTwtOm0NWGEClX0r28JEFtBg0F54xj9CoABKIwatO9PQLyZuc/kpeFdl4DB
	AqT+fO5nqiu5zyV3gKunWOtVZGceobSo=
X-Gm-Gg: AR+sD10FxKoAhE2LO/9VChpg9utl0DPKUZWe6QSv4ODjrwX1FtqAyGoKaFFHgRUylha
	VEm6e4cHdEUYqKQ6q/V2MYrVVj7xIb7TzRiyw6afRkKeCtEJrPQA7grNlFT/MEjie33C2e4Uxvz
	/TXq+bDD5gjn2KRO6oGiKkNComaz0/D2Qun4PU/qXPez3lgx3DMjX9N1g4Pv109pBhICfg/o+vw
	ek/3TMaNTZDqzPP6dU+HwNrLx+3oTj7mRYQgce+5X1TTfGz2Q1cZBpdCKMfcOLakqA8xC5JLv/0
	TJk17qYb657hP9Fy4Sv4nusGkDvzoKk9VjwxPBqiUsKxH6mEjpqCO6sncwZuKwCgcvEcmxI+xaM
	9yzk/3Ln9xhHoIozP68KRBiiOP5TQ77L2OBZK+hi2D4V+HbDqwUZk0YsnCZ++dUA=
X-Received: by 2002:a05:6000:4387:b0:482:abaa:fbc8 with SMTP id
 ffacd0b85a97d-482abaafd4bmr9687806f8f.2.1787063861449; Tue, 18 Aug 2026
 07:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <aoQ4nMR-NeV3FFz9@ninjato>
In-Reply-To: <aoQ4nMR-NeV3FFz9@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 15:37:14 +0100
X-Gm-Features: AcwNN1XTiorvtf8oIvzxJNwW0UUvL1-YI7zD4R4i88syKxl9raPTSpiWlkJvKJc
Message-ID: <CA+V-a8uCt2_Vc7A4iFuiCKmkcrbFCi+0_uoWe_Xx=aT9=Fz79g@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] rtc: rzn1: Dynamically calculate synchronization
 delay based on clock rate
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

Thank you for the review.

On Tue, Aug 18, 2026 at 11:49=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > -             /* Wait for the counter to stop: two 32k clock cycles */
> > -             usleep_range(61, 100);
> > +             /* Wait for the counter to stop: two RTC_PCLK clock cycle=
s */
> > +             usleep_range(rtc->sync_time, rtc->sync_time + 100);
>
> Hmm, 100 seems more arbitrary here than in the original code? Maybe 2 *
> sync_time like below?
>
Ok, and I will also update the comment.

 /* Wait 2-4 RTC_PCLK clock cycles for the counter to stop */
 usleep_range(rtc->sync_time, rtc->sync_time * 2);

> > @@ -444,12 +445,20 @@ static int rzn1_rtc_probe(struct platform_device =
*pdev)
> >                       scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
> >       }
> >
> > +     /*
> > +      * The internal clock counter operates in synchronization with th=
e
> > +      * RTC_PCLK clock. Calculate the duration of two RTC_PCLK clock
> > +      * cycles in microseconds required for operations to complete.
> > +      */
>
> Too wordy, this is enough IMHO:
>
> /* Calculate the duration of two RTC_PCLK clock cycles */
>
Ok.

Cheers,
Prabhakar
