Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6383A7587
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065170; cv=pass; b=Tgtk3yQ/zC5B1kq4ktju3+m7oJv7Y9KVOQWw7TGiqYTITcP0aTDF/+UgIFkHGR/klQmOd6+novsslmSu1TmtDFRuHM+pRQ4wlQd+PAbF5EF5JP4SBKBsw7nPEiFXxbiEzDxOMpf+WigBUcawFMcIoJPpj3tBpiNeLzO+duOlE7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065170; c=relaxed/simple;
	bh=auOWJSI+p4NXA2fRT5Cx8VbH8xiNgNPgiWdRlKFQleQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEBbzKbXapLVm4ct08WpuFYAJXHItJfUjk38ouc67COYpyuB4+iBfaf8ECQ/w0zMhPIOxq+KND9WJ+K/uZbi+/9HfJII7IS43VNREKB1lPL+T2VKls7yAuUsKLRhxrHZMIOsWuVsS6yrBcBAAK3FC8mPdCjA67umr30ScSmqgks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Ami/y/; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Ami/y/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4957eefd361so36716295e9.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 07:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787065167; cv=none;
        d=google.com; s=arc-20260327;
        b=DT3gmHBeQkR02YqQTnBWes1iri1ixMCJxeHK9fAS5rtWxmO11YA0D31cnRw9wkx/9M
         5mejgAzI4rBQbrMjOOqT9CMTAvpNr9caIOp8HMpeeT4i/S71A+GgTTzy3UU5jIMiOjXP
         2VO5jY6hT1FbcYY0f5bXxMPvEbcRpPuWbSyF/SjNAwQI2FeiNMRK2K4aqdz8eKic4D91
         +PoxY8vhRTe+5KSmlh8lYBopzwQGlPwXhfoRg0+70Dx9ZnqWleIiBeGWtxuGa8IXaoPO
         IN8RymLYMpsm//YSVV3e9rFGsN/keii3TSKe8FwMREQ4MQMTvPpVDEaKYhxrPKQnhBiE
         gz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auOWJSI+p4NXA2fRT5Cx8VbH8xiNgNPgiWdRlKFQleQ=;
        fh=l7FT2y8B/iljn9sol10bC7sxD93gduGMbCX3UXQUiAA=;
        b=QYT/HL5HEVTGohufJTg691NbJMCLyDHK40DobketOYr65qg4eGGbhC7TjgvNkW32ie
         hWo8Szb9xxb2y8QfGE3RUbk8WsVE/fEUzXRBSIV0xcRVsFnbL8YtakNsMRgMvM013AZa
         TwtHz1u9b4mRKeG/JM3AxQSC7SGXCPAun0JysBgGhdbB0+Z+YFdoEEyDTTd1hY17bbVg
         6TFlfMbndQi7gXxgz8H9xm9E7G0PH2Esp4cUbr9rkvyLnaCbcOtsfXJaWPprlqf/FEYY
         KKVGpHUnqHajQ7peoLFshGB+4HwA/76aFL/rJkrEOmR0IwQ8tRBlIwTh59vPV6Kxoynv
         8rTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065167; x=1787669967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auOWJSI+p4NXA2fRT5Cx8VbH8xiNgNPgiWdRlKFQleQ=;
        b=G1Ami/y/Jx+/W4PBUx5WYf3TASiSE5Hlm3gMm4z4O0QCNys9ugGjp78wjeWhQ5+ZMS
         OZG+3jgKbkVnu0DqACWjqdjHmW+Dgh6dYk/kOz2/OIEYHfvAUs9YZdTNtEPdSAD5cGdK
         GEM5GS+RzhkQalcvRJB3J1DRetgCGM0uf7YMyN9bmLsNG1mPMhcsc2ebnA3I12CQnT3s
         zhxrRsQF4aQh1WMfXO6g+ImSTVGbBlvbCqCQ0TPBbdgEbt7wLiG+4vl5Ni7W3kOPjwNw
         BKfGct+BHOThdekT/EBCQlYZLdrxpYRCpG0WE9uxsG/91mV0QR6TQgauqZqILXrwZTOQ
         2sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065167; x=1787669967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auOWJSI+p4NXA2fRT5Cx8VbH8xiNgNPgiWdRlKFQleQ=;
        b=NxjPAUXE6TKimQR1T2xoe9B3VPnqeQtVs+70aMCGMi1kruhonIaTp/1zAXVr++eWsT
         or2sXuDnY/hcvuNM6Z4JrzjLPD0/tv79LFdswRNZA8nxkz0a8Cu48FyCexluCqzXKa1a
         OBJssthf4J5U4xwO6bvabTeWRP9QKCgd9eMcHeujnjTouLz0rnYwrenLZnP11o4Bpjnz
         4yympd5IG85OTKA19xbeYPw67kbxRw/Nz1Xa/XQjxTbcCKJ9LOx+ZPZQ1seAnLLUki8I
         gWQkhdLvOztCTIr7ebInGUJoMAXG/cwBIUhHh52C8Vv3IiasTLdpCoIX8PxYQ1MgtAM4
         4ibw==
X-Forwarded-Encrypted: i=1; AHgh+RomcnCKPQmpOT4qjNP8D2CKhmBEqtstZ9GlFrarzfPjlAMhL8+skN15JRxr6axFZPvuPNkG/ZtmMjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRftB1zhpR1rnTbbrx9kx4Jk9m6e5FBAqLM6pV5O13QsIXPtQP
	4y94ZRK/XnH/uup+l/ISJ4FZ4E1ayLZcm6cYIUnyW13+eEyS8MPlWyCFDEQpsiuOf/oDs1OYOqD
	cS/DbjOROFu+Aeg5+Rt52mx1RQ5cLaig=
X-Gm-Gg: AR+sD123kvm/XAzdHaaUU7szxtK1XqjL+WH46YXS80qrSzgrzA/ygb4cpis5dNj/YoO
	weU6bY4OxW6sHANeiqQGEgvHO5ZNphG0JPj/BjEQbpAub25Eo1S8O+jyuG/24Y28j4ixSsDlHyR
	tFkoqsfjZLzgLkNyyh7N0HPhCdyMPuWlP+ZtSN8vnOr9Uno9aVlSzVcFaAH850lcsq+ZD4LgIaz
	Pf14UaMqzXHQ4T7dRc9FzXfh7Hl2cd8xKxRzVh3aqD9BMFPVPMDH7iwzDTKEo7x6bUZBch8l8oS
	4nRWDURgm1GbWex+hejhHCeeBS6rEtG1wbtnYZDwn1b+O4wacOO8h0gDIlbvzp9ltz9ZDDtGE7Y
	B2XECTLyuELH5sISOAV7Z3TQMqUn8AQ1IDIMzRoOUQTp6vyf1eT+ijS+fjlPqwEU=
X-Received: by 2002:a05:600c:4ed2:b0:499:8743:77c8 with SMTP id
 5b1f17b1804b1-49987941ae1mr528130175e9.8.1787065166778; Tue, 18 Aug 2026
 07:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175655.6A31D1F000E9@smtp.kernel.org> <aoQ5INLOtNELfXpH@ninjato>
In-Reply-To: <aoQ5INLOtNELfXpH@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 15:58:59 +0100
X-Gm-Features: AcwNN1UCOJCIwPDBwZ6xtGRL3Omm13v2RjrLOXY3KVHS5j4fJiEaqJmGRVxTIKw
Message-ID: <CA+V-a8s_p95DsJDSZeP2Uy6=Nv4KZkKj0unLaojqR+yDZGTLZw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] rtc: rzn1: Use temporary variable for struct device
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-rtc@vger.kernel.org, robh@kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Aug 18, 2026 at 11:51=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Should rzn1_rtc_disable_hardware() use pm_runtime_put_sync() instead to
> > ensure the suspend completes before runtime PM is disabled?
>
> Sounds reasonable to me, what do you think?
>
I haven't seen any issues as such, but I will create a patch for it.
I've seen patches taken along similar lines.

Cheers,
Prabhakar
