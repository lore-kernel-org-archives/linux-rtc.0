Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99339BFEC
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345003; cv=pass; b=cg4Nb3SUH1VfRESBhk05th6Z1v8T+KWwncbB8Jxj3w1u62yakfVZ51LC2+LrgBUN7yAXWS53+GTzCzpzCcaY9B0QuJMGxbCELUvrMvemrs3b1jjubKuekLah3OXUN3dYLP4UhhbxYCHd3a9B+nxngqBX+pIva9WamrEwIMobnPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345003; c=relaxed/simple;
	bh=wPfN7PhPagaHp95lUT4nN6VYB+U3rCdvZ9ElbHnKR9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCCwFP9niePZng7C+YdgFcwE0NY9s8vE5xmslkIVMdrFEYRQnxQZT/9h1VxjWCDiCfz9OooXF+VCN5gTrzZwlvA5Yppo1Ke430j5nNOI9lryDuaAuK1huQSKHMUSc4AHXs7bas0NwPjonT7SsG7O1pOZ4BqnFOEU9qtdlIRoTsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raxEWtO/; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raxEWtO/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fe89fb333so741203f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787345001; cv=none;
        d=google.com; s=arc-20260327;
        b=ZaE+TKKvX5ociM4/idCpQ/z3ALTI/TPNi24PfLxbQeO2OmXS/lAXlDo/eyS93F388T
         K8ApqKhlyaizbb0oH1Oa00zZyHhTNalXCkoMWHmffiy1LH+5dXFp3ztbJWB4+Nu7rS7N
         JHeQfGvDPEb18ch7EUCvLa0PXB+cVtI3eroMeth/9n6DIHwiMuyUDMWd6kCe0kqKp44G
         oYWl+B7dTe43lm3RkMKnvomYHgBveJ3UTx31mqdEm3jkIeodlaf55T96OQdDh7YCLIrD
         zBsunTWMJRQJKxqZ37qLUm7KmnUBQBXWUEbUAJoFp58Q0Uz4OHLM8+M4ykFNJGuMrONI
         tMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=93DdNcgIHKf+j6+3tpIkwKN7MgYTvQWBHPBOWCJopQw=;
        fh=W1igyGyYEvtbyYEpUg3Wu4U0CA4kkEjDftyW1NVJV6M=;
        b=G6Vaw/dH9qk2ldXya+Xd7boLQPa50J8QdAs0LUCxM/c34lRfRzw6fLW44K+xuMXB4T
         QiWlt/2nf3fbtCPsfJaYqCcizKhuP+KLkupMAb7zuCVv0RkdAcZqgJlQk6mnRxS2juKY
         9nFHOhweiWqeNDy0Cp3tw8JG4+n7yeSYV9B/SVitJiWMfO6T6j3En7AwME+zmDxOxQhm
         5+ga2cdDRNQMNH5wD73saczIn5EA65FrT50Nw1nZuh0eWIYcBN6JS+t+/GhNCp4fQrLg
         UzhKCcO+h/VDYKT4chzExL9jM9ypBdhU5wOAU/8VJgnyQsklsGaXOtP2E/PIynCoXKHP
         Gutg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787345001; x=1787949801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=93DdNcgIHKf+j6+3tpIkwKN7MgYTvQWBHPBOWCJopQw=;
        b=raxEWtO/zwj9UO794EXnL9mbZeemdGPpp0eXD3u/U456YaDByiw1aYaHx76ssDS4w1
         BtU1FAtRk+rNcQ3WChgnZDwIQzafeoGPE6+AWYi2B3nAdKbWZuct+KnI5oA3R0e9hSCI
         oB8MauFtOvAapVGEZEzuLz49gmi2I6/DLZE8/s9rS9KO2TB6x8imr+4P6wZOVJmVq8l3
         hItaum85hsnsQeibGdVOWgtan0mqgDz+IL1MCxglM3tvDLpCYn7jdrKzwqPOxTC6awQ/
         be5fzyxRxdeVjJkBb1Hu3wTqbhRHzKmlHjGS4J7Z+tCPUS+djFEUIEZ1l8s7OAbkufC9
         /NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345001; x=1787949801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93DdNcgIHKf+j6+3tpIkwKN7MgYTvQWBHPBOWCJopQw=;
        b=tJ7WH11nMNzX8svRfyl3c3NaVxuAYhRKwL8VmgoUjPvQsMnqqU4vEW55rRVy08FnpE
         YzKKe25g5BcRjrltIOqbf3RfTkljr0SZOcgcuLwqZm3lrcwASfYiaZ4ogn16wVc3nnxN
         Da9c2dp+I5UYCYgUxgfH2VMlM6nPVM+/18Qb1Qb8erBekDxfgV3EmQheH9T8/QbnH5q1
         uurU2iqdwzQPOO017xe2iQmsDwdxfxSGnF9sy1BYCZ7zOajc5ODS7bAtEPM0+tafFSv2
         lJAzsrFHqwuHFdm8ZymzzObLj9FmL7K8P3d43hfoNEf3NWL6SZxQalfBP9JEQviAs9Xo
         oLYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/56TiyF5UgKee0dHP67yXVljubTkL6/KtLDFssviKWCk1Oiw6QvgHmcpmMDE2LxFOKJCg4Ku6BUI=@vger.kernel.org
X-Gm-Message-State: AFuF++mXNPle3G9+5+Ge0w2K9qyX48CiN0ZBoJlbuo80q5ZugiqrnJv4
	fbkCXF+P2IyIRPEF8mnmRQlYO/6gIeR/dMY5GlFOced21vJkN2cu4555Bw3Z0yuSygKqFz5A8AH
	HI9mJPrivjKQ6yK4I0tClnRNm9nFDepM=
X-Gm-Gg: AR+sD12E5j5yFXN2VjvHPqNLmQ0WgHf+/TQKWEe8cXTQJddSEsAP+VrVE1OG2GEy1Ha
	urqILWOSVZxm0W5WDLE+DZreCne84ub4bl1je8NF7di2ThE2fYwOr0unzAy8+ivpPy8QQ+HMzBb
	vX61OLECUG/boxvGLDjHJvNnKOF7oaLeKpq2DHNX1/Xv8waKDtdC4MVQcs9WnZeyAtqyIEJWJdI
	pMDuD6z4E5hA9mH/BjviQG+OaAM/oTwWNN6lf0KVf2eZMipgEE/8EFPxYYC/neWxPW+3WR/qPFo
	+p5TJc7XWqwCTwHgkgMppA7DTI5PfS23xR9pndMd4Vpth8oI/BpvJZUEKOE0xIiPrV3eT2EDSvr
	QfLNgzWGHPSOE0DlRqmz9mItGGRjn0Q==
X-Received: by 2002:a05:6000:2507:b0:482:b823:38aa with SMTP id
 ffacd0b85a97d-482c0b91fbbmr12887893f8f.14.1787345000792; Fri, 21 Aug 2026
 13:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821140719.EBEDC1F000E9@smtp.kernel.org> <aohsOSu0-bfMuxoi@ninjato>
In-Reply-To: <aohsOSu0-bfMuxoi@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 21:42:54 +0100
X-Gm-Features: AcwNN1UdltYu7R3EkacW-3NdjmnrTvbGQkZDbs3Dg4tohncIALL7tiw1ZOJi6wU
Message-ID: <CA+V-a8vfo416RdWWaAoijRb7T9oRtPmwJM9Zcqhx4NdrN9YxFw@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, Aug 21, 2026 at 4:18=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > -   {},
> > > +   {}
> >
> > [Severity: Low]
> > This isn't a bug, but the commit message claims to mark it explicitly a=
s the
> > sentinel. Should there be a /* sentinel */ comment added here to match =
the
> > description in the commit message?
>
> True that. In v4 you already had this.
>
Ouch that got dropped while rebasing. Ill add it back.

Cheers,
Prabhakar
