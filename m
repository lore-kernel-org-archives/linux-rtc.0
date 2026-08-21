Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB637EFE8
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344694; cv=pass; b=luIplKK8IvL1ArhoTbI+zzEgD506mewjTkKELrmK7nbjMMEcz7Chvi13CIjm4NTBS8R4X4EF9fmVpHRvIX1bau2oDAho835LuZMQMkRtSGtXIChvC4XHNLw3UdhF+4dMQjZ7NzuLAJa65/xAvqBw33tB0S+WN9icwfLyzpHFT3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344694; c=relaxed/simple;
	bh=q13Ycl/3I6Y3/7hapb9RKt5soriwKmS57N1y723YsvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL9339iG9529vfhkPpiZnZBPTxY2VdY9iC+A5ZjSGP2otnMBn74XZf81MwNVbZPOqt/9ivR+MsVT/Emcl+OEtImcyLbxudYuoB2drsowAIWHMxO4mAb7ObZw+a4W9/N2jkIp3F4D0NOuMa8hP5C9b406SuScc0GvfoxPyW0Jmgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ9A5zcB; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ9A5zcB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476a130c138so1448945f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787344691; cv=none;
        d=google.com; s=arc-20260327;
        b=ddZaOkDqOZKdUdKrX7ifGACKV/eib/5D66Inw4t9L4q4SEFtTK9uC5akqyd9iBZd4L
         TWc1+NgMlGINd1bwgveVzt8+7n5hMz8PDACJ6n/gWOPCKVbUg3KtMYzfCtAUlifgkqhZ
         jLUxu9wvI628ZrqzBc7gJMws1R+le9Qh0btjgcb4C0HcO3LG+xRr9Nfh540qMIMgDnps
         X5p5AhRJ/rgqAd1ouJzI4FF3Gnk5pRFSp50Di50b4inqAGj2yjy5EXj63PSm8OBuRA9v
         k6Y88KfoWtIvade1LATVTJ/ic/d/qrZ7PsIcJep5zAR+JT4D1uq7P9AuWtflb/WCHFUo
         HM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WdiOzXvDUkVsjFuM6APRwKIWsDPLxu7zb+fOUcgUmVg=;
        fh=UxDcNgRBTGLYSr+4ry6SFXx8SbOg5WUeqNpsvHw8mZ0=;
        b=A+Kd5Yph7Fzd/o6Lonoco73AFR8mcbR6lYMZ/DtRiiwSLZgNZyJC2NAWu/VmqnRV99
         kUmXsm9e5L+uvbHnPk0DNYdWT3zzB1btbjMji7bbZmqhcXyfUHjcDV6670ukyzDap/AX
         +ta9BuJkxschf9cj06olTvq3BQUGoGADLhfgdzhYC8jQ17ORy3ZepboyrcgEHO77yQwx
         ekgX7N9FHQR5L3YYk9S1u3mS/QrD5Ge3PGL1/5zDklrSUQJv/rsjWqSa0lig4wf1ZSS0
         gdHRPilPFZ/bKpH/VkWzJ6OEIF8NHTA3B6vO7XmmSDnBO8l/JIJqjKsKg8P48vxXqJYm
         5Ymg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787344691; x=1787949491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdiOzXvDUkVsjFuM6APRwKIWsDPLxu7zb+fOUcgUmVg=;
        b=KQ9A5zcBl3DkMppGuWyduTfxngmqFkUa0HBrwBJbMIpcZ2W6DeDtMgp65E97pLIrCM
         /tvEBMv4M4j8453YUHmAloMGtHAonGcl8RDdN5ePn/Nv4CTGgNOGZCwAi/WF7ujJkY2l
         3OchERuv85mq/y3goLPUFrgRfXEM1Y67v8CxeiPZvgRpSNAqkYVQVlaLU6de2ljYvVus
         PGgiwl7MmsgE14UbtAOGY9ZQmJXrbECocSyDGxLPKdglbP1+pT0UzI1IwIWfb162sIAd
         ChdsLqmP5hg6ORsgZ9vhGJk/EG3IGdWRIDquLr9ZNh4aVGXKvc090ta1Fz3eV6eq0xqv
         ID8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344691; x=1787949491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdiOzXvDUkVsjFuM6APRwKIWsDPLxu7zb+fOUcgUmVg=;
        b=kNg4OqlAOmK+ruW9lY2Ts9Xbpx3CgQ6v7xWjMARalxDaieFZIPdKwdj7ihYn9XR+3J
         gbkGzI6Qf/lTx8jfnfJMyYWh6sT9YQfnV3Nrf/LZFD323Jm3pc3SFJClQv+8oWcdSUsN
         c7iZ9VhKhtXg7xyPnZZSWPT2JdRYUw4HqW9bgTWBZs6PxWSqsnha/5Nzrn7yyb51paw2
         e9qxABGf8DTRwgUc3fU+c65XGIuOwUgS2HMXap6XbC7qJL1ACIKf0qJRIKnKkIv9N7ge
         f7IxcxfVjnZW4v/g+KCUp01HEzbVnNPN16+4FBBV80FvX8dd6YEIh5nMmKM27ToPbYfq
         1OOg==
X-Forwarded-Encrypted: i=1; AHgh+RpkruWK6zjXAuNyG6c2oCTgg+5Rb6sm35sSEhVmnG2FaE8myluPBta/+j5CiCpSjcPmiZ9Y55HVF48=@vger.kernel.org
X-Gm-Message-State: AFuF++mblv8PEckfns6NDsMfh7JJJ+8Y2fwlcNHSaJwu0OAzfiMB1Czf
	95rpnLhQaNEQjtB+Cze3piNdVA69CePRjqzP9gKd+EHQPk6OucBRr3FIFR9dfYQ9RuQfP5x++sI
	/Nl6TuQMP91unhgLJ0Tmy4fx6a4+Mmqs=
X-Gm-Gg: AR+sD10qHunIB2uxLF4WuRxLD5+/DVjcxZgYcX66Rqf3UFH5v6UmtCxDfplb0QXU+3H
	tJVgx2fuii01Qdy5NwgjJC8ZD9eSGjsjZ6ZSfcASf8mEGa2syZt/1ppbMD/HPVj2pb8o48yNi1q
	oCMie9RKFU8hfWvTeSWM6KWRVMpSpSSVnEr1UjCgoufsMvjzbW0StCdEQW8W/QJ00oKu1QQQFi2
	JC404iMZv50N5z56nqAd4HzuI7zQd9E2HuX2+SQEddrke7/7MJygo8LbUa+L31oygCfhjwYh6lt
	hVaKthTyXDHD1L4kGBEGYKPjDzY92wZTSLkzacSAGOp5KtqKX2cyleoBwenFLLvseaVMZvTnfBX
	DrH+3CK8iicqfV99vvb1QIGsHpofB4K0=
X-Received: by 2002:a05:6000:1884:b0:47f:9557:8d77 with SMTP id
 ffacd0b85a97d-482c0b97893mr12816144f8f.10.1787344691056; Fri, 21 Aug 2026
 13:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260821164050abd3ceed@mail.local>
In-Reply-To: <20260821164050abd3ceed@mail.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 21:37:43 +0100
X-Gm-Features: AcwNN1VVl2XSQKPQVSNLcdE-KwXFGBkc_Ti4Au0DGXEzggezb14PYhbpLUOzD68
Message-ID: <CA+V-a8tp8EEJw9NLRfpiM5pve8GBc41iL_s=5=MqZaSHssOzbg@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Fri, Aug 21, 2026 at 5:40=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 21/08/2026 14:56:06+0100, Prabhakar wrote:
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
> > Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> > v4->v5:
> > - Renamed rzn1_data to rzn1_rtc_rzn1_data
> > - Added a print message to indicate that SUBU mode is not supported
> >   on the variant.
> > - Added a comment to indicate that the xtal clock is NULL when SUBU
> >   mode is not supported.
> > - Added Suggested-by tag from Wolfram.
> >
> > v3->v4:
> > - New patch
> > ---
> >  drivers/rtc/rtc-rzn1.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
>
> This doesn't apply cleanly, can you rebase on rtc-next? If you do so
> today, I'll include the series this merge window.
>
Oouch, I'll do that right away. Hopefully Im not late.

Cheers,
Prabhakar
