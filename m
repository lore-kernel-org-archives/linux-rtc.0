Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4937F728
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684930; cv=pass; b=tY92eM24o8Wb5cjWSF5cWhNFrlDFVhfht8GFWVIl8jZdEpxnyuVXBf620nTSZKNo5jKotUR+gLkGKSv8jQmtirZw0P4gfQrNhAyTi7dAnjN3mj05jqLOXM8axptVyvUAHvI5XGigXISREQ78c+7uH+Y+YvgywVNpxI5GjmDUowk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684930; c=relaxed/simple;
	bh=REUabZ89fdzJHQBfR5WXP0yj910l7rE7V9tU7qHuhFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5FAmSTyn3ODDtLx5GFmrBU8QMhIj7SGuoy7joMM9PNna30DRsnvs61IQJ9wBTES/ZqPH+joRHIY/tCfhfYJ13l2FxzseePg1PSk9LZ84g3bx/qP5cLSs5LxTa8DUEsrp98riT3rZLee89pnYonup68odWdvycQrrrjKAU+mpdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idJZx0nB; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idJZx0nB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e1916922b9so63271727b3.1
        for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 01:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781684928; cv=none;
        d=google.com; s=arc-20240605;
        b=lA2SoyIBFvhoP8GpQTTO2rjczpDmW30yH60OR/L3PE7IVwEndBRlKyo6oX68mFTam7
         q+6BGnOZ4Dt+BB1fGsvrQo9YsYzw/VihcQXsseCqg0samNKT8VxAgw9a+q0LAdDvyaWQ
         oEINkSdO0GpqY49HZbIOYowIFzsXGyTjkVJGj9y20ju6aZHoNgdFhCOM61yUSTyDCPhO
         Or5QmkKUq8vTFosMbsGMv5Bs4wkESgXOpd8NyGTndV7IrNe/eOmyVFXx3PsJQx37C4Ss
         Dgd82pBMVaO8iBJ6Rvphb3wq1kZc2zaRD96OGAe+mw1RjM/m+irKZOsROzSB0MHK5InX
         Rnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=REUabZ89fdzJHQBfR5WXP0yj910l7rE7V9tU7qHuhFw=;
        fh=E8bCRz7GIR9wZX+qC6PCMSH58Yb8BiMfe4rteDEgQck=;
        b=ejWWWP+gZKE1977ettR0QnnCT3ezheE7P9O5fYsIKQQT57sAs3xeNY6IKVayYcQEOT
         cGqnFoiklU+VLsS1ii45kkjQlZUy7DYdLFqtsqvgXRGGdMrVhMWHBYy3UyZL1TsLJ9md
         nIzphYtVEoPw+DHtMCLPtunhvS5pxAXe5OYh+tXOScSNx/rc2aqUOL0TBOeAwJKzOoD0
         cEgt98c8MSp/jHKRqvQfRPeLwEi57fbCYx+d43MPzfmU18kXmbZATm1Wmt66bXfRDt2a
         6FcWFCielwHAmUn57cvUM1IOFwHp7jGAQjRPKJkvnUpwTqDNEKgU9Pz4QFGyzUnqwKeH
         q39g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781684928; x=1782289728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=REUabZ89fdzJHQBfR5WXP0yj910l7rE7V9tU7qHuhFw=;
        b=idJZx0nBQgigpMQVX7Kxf3eWtz4k/2upygB98XQRs61yjYuUPXS0RmBqMfwDfckA+g
         PHZ41eb29zZj70iLQgkKLlIEweCVjbES2tkqz3KoSVM/Khrg1Sl0Y11ZAUFEKihFzefU
         3wAQqEmHpZVpqmsvlcmPJF0X4diKRTBTBDE1xypJtlx8gvyf7jD7RIdtPqOtU+7uj+Q7
         H/cxXAwyM8S5IQzfjuvPeXZqJ6c2kLEsWkomb6Q+M0+wVmOVHb2rsHmNK1bp00pU5KNU
         j8gS5DSzMpUP8v2rbM0pbrNR7uK5uFj6GTLfQfOg39ZYjoMa5NbD1twlbwd5/qinwsea
         d1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684928; x=1782289728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REUabZ89fdzJHQBfR5WXP0yj910l7rE7V9tU7qHuhFw=;
        b=UzWuUIVMFH0T8WCcSdjiNuPjL7kuSf1+M/83vrtO426wYTc/liTYDUMd4jaFwULSha
         je8qOOCDmwcpuP0fBUZqgn7I7Vs+ydcg6d19zGwgkejwzFJs5wCXg7WCiLfZcmRGALXI
         mudY062UBf5SJRYM3HAtFAnmKgzEdXG7DvXUT2aAaTFG6qox6CPtr0DTAlLdEDni8iRN
         dPuBCdlNnhUrYmgCPIcMVTpSXn/q/A4+rajtUzLIDGTl1zW9/Y0y0s8LcbUobRCwBoGe
         lggnkDzk5TF44zz35cWAzWAt6HV9cqU2ETt1m+NORy88L/E0s8QJht92FJyYTRDZPaKJ
         J5OA==
X-Forwarded-Encrypted: i=1; AFNElJ8N9Nn7kaIuGAwpYCrVuFKNpZywL7XtfoBCwemtG7Dnzd4eCwTGbf16aTnRDA+K2C3rSYOsrGrVyuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxxm6PZliFRbq5e+BrIhG1EmB7vun2PE25kNzSbd4NTOcp9B3
	xT7Jv9UxHLHn+M8y5ibXkSQY2+MFnOrYCjGirfFOZqeUIEymyIP9qzBMOlAiNiglQKhsdXKcf8F
	/JkHOZceBiJDWoDLPh6FUSxlnD8jcvr8=
X-Gm-Gg: AfdE7cklL2kMAGw/hy6mvecVUhgMOJumXvf1EK9lfB2lUhrip7DxhG1j22CPWV0r6Sm
	zlLds/DnaeoM+eGtLcRb08e3BOjP6OWwK3vh8u5blnXArOGReFSQPh/WFEq9GzidIw5++a6iFz4
	faI0TRs8icPZb8g23tH+A7YAvsrTrij8T6seR2BBuKc3MPQv94O7fpfkxOPCvmFTTpVGI2SNIvZ
	dDrzbFH9C40T4nFUtYGM9dFYmXlbyoLHqVURPIBwdHs7mJLqbG2p4qAwtoVtENII06EJGzIfC7b
	C+18s24=
X-Received: by 2002:a05:690c:a84:b0:7ba:f712:95d7 with SMTP id
 00721157ae682-7fe5bd27fc1mr27706497b3.5.1781684928188; Wed, 17 Jun 2026
 01:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615115311.515404-1-challauday369@gmail.com> <20260617-sturdy-silver-bison-bfb6ba@quoll>
In-Reply-To: <20260617-sturdy-silver-bison-bfb6ba@quoll>
From: Uday Kiran <challauday369@gmail.com>
Date: Wed, 17 Jun 2026 13:58:36 +0530
X-Gm-Features: AVVi8CdvHcrizKqHwbnPdHShHyXWZ-18gCtWSxqioGqFu8vf5KFakIdcI98C7UM
Message-ID: <CAAj-GB=GyEBjBrRkFKyrD=dceMoHy=P1yeb4zakLqzO5WMA3vQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Convert Microchip PIC32 SPI controller devicetree binding
> > from legacy text format to DT schema.
>
> Please mention here that you dropped requirement of 'cs-gpios' because
> it is not a mandatory in hardware design nor in current Linux driver...
> and then CHECK it actually against drivers, which will lead you to
> conclusion that maybe it is wrong decision...

Thank you Krzysztof

I rechecked the driver and found that it uses spi_get_csgpiod() for
chip-select handling and sets host->num_chipselect = 1. Therefore, dropping
the cs-gpios requirement during the conversion was not justified.

I'll restore cs-gpios as a required property and resend the series with an
updated changelog.

Regards,
Udaya Kiran Challa
