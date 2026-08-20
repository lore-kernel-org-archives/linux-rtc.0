Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077439769B
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251488; cv=pass; b=ExfxnpoxlyiTf/2iZzld8Uu1RFDqnlwwqOGHsRaBVV6yY6gm5amHJUxPd2Bqjsy81CZ0HCtPAOxzosWVgruSWXr+JU4CMWRUuOqHRl4APIV4C/6/07uBS0bMlsz7i/Tyn8zIZPUlPFKyOm0fIbEuWpWlrp55zPBM2Nrxllur68o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251488; c=relaxed/simple;
	bh=yLRNqZLs5JEFP4GF85rDalUqa/Nrzf5U89CqwrivLfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvMg/AnGSoJGWb7gJUBZHsU1wdgZXbw0VHQQz9nd8gClzrj5VL5XxhQ8BaKgCdHERIUyUsJzavb2Yl4RDeRA7KNdrG4QHxJ0F0zhP0ye6MNuehTgT3wc4V/3r6tijuG1pAPR3Qw2exqvPR4TORxvPuTtypY12pdC0gTQ/J/g3LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4KQF7W2; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4KQF7W2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so202024f8f.1
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251485; cv=none;
        d=google.com; s=arc-20260327;
        b=W3y4Nt+1uH2vXKBiTFi7HGAoEETmiaeVSikYW47n3wjMpCM9cwntTSSkpO1dI6NbMW
         Nfrrbp4zs4td5gNLhDA73t1svAC4aiSdXsRF1biLkhm6l0fxqLaELz38j3o55vznU6oI
         Vc+OETnAnDc8C1l+472xPEHKgkylx+T3aHzsycDyFr8fUZ9XHjHNfHl9kIiXZ0Hz8nB5
         iA71j1sgiOiarWpzgG0FbVJlZl3pISQYWX28ivKduL7L00uDMwVEp+ykBlzdc28luUmr
         1rl7SufvWPq/RiPJeDr74YjNa7c6OMoUSq267Fu/tx+kdBiqD5Q42ITnj29z9MIEIMxl
         N70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLRNqZLs5JEFP4GF85rDalUqa/Nrzf5U89CqwrivLfg=;
        fh=lxsdR9DaZWDev+BugSs0o+nNQXCEYiQq4SrhI53Aa3A=;
        b=NhkiJKvcPbOTIUpvq2LBEFLiiHtgP55KDfPuxYZzW+DBC9nI9kJJ/7CRltI1kJr3ES
         aIdPIAi9j1Pjf5y75rOd7iMC3lPqz3cWwTSVCQneaJAxyroV4p0szTqmmHdw/TsCvi+p
         NZMmyQTl26DorKluo+qGlbiaeL71Mh/3CM5WxZOaPBU6/m+Iwz7SGda4Sff1/3PBwwl2
         chBin1DztLwZ8d69o8RQ5u2vxw5YZyIa+5GpQ5WleaB7IEkgl19F9we8kJaF3uFrFRXF
         Stnblp0p3hAugFw1+TD+CJ13nGL7SeqnwH2LKJ3rSHFCu3RAOUalX49dfUZaZ6+pE1wE
         ZkMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251485; x=1787856285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yLRNqZLs5JEFP4GF85rDalUqa/Nrzf5U89CqwrivLfg=;
        b=S4KQF7W2K/ilwMl2g/t3p+fUrAFcbEyamtwctejq8kkrtBEafuHsracCdswU9MjQ1b
         4UD2wu4rE2RqJ8dk1URutNE3ZtZ4g8koAVvKeabQ+6RIjj4r6TyPC6y9IJgmCgzLzL+T
         j0LO9VWTvJJJPnmRICzMT8mR6/KBa/RIkbV5ZtjRsTFtIPPkjrVRG8hT1eBX07Hja+Fi
         zjhCVnT6gC2xugElI3Pb0lBGAivv/xDpOuaQO6ktxOSyHmpq/bEfLSYtYyF+G5288j6G
         JlxoN1fG2S4Qs45uNsy3XvLYcnOmgTsg6lX4KoiLA24eLsMc2Sy6bUjdXUiwoCEPj1F2
         lWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251485; x=1787856285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLRNqZLs5JEFP4GF85rDalUqa/Nrzf5U89CqwrivLfg=;
        b=V4Bkh7ANTkcGPElW7DTca3HJ9jvUmiWhDs4eh3bxXZTBJ5Hu4ckPTAmugEtAxG2/zU
         yWr4Nsvy67Ip5lGRsdsXCQlc6yNSAcPuMYprVGXK9l95HPkd94hjK0fBp9tWHI+uAcRC
         gMkvSgCwKu9K69/zeLLNJVwrqOvfMdPypsvSvsX0WLk2XDHI4GTITTPCRtoY/VEBshm0
         /WuG9oZQ1lob9Wydouq2iD4Q1bT3Gosg/zlZUmsYBTgFHXK9C0RVPwc7J1W21O0xZtbe
         6KHb9y+8o8mPbrf0V+Yf9jsqpyN08dF0F4Z+ULy3KDyTiZjF3PAX5XjLHzeGPOU91TKt
         2Vzw==
X-Forwarded-Encrypted: i=1; AHgh+RpaAPbrZvCpS8H/+jBxqXNw6QxIdMlmjg+r0H3TGv8UbuGMW+xmUSCP88bLEpKj9DxpdojDexwVKGk=@vger.kernel.org
X-Gm-Message-State: AFuF++k0ZiHU4xynFMTnVw4d97pn0gciPrxho8cxjU4j9CAFCaEHGj++
	aF8fUDwwa+S2VyoD4gttlH+nixa2o01EvMITFfTmb6I0a7akBDn2kZDDcT6bUsIX05HcFgps4nt
	AzCkDq+U3A8mOOP/xJAE2eE9PkKpE7hEeUj/O
X-Gm-Gg: AR+sD11BHsWG6QA3vLmglxt1f1uNoxlLlOpJv3b1QXHmGT17Igq8JBXyrjDITcz0Bu8
	yMHR9hIgFeuKWjpq0WAWMWuM09y33XvI7MKY7Klw5M7CMNOZXjN17NNs1G4SriiNyVl+vu47qLu
	+NoXfX8ca+mfzHJhmDje77s9SK8m4iLS8C8m5WQXisDKXBHm98SSZD/wro98tnuJ2BeFQ+FBp0F
	JhQSuspiWErMrB5CpZf6UaYSHczBPvwiiNEbYMkFo8DbrWcbp2YjtupY3bcDnpJ6NWDTdthkQMd
	Xa4I+a0WFWqI4oPSLnRCQasptcqI1yfEhELa0x71Y/Eqe5Wnv2qQHllhmENcT1uNVnqO/yNlUqv
	9VHRZQ3e8XNhRRiBsC1ENBG21wmajCw==
X-Received: by 2002:a05:6000:2207:b0:482:a610:7a27 with SMTP id
 ffacd0b85a97d-482c0b9d152mr1364137f8f.20.1787251485416; Thu, 20 Aug 2026
 11:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819104926.DBFC21F000E9@smtp.kernel.org> <aoWq7VdKlAl_jGQQ@shikoro>
In-Reply-To: <aoWq7VdKlAl_jGQQ@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 19:44:18 +0100
X-Gm-Features: AcwNN1Xgp0Pu-QrUH3se_72By4o489NWiytQVn666RbDbhV3ffzDpMM0wJcWhPQ
Message-ID: <CA+V-a8v09jMv57WpbYbJfZ0SxiFD-d-9-+=iXdWN++G9hv33yA@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK
 for register access
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 2:09=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Would it make sense to wrap this value with FIELD_PREP() to enforce the
> > compile-time checks and stay consistent with the rest of the patch?
>
> I don't care, you decide.
>
I'll leave it as is for now.

Cheers,
Prabhakar
