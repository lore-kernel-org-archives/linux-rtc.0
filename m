Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53E37FF67
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565080; cv=none; b=OPC29j79aT0PTXzFTyxBYNoKFG1WehX5s8fnWwSBcid0nIMy1Yjlb4e6/pAaQyihPYP4ilbbR5NrN8fsYDLM8zgZlwJFntCQzBB5/s4ipGVecv+bYaFbWQWtGyBBHtkfXdDTDzUmxG2wOvB3saJLff8zsHYK6VPJbwAoVPDgO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565080; c=relaxed/simple;
	bh=2sE36QpcrfvxXArJ8GEwh8xkTNR5ml6No1e+wSNTgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyAAUTFlYHaJj3SnMz6XdRpKOCkLMR0HxCwuFBteLgBmFPa8fkuTM/GmI/qrC+Zf8nh0LdREC1N59Zn7IIsVWq4LosEi/2zyUUfz5NMgECmRRMFsE5l19CXVv4bhu931NDoC9jFf/cEoK8jyuVSD4bIUOjAAvYPnQNYY6nbR/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e5059f8so269111e0c.1
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565073; x=1790169873;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VX4C74fwnFsyoib4BzaTdWMpIPzbVi9atYccVkCkD1g=;
        b=Vh8SWDfvVpRejmvFIooE6dWNAMMiv+T0Dli/w6sx8+l32ZK5OhoQMpfmtQvgto047W
         cVlufxC6Ul9PItJ9nt9bbUPgJ5yPHnl9A8LmOh0CmYG+YHuX08QYJ5EW2ArnQcjp/WJH
         kNybyGTpP4WuTcyxqYD8szq5flNsUbd3JBHlnAnDIM41OCEb3oFWTPea7Sgq3SADlm6L
         2wKPPBeke+5YzmThhyUifkjh3kGzVEZ7Fym6H0gi3zjiw5pc5NKWno5IV2qOGlmFwPwD
         ecLyAcZvlip0KWY5IK39DU96WeWsgbk24RHJ3HE1nUs05dqIVnH5hhPniduS1fsE+CHX
         E4fA==
X-Forwarded-Encrypted: i=1; AKwUvBy4NMkRqRkha4p5OX7gosgVnH2yI23/JDLPfi/AoGMeR49LvolOm+0PxfxNpCKQIQvtutzeSqe0ShM=@vger.kernel.org
X-Gm-Message-State: AFuF++mpWgMYxVWihwx8D6jjTwS/uzO9va3LrIMdIe3IZ89fESZ/HExx
	GIBm31giY9lWBWzf69zdGLLJ9lrmr5RjFQ1mpyM/fI0GcxuvG3Sz6S26nGwH9w0cayg=
X-Gm-Gg: AYBFou0PXY3BgpoUIUpXCytP3JKU/wsC5/OyHwyj1VyUdJCFT903Z/vla8C0/pMulnS
	FgiXGqCXnQSdK8UC5YFybTLFBv7gYHJpjmqigrbGJ9+wxslJs/0SweAnT3mqU3b+2JVdFvVHB8L
	zR8Qk6frxizz9rlinv1hSp5PdSpOzCuBG1X9xaEVtyamBh2cphOHkt2fPBw8C1E215Ug5JKWACR
	Epr//KRmPuoS4COjK8Sq2JxrIXhKkd5glxU63QpC5BUFQ8gDnn8mF7HxUGPK+BrPT6xPUPixjwv
	MrvrRrJkiSjYE8ZW3g0kf21nJJP7iQliH7jGFVDpdprzc+CZuaV3jbgx8vzQmgfTkFL/uPfuG3J
	yi5kS/UFFfhWwFMaZfqJ3u6rn/kJ1+BhX2P94n726JSV+EzxuOcDZ1QBFkV2EVWkAcEMe9oKju+
	+IiRjqZAZDnE0oDMqdZ9EVj91ja3YmlE2ibnH+u8/zZNedfMiJQz4+IRmKuxLDDFAkmXgzOOTXL
	xONvsJP2e/AGalpG4VfRNvF5MWjVl+9GS+xUraUeFoAmSbl
X-Received: by 2002:a05:6122:338d:b0:5c6:5daf:52ea with SMTP id 71dfb90a1353d-5c99ada72eemr2852941e0c.6.1789565073022;
        Wed, 16 Sep 2026 06:24:33 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c998acabd7sm2603610e0c.15.2026.09.16.06.24.32
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:24:32 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059faso321313e0c.0
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:24:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzClwyQ9egf7EDv2BmV5xhy5m9ubLweKDH5RyO9Ybl1JlQq7pBejJz70XHKzHx4lY5w2lNFgh6GcKg=@vger.kernel.org
X-Received: by 2002:a05:6122:21a5:b0:5c7:a9ee:dcfb with SMTP id
 71dfb90a1353d-5c99ada3e81mr2075973e0c.5.1789565071973; Wed, 16 Sep 2026
 06:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Sep 2026 15:24:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoGX-0m84OpGa+mYd2TiZTDC78FB0jfOf+G5wd-pAF8w@mail.gmail.com>
X-Gm-Features: AcwNN1Upz0AiTN6Fi0olgdVADB8csOI6lykesiycSiLGWDxtF2vw93S3VRE-mkw
Message-ID: <CAMuHMdUoGX-0m84OpGa+mYd2TiZTDC78FB0jfOf+G5wd-pAF8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: rtc: rzn1: add SoC names next to
 their IDs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 12:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This helps maintaining because the numbers are easy to confuse.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
