Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018D415B7A
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299277; cv=pass; b=j4pW1GEVbFi0yn3np3YhlHgQaR760z+fGig3pr/HHifmV2AGJFMTNzYfqfzDTqgEpfou+SDnSPSzFD/STqx0jo1B/3LH3qrjMkyEzpO1KmBI9/T3b7KN6HASmJAkusrIz+WoFRKuMjMiyWRi+ggxBiQbTt83TlqEXF6I3n673dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299277; c=relaxed/simple;
	bh=U9fW2jiIlgiy2XPNBkMcmqoyzd/7xupfaic+yOZJQF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJm3s6yHj5Ftf6BVSEiRDAv+QCzII2uFEgBhTH+bIz9G3sNRXVsuQlSiWeE/wQRo3tpJkUUaLu3J6FcclI9mwfdIWTnGYSg7ikZRTjCkNUMkUoqXYoTAPK3DxiPiS3EYIqmRyMgGpMNIJZr425M9T4TyqKaXcMxzmWCl7h+ErUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRalVaau; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRalVaau"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495437bb891so3642255e9.1
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 01:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787299272; cv=none;
        d=google.com; s=arc-20260327;
        b=hfzyrfqDN+LYHEfzLWsfme03tXtHcvI4Jo2kPYVx47GwXwo2EW8z2f+0ZkE+B3uXMu
         KRIxEfsmBoHrD9RKz5Y/6m+oKJRksq88aVCU7Gf6ennumCQc78mugU5wOcvNTq9LeZuc
         9IMV1oTdzLtO9ynFrB8mJkqwDHrypY6Tpc7ZqKhqknspZV7HLK2u1AGGgZhQe2CB1wCL
         f43iRL+AjElCDEFCoZtZJwppJ5APhWudGTVetSyLOpRtgFfupCD0ZC3N2ZqSB67Vv+9g
         A5tP82iVBiL/hb9L3vs5nrmgiX5vDfWgmN/djDtqtnGHxAXzqgcZLSxDjhdb1WDnAk5w
         wwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKPWxLRibVTkF5iNiz5OZvS7ih6dW481F+oBUIMZp1Y=;
        fh=64XjEW2XhgodvD1sOfMcdZEdjxFO29rW0niXZhCiQJg=;
        b=VXcHE2bqTXYJhACDEPWHgK3OxWH/FDhiNtXCUzsWSqz9PQdNY2KMnzJ527fVxybV1g
         NSyMUfKdPQmFAFTXru89GpDkgPClI7NpbPbdRVbdMsxZa1xOCspN6aFbl41oU3cuKMKx
         JlQeALxfUcQByJNrfSqhYVVvoaZXACbe3vgplC8wFcM4OfCfoVmcO5QE9h/N+zAdf2Fj
         /6f0djRGFHtuwys8fA9IMyZnjeE3OnymA1EyzpeHbDvCtkEsQ/bxmJfZt54M+5exhet0
         PeTxJvF7mO9SYuYoG56OcRLz9sKS2fduBtRJalVYHS+XKJEi0T4ACj4Pp/Kpfejuxqe/
         Dmgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299272; x=1787904072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKPWxLRibVTkF5iNiz5OZvS7ih6dW481F+oBUIMZp1Y=;
        b=PRalVaauxqYvmik87uJ22HYTJ5PVuJtJr1516MKaZhkGQgmzk2hieAoH3YiPKzF529
         0AMK+/LZAc5hELwACRj/riNzJxj1Rr/BhpDxQTtDvzzyh1I9bg0OsFUQXFtncIUd2NQc
         1FC6IYHD3fMUDNr1xJyEb0FGdhTkAjB7UD2L5dy2xjwL/FbeXdxsk/DHJQqH7y/3/bdN
         0V2cS8Q3cif9w78iKi5o/BN+NsgdLpdBtXuqkkuHdzsRlpc9VS8f/mZpdtBbkGe86hfw
         GemE84N4fVlbefBg934ONbL5iJJsR5jLZEif/lad+DlEHcQxvgiTa0tpXCjGl+Y33ae5
         qL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299272; x=1787904072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKPWxLRibVTkF5iNiz5OZvS7ih6dW481F+oBUIMZp1Y=;
        b=rtCQVLy9uFkI9Qjl/QkgQA/Yi9kGpJ/NPtreLyh8+oOjCd2CZ5BZJrqWAQBnDG/rQG
         /kLcWaG5X4d2rgJbL3Nr1gsSVTFts6SWoTp6PQI2ZZfNgKJ+cMj8olq5LN/qykj+kBJk
         yJ5LTySBDIusCq4XWtDEAQbWYKBbtYdWDEO7+0AqyCJud7/YRNIQ6l/X1RAJU+eCIF+9
         hIuuCWq1Pm7o3xjHPDUew26b55jz2oQGQyKaAuaPMI8v3qloRuJJRfpwlkMhxOYAoBdX
         2Mk+1OAmOBgyFKOhaGXKpJrV+kUttQYNtE6l2wwgGjmyeLgXfGCs3nZzxRyApm4/MFxp
         IsVA==
X-Forwarded-Encrypted: i=1; AHgh+RojrE8PgVvA32xSEIern0F3/Q/869GeUBiiyC1WLN3e9R6/UvDtTtchR5opDITBSlLOc1AsUVkMYtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykk9b887Lm91PNdB/1r4J5LJDJvCQ1ESD5csEQ9cpbW+6ekU+E
	KWrC5yQpxUOzBNrXQlnJinaSnlY8iTDe3xsXHOaHUMWpivOeuyQrh7F747xhbtsI6Cwaa9tOZ0U
	ZcpM6NrPT1tWECkR//OKA6PyoIe91Pwc=
X-Gm-Gg: AR+sD13vNlYhry1KwwN81RR4qs5wdJBQdydoj63FZ1pQCiBEbNKDq9YucUvyyMKmU63
	7Lffn/lcm0Vag1tAiEHbRrMCrd45HWmwViib70a8e0SrkECZmW3DRJMMt0RJw0tmxZBcoB15EAB
	xn+J6OdINdoTRkxWHrZIX3iX25mLKBjGWDvgH4j6UCG7uETSn4+Vbv0dfS4yiDCTO0vEl1NK5Is
	5OHJU2DsNcyiWR+oIGRpObute57CR6XjFVSQnocA9jbFYlviFSyeVQk+ExF6D9f1KkGSlw1S4VP
	e7wxMZFrqsjvS59gOVx8WzQt70nYNdCLjQYFIZzgMQ8kLwPShAXd9fQUi7qFe+VAeARIV9Gdmmf
	GvsN2t88rjCgMJ8HataP6xHVxCYExyw==
X-Received: by 2002:a05:600c:8b63:b0:499:7f37:cb74 with SMTP id
 5b1f17b1804b1-499b06a36demr106804725e9.1.1787299271891; Fri, 21 Aug 2026
 01:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com> <aobjCr7ZtpLmL3VP@ninjato>
In-Reply-To: <aobjCr7ZtpLmL3VP@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 09:00:45 +0100
X-Gm-Features: AcwNN1XaqV7v4Jl4yl1cAvUjpTPOAGoBa_Le3wz-UFXRDSKArINsOqo29E76N9s
Message-ID: <CA+V-a8tpo2Rc9xsvsj9LLqD2ZjoHzRAVsox=7xURAtwA-GYVEw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
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

On Thu, Aug 20, 2026 at 12:20=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Wed, Aug 19, 2026 at 11:39:24AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> > is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> > or when it runs at 32768 Hz, the driver uses SUBU mode.
> >
> > However, the RTCA0SUBU register used by SUBU mode is not present on all
> > SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> > mode on those variants would expose RTC offset operations that access a
> > non-existent register.
> >
> > Add OF match data to describe whether the RTC supports the SUBU registe=
r.
> > Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> > variant without SUBU support.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I still think, this code needs a change:
>
> 454                 if (rate !=3D 32768)
> 455                         scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
>
>         if (rate !=3D 32768 || !data->has_subu)
>
> otherwise having a xtal with 32768 on a SCMP-only device will not be
> accepted despite it should work.
>
Agreed.

> Haven't checked if that could simplify your later has_subu-check or not.
>
To reduce the checks I can add a else if check like below:

/* Only switch to scmp if we have an xtal clock with a valid rate and
!=3D 32768 */
xtal =3D devm_clk_get_optional(dev, "xtal");
if (IS_ERR(xtal)) {
        return PTR_ERR(xtal);
} else if (xtal) {
        rate =3D clk_get_rate(xtal);

        if (rate < 32000 || rate > BIT(22))
                return -EOPNOTSUPP;

        if (rate !=3D 32768 || !data->has_subu)
                scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
} else if (!data->has_subu) {
        return dev_err_probe(dev, -EOPNOTSUPP,
                             "No valid XTAL provided and SUBU mode not
supported\n");
}

Cheers,
Prabhakar
