Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418633AA9EF
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345054; cv=pass; b=G9JvFyo2ltc1V0len3WIHgUdUT5/UuDJ+xKsquey5VcOWnGcYHhGQcU8tCBkVakS1r1Jep2LGDPpxPeMo3h3L3GFXlCj20w6vCz58uTHhQt4Xq0c8LmVOL42IIdcqT9H6Ekkeql+Q8MsyZ6I+jDBxPbjpWl6mdm6T7gHa+29KS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345054; c=relaxed/simple;
	bh=pfqUIoW7PHPIYNNgFH4u6pCoFZSchCOkft0xZM8GW1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHjkuHjzuM7v/b1v5m761q9f+PMIkNlIIdhe3hiFBEcsTLdhIbWEXqxybCQIMwpx7GZ0lVlcXECsQnHbBNskYdZHP+pdeO5m5Ees4uRHi9MJLA4jtPDCm4/NDchxD2iJPRc7C/VHyqCklJ1fumYfg7uR4xNdAvWEZ1ij8uTS5Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4RUZzef; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4RUZzef"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so738587f8f.2
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787345049; cv=none;
        d=google.com; s=arc-20260327;
        b=Cki8USVLAkd0qRONpymjdGImGoQEeMPDJxNQdzlAHd6Gn9PqT8pamj/6JIqEY8b/VB
         FHd3iDXtqYSU+1YlrowwjHTfOIwyWnrWRgmuOmOXgQpe9/lbRGRa8HrRawpB/4hvtJcI
         sT9i7QJ114mgwg8c0UDpjPJvnZVQJDF9vMnxf9jvID/tpp5YKbY/b8Q7kyiyLbI3sHVT
         b6UQCW6s1le/b3kBDOX/0wGDUMJ7T9ZDNJ+ro4AkMbRXL5cgNIHx6Qv3FfUUvCKD3VVF
         UaO7nE6JXlnYrsGnOZJy7+308CvjGUc5yRozgiuiQETnLss8wDkvWqkFXcOQOXmjS5ew
         IoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        fh=OZ4MhQ38H/+L3IO4YTJoPMaMrONNlOxuGgCLMXVc8e8=;
        b=SXiDJ5Vp0LseS3HsTtOLj9wexNj222MEZRIDsyyFGMrxR27tRG5vcQ8nRy0REglwV0
         RjT+Ha80MIHGkBKGWOkEan9iQPb9FxQvvsJjeuGZyAFkmTdk/oYCiK8diH7akay87zku
         u8IFey+W7u97qGeqqr+JDFGMr0YcJzHQtd6WEHOhOABhtuLxSQoVlyAlXLE5zAA+H/cn
         J1uUXZlG//sSeCP1SHhdQr08m89aKN8Pf2AYIhP4pfzS8+jvKJiVJUfTopbx/Vpy923R
         dCCjvMbtFQVSlIsq+cCgW6nrtnzq15quUi/4sqg538QMVj3/KBdHfI8uw7+CqYWfuu5i
         gEEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787345049; x=1787949849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        b=J4RUZzefrcYjBbdgV5g4UJmBLQK/FJeHaTUbMM5mP4bshfUBERauh8Qm179Csr7PM8
         P+CfowNPWCI2fbsUAzzwjDoJfhMDd8kfAoSsQ/EC4IhKlT+OkZe8i+QfvKv1HX4fdZn/
         OIuU8/BJ1QOgVvMgJu6Wp/k7xyrnQLhdmWQrpgdyoS0wU+A6yRCN00HQBmDhp1K/aplG
         SJo7lh+gUJP7d5DRA5cGJOlIfuhNp1xsgSKbO53UIn9Aeh1l4GZd5fINfxnHzYBlmkj3
         pkOGWiRMIdKjSnIwTqKs/bUdAgsmE5Z3ANpQiAaXbVJvtM7c0w66NVkDYs18rkk9W/v7
         GIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345049; x=1787949849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+341h6DEBK5z4wanMXZy9KI3GcewBIrOEEjNnpvxUQE=;
        b=Q1XdIo7rBDU8dldMhQNUaUfLIiRGL57bH7emTj/ItZm5WZG2PtEB+5Ay4ryTLmsn5V
         JBdj/Ih3J06SU0sI9AKh/ZF3d8vbA8iLhFA4GOKG97gLvGplzcliDQv6+7JBE/JMrTWL
         5lLYmTy/ZTARP6pO4GMNrAfHwk9BQSckZfWueBhqAeHVlyySRzwbw3RxhO2xWraD1NDB
         lQDffrPHzp59TA2P/2ilc9Wn2/obqlwdebilzEfMWtCKq58/bVvL5Ys+8PdkLMe8PTFI
         SqFFjjXSWVB7LeJSDVqGaLhpV3oI2XN2M5xpifO3pj2dRknvsW+3vT2ox08ndXZEG6Ng
         PmrA==
X-Forwarded-Encrypted: i=1; AHgh+RqOeTWQGN0xBayzCKDi0liuWR6N1PyzOhd16hHvkdTUqZzFYscX7Z0vbFL3GREzmJiLsSw+Be9mCJI=@vger.kernel.org
X-Gm-Message-State: AFuF++lPs6a61gjYDwfhQA9mcD+nQv4CDCCd23Oa1qIbTcQtHbfFOWnK
	gXls3tlY/FkO4Q/trmy9HbFt51c7r+KN9mm33kDTdeD/6nOz8/FR0fYZad+JvuGvgpRRhkdfKwA
	KcxISwUG1SbXDDdafms59BmgAV4kvGKk=
X-Gm-Gg: AR+sD12R2CVqO5qC3lMPj9z3bPd5MpExUhZsSTCa4HxnxxGf0ZUCgy1ZGOtqdGboe+s
	uF/rOhsnmYQhk61cXFeOyV/k7eE86PoUz9+f1rDYX4yj1/knR6DFPCg/kAnXWtMazQBP/0oSDHs
	GSQWGwxOtQjYwHXAwSptqSylmCEZQHUyJaI5fe2ZM61MB8VVfDIyhCSWv3HB1wLIfQLhTpWJp2A
	5Bp09b2B0f55Z7V2DY4fx8AZj8FVMRIpCwgm03CuE/JRaHb0Zjy5LzyWuWbfy83nDjye3/M4ZL/
	fyzfIaxtG3C9wSTEg7eY1iNZ72k/xtazJXl/jUe1pa41wjpHv8CzBeUQXGiMQCYdJKzM7jq3sa3
	1m2PC13hXw/adiFSCPWf7AYn+sYh6E63HdEUdtfU5W1DWDA==
X-Received: by 2002:a05:6000:4b16:b0:47f:f1ab:9075 with SMTP id
 ffacd0b85a97d-482c0bb16f4mr14946126f8f.20.1787345049436; Fri, 21 Aug 2026
 13:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <aohqChLVqwiTpICo@ninjato>
In-Reply-To: <aohqChLVqwiTpICo@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 21:43:42 +0100
X-Gm-Features: AcwNN1UV5kbjb7HhnjD6pQaN2t78NxQ2bOmzAO_X4_DwzDdyb74TPzJRrq4RttY
Message-ID: <CA+V-a8tAUirxWKyCx9yvYgp0EkysxgkgK20-RArzFFKOXuHSvg@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

THank you for the review.

On Fri, Aug 21, 2026 at 4:08=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, Aug 21, 2026 at 02:55:55PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
> > When no alarm has been configured, the register has its power-on-reset
> > value of zero.
> >
> > rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
> > weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
> > fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
> > calculate the alarm date and can either leave tm_wday set to -1 or
> > produce a fabricated alarm date.
> >
> > Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
> > without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
> > this check so that alrm->enabled is updated for both configured and
> > unconfigured alarms.
> >
> > On a cold-booted board with no alarm configured, the following was
> > observed before the fix:
> >
> >     root@rzn2h-evk:~# cat /proc/driver/rtc
> >     rtc_time        : 00:00:19
> >     rtc_date        : 2000-01-01
> >     alrm_time       : 00:00:00
> >     alrm_date       : 2000-01-07
> >     alarm_IRQ       : no
> >     alrm_pending    : no
> >     update IRQ enabled      : no
> >     periodic IRQ enabled    : no
> >     periodic IRQ frequency  : 1
> >     max user IRQ frequency  : 64
> >     24hr            : yes
> >
> > After the fix:
> >
> >     root@rzn2h-evk:~# cat /proc/driver/rtc
> >     rtc_time        : 00:00:25
> >     rtc_date        : 2000-01-01
> >     alrm_time       : 00:00:00
> >     alrm_date       : 2000-01-01
> >     alarm_IRQ       : no
> >     alrm_pending    : no
> >     update IRQ enabled      : no
> >     periodic IRQ enabled    : no
> >     periodic IRQ frequency  : 1
> >     max user IRQ frequency  : 64
> >     24hr            : yes
>
> The output of the tests could be dropped IMO, but I'll leave this for
> the RTC maintainers.
>
I'll drop it.

Cheers,
Prabhakar

> > Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Other than that:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
