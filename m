Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678E408031
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761303; cv=pass; b=nSp39GM6m19Ji8LX4PuhgF5pkzrtWqL27eyYo1DkAyFEIodEUzzFhyvtYQ2dfXV9oPfOGZKBGDl9nQCTCbeXg7IxvbBp+vOs+f/TCS+4IsqseAopKP0RUkGXP6OR+Giw3YQar/sFLoOFVJWZzW41Hut2PZyYxm3YchuIDLAtgnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761303; c=relaxed/simple;
	bh=FqG7OmGKUyU4sbv1V0oLUSK9uJRSuOp1aPGEqAPuBwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3jqloeQ6qUp0QMoGpUExPgTxJt5WPGuRatfzeSvOFwosNia5nFmikUEJprlpPhpe5PMh6hT9nYEcPxOV0kIbBMDC697gZ90h2D1hrqBUaZSpYy/OPBlu1OwGXEgO0S/o2MHnnVqIh/DB2SKrR9fAaFdcXZUtXjwQg4etRfI5as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muX0k9Av; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muX0k9Av"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fde295992so977373f8f.0
        for <linux-rtc@vger.kernel.org>; Mon, 03 Aug 2026 05:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785761299; cv=none;
        d=google.com; s=arc-20260327;
        b=LNK6R4nQum5SMotBagClhBqcEeiB+vTk1JSgK8URXt7qMso9miP0KnSTsK4TER1k7x
         AXI4idat8DtfRBb3cNkyEEoIkSJlDJNvhw50mxT8L19SRsihV+75NeiLI4pzYantbgap
         FXbQ1CEKi8kMWJzgrDAXEqjRrcRtLfrNpZUmPqN1CXR7ad/BlpmKEuA+m9IYGwYSqJwx
         tTZywGmgMGQWSvMC1ZcRbSIezUt5n66PibO/7ifIvjSNFL+N2FwZLqT+GG6Q+l3ftzyU
         Ru2VbUUoqiavn7D69PA+NkTVFYndU9uLNvgKRR7BcaBekI8ZxqlPYxZE+CigKB1+Cd9s
         bA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fax5mU2nzN+Aiq0QARQ+H5w0Gibs6bj0/RcHVBZ+sM=;
        fh=oum+O0IF6Dt+lH49vN0yCBEL4k4g9ItcWtCvAzdj7ZY=;
        b=EZrxLAoKFIn40/xfqq2AV3Pj537FVwPQlWLbvmfOm5kkyuHU1fZT/kGuLBtacH9OjQ
         Sj/iPSUDbPQbAlnkjPo6TWkW4miRQTMcURcF1c4mJIX/Ziaa/SVfVfZulfZHR+jTX7e8
         XtQTkllrzLWqYVPXzfGwOHoh50kdWf8JEln+ItVd+xjnlWLxmkuIjAle5oBc67CX6kso
         iR+/penvoJRPw1/dt3X8H2K/E7PXro4JFjnnbZiK0aazuOmIyrhLAz9RKw4dG5HhWda3
         RH+KDXC+UGKn8sG5B2uarOLEc0LNlpUZN4mv2wRxOZuQdOHqdHHh89NuMhcRVtgd9Veg
         zGfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761299; x=1786366099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5fax5mU2nzN+Aiq0QARQ+H5w0Gibs6bj0/RcHVBZ+sM=;
        b=muX0k9AvrH7b+PBR7pwMnntSIKbMKrMW7Lkzi46y36VJR4SapVqccU5iXzMcjJ3rlu
         mS9T4ZuWf5LlPkgZu6QLkjFj7EfGC7Yx/uNdN3sr9oZLdI3fnfnNXk8WVxq21Fe4bJWx
         pxnpIrhZwywwjpH8AS3UxlsH3rmGBJDpLwMzpMcaM/EzqSVIdZH2prrnddIg4hZ9LyYj
         x+8jgFin9wTAfoHzqWe/GJ+rP9fKLe9/7tuwbx7gOko1sNgZuvl5asD90b4jlQYJfp/Y
         HX+6mJ7cTOcR36q6VoTr2lWIiGXd3sEjdAXx8ZGA2qjzdYxJTqtdg0MmYJ2sdCzliC07
         r6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761299; x=1786366099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5fax5mU2nzN+Aiq0QARQ+H5w0Gibs6bj0/RcHVBZ+sM=;
        b=TfMUhB/ZPKnpgTyi9XIkuUnmF6R2VCwqZubn+N/s1m0yV/wF1padIJqOua5y7dZBje
         nTPh5xfFPuVEAynpxfkDUEX1yDzTwgFnIa8A3oENRSjeDN9N4m03BivXHr+6mrd2dNeO
         xTlTKedPmZH1H+fVKu7JpwvziwshIs4JGXSBBRMlulqROC5aXTjNPKaUdyRosTkQIW1r
         59H7tMo6VXAEfQ7Y3q8TOnpKvNR4nyGiYfpgtUgcQ3HrAg4ZNIR7xLX1BowRZHlfPY0M
         i38XkkgROAzn/jx0LobEri35h+gNt6ET5L4GoiKQdT4qLs+KLLUEPb0DU9l5D7ZpUz3P
         u1ig==
X-Forwarded-Encrypted: i=1; AHgh+RoaDfctPm+RejHCnKIAmlgkzrQTLMqo780AYVQ8lcSZDu4AomMwlCEaEuo3O7SHftJ8z3V9iQHSUIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnDeMiaCIkVp0oRSSbEbFZsz/i8dkLaKPkzSCUm7VhtY5YI2Y
	Wdj/pQHb2gH3NBxbd6uCOynVFLMoM3KzK0OWNmbDcEuwesrlhM1cRt70MshXOn02v1ZJLN9vFFJ
	MXQfm0F5bLuXggaat/2PQPdiOiH1LoMU=
X-Gm-Gg: AR+sD11z8ZhhsTEYghE8EMaFnXHsg51wSCCCLSPyBa0nuIsVbJE56SAtqlE0NzNJ6zN
	Y4XJYr9DXen6XrIal+8890ZS/aEqH6miQA0KVz3zvmhKEeovzZnS+NFH307JgSqPktJK3Rrqp1w
	Wi8EjV4rVWkRbAvPyhJuRHMyXNWClbv8s3GqhqC4PrQ2O5haJLKqMw+BmACIah2UhUabVdztzcb
	wdiuOTWM5mc2+qbzC7OY2LIx8/NQXqx1plc+2fCyaFkU9cBjCdezmxEhvs3lWokOOWLcWMaaKiV
	t5KDl9/ukQOu7Yi/WVl077koDh5soExIVCRF54JYOxmXRm6wf7jqzWICu8bBwYYoe3SPVwmVVpm
	rpiU4flEe75xvrvTuwDxJSLDn2XJ75NvzAJX6zU9ef4htrfhUSRfD1w6DA/mStSk=
X-Received: by 2002:a5d:6f0b:0:b0:47f:95cf:26a3 with SMTP id
 ffacd0b85a97d-47fd32e1f41mr28059514f8f.14.1785761298926; Mon, 03 Aug 2026
 05:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 3 Aug 2026 13:47:52 +0100
X-Gm-Features: AUfX_mz8pwuAO_YEZl6wI79Yl2xndxoZy1e642I1E-oM4Ny4k409h84jPMs-axQ
Message-ID: <CA+V-a8vohu9Sswp9jrmUkZ3SUVhVJzf0=9MdU_1S7h6aMShT0g@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add RTC support for Renesas RZ/T2H and RZ/N2H SoCs
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 6:51=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi all,
>
> This series adds support for the RTC IP found on the Renesas RZ/T2H and
> RZ/N2H SoCs.
>
> The RTC block is closely related to the RZ/N1 implementation and can
> reuse the existing driver infrastructure when operating in SCMP mode,
> which is required on these SoCs due to their 195.3 kHz RTC input clock.
>
> While the RZ/T2H and RZ/N2H variants do not implement the RTCA0SUBU
> register present on RZ/N1, this register is not accessed by the driver
> in SCMP mode, allowing support to be added with minimal changes.
>
> The RZ/T2H RTC variant also supports a 1 Hz output signal on the
> RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> marked as reserved in the RZ/N1 hardware manual, making RZ/T2H a
> distinct RTC variant despite its overall compatibility with the RZ/N1
> implementation.
>
> Patches have been rebased on top of next-20260706.
>
> v2->v3:
> - Added new patch to fix weekday underflow when alarm crosses month
>   boundary.
> - Make use of devm_add_action_or_reset() to simplify driver teardown
>   and remove the .remove() callback.
>
> v1->v2:
> - Dropped wakeup capability support patch.
> - Dropped header sort patch as it was already fixed upstream.
> - Updated commit message to drop reference about RTCA0TCR register.
> - Added Acked-by and Reviewed-by tags.
> - Updated Kconfig help text to keep it generic and not specific to
>   RZ/N1 SoCs.
> - Initialized rate variable to 32768 to avoid timeout_us of 0.
> - Made use of RZN1_RTC_SUBU_RTCA0FX mask for SUBU register access
>   instead of 0x3F.
>
> v1: https://lore.kernel.org/all/20260615154805.1619693-1-prabhakar.mahade=
v-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (12):
>   dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
>   rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
>   rtc: rzn1: fix weekday underflow when alarm crosses month boundary
>   rtc: rzn1: Fix malformed MODULE_AUTHOR string
>   rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
>   rtc: rzn1: Fix alarm range check truncation on 32-bit systems
>   rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
>   rtc: rzn1: Dynamically calculate synchronization delay based on clock
>     rate
>   rtc: rzn1: Use temporary variable for struct device
>   rtc: rzn1: Consistently use dev_err_probe()
>   rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
>   rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
>
Gentle ping.

Cheers,
Prabhakar

>  .../bindings/rtc/renesas,rzn1-rtc.yaml        |  35 +++-
>  drivers/rtc/Kconfig                           |   5 +-
>  drivers/rtc/rtc-rzn1.c                        | 159 ++++++++++--------
>  3 files changed, 116 insertions(+), 83 deletions(-)
>
> --
> 2.54.0
>
