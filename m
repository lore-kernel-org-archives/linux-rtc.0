Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51547CC73
	for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584629; cv=none; b=ZyVkqttpIBGx2PwpXI4Op/l6nT+tuVZF8ie61BX99z5eAot5Ps8VapOkPlNcs7i80FAURjaJhN1J3USnorxHiNqSQ5uDlUitIL6lTh/6JDj9rGNyab/tpirHBiGyBddS3DDmyBwyN6gfEfO5CyKQc0ZavT2fKyns5bVJrYdmqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584629; c=relaxed/simple;
	bh=EX9eicHVwaUoiSZxx714UBw/LKTiMCIyWd9jiYJIXM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHdY0zk/ERqz58UMHT3PIOQOE+UXQMk0C3BPX47kRWtbh5IXyjY8Wo4KmofIXIU5yLsDLx8oiw35ykF4becTRjj50dDqSLuiCa05qcpK9t7RnxPTXFvrVXBn6zzngkACQlWJYlH8hqLCNfmPC0mKR0o5HnvfwplOvkbycoatIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c979c5eca8so2084255e0c.2
        for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 01:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584626; x=1791189426;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zyTKehMDkFPkqWKZx92kuclrg3hevtjSeeDpDpZ8x8o=;
        b=HEAnt0LZw3EIhqsAPC9rS7KuHK/pD5FB9Mvrd8l6OmpULPH+OuIDL5SA4eZj5FMiAM
         nM0cFEfya7Vxtc6yh8TNL0+NUu2EY2GLzNzh+iIQf6ZfBGwJdrKEtBt9Ug+UHHGb3QBP
         moPK2tzKWYBNJ+5DkOhnQtp+TiRnnQFucT+7E5J+OoWPFy4blqNjGkMBCFVW4NLRdYLx
         BkbosbeMl+8SHaaGKlRsWxJM/XT/tLAxEChbrlDh5rtwCiVZ6DCod6GQ4hDpN0yPZDtR
         YA/3GsrU8kcstdvkJ3HNXkXlLJv9uE9C1lt1q7SyyunkJBOeyhJevGVa8piLFY7C3G+6
         Ij1A==
X-Forwarded-Encrypted: i=1; AKwUvBw5SrSTiESMu4hUkDWF7CXitmgo3ilyxkdd2+HKBptKU4MJPJNX8Up9GI3PAZkewTbZuBg3pKEpB7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYItZZT3p5UZk18zV69g8o/+kPaqaq9pbqlPDVP/rnaMB1Gjl+M+
	pceV3JMZTQVIuBhnYzQLP+7gc27uTAwpvgoxopEMum4jPQHnePhVzt8/+Ak8uGny
X-Gm-Gg: AYBFou3YPL2+aWVKEJx+ZpdLctKBTgliL8DEwlT8cK5q7kgIUxrvzK+N0UpYslmiwMr
	4Nodth3HY4eF199NJKbqTA7j1FLcXEwZQ2J/XYHRosBotyI0s8Fs7vJUNKsUFP6/uWtuxa0+MpX
	LgASAKKadHmmW1WPVzUTUHqbD5J1Dt475FBGUBAR6kQAY3i/hiJ2tkItukFo9V+xVXgqyhU5lpq
	js9+jKjEsoHVzJmSRwWNiEpLhR3gbxlS+rV4JgIFut2499XYi5f7/WjG+YDH5w5Y7mOgC9G3fIv
	5y01Ew61qEU/zqgPMHyPqseIcq92ATC1Qzp2K71CYAcmiostXHYRrEDoTNbKf29jkQUoh/asXBc
	Dkj+vG7GRdEMyQ+NV2aj/MSqB/g1Gnqiy73v0XVgZ4nAqpDMgTRcNlz6yqpGpaHgBW3wdpTRn6I
	WB/kwJplfqV4XllKN68gvc6nJn4L0nF84v++XTWhxnmmIa8UTO1tHiyHnDCkkQsqPzfku4cWuJl
	g3DFbtzcTRHuuQCDetFhwSHLq+Wp8ZOSEG6
X-Received: by 2002:a05:6122:1307:b0:5ce:b65d:22bd with SMTP id 71dfb90a1353d-5ceb65d285dmr1386093e0c.7.1790584625852;
        Mon, 28 Sep 2026 01:37:05 -0700 (PDT)
Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com. [74.125.227.37])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde645680asm8093457e0c.15.2026.09.28.01.37.05
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:37:05 -0700 (PDT)
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b42f1cbcf3so849801137.1
        for <linux-rtc@vger.kernel.org>; Mon, 28 Sep 2026 01:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxUOeXnkd4WXLdW40URa1n2s0Zz3NhBH7C2BkeFqAL75mGDVU/HXY2RzyosAskcZvavjhRevJVW7jg=@vger.kernel.org
X-Received: by 2002:a05:6102:4412:b0:7a7:19aa:8a85 with SMTP id
 ada2fe7eead31-7af1eff69c0mr4934230137.32.1790584625197; Mon, 28 Sep 2026
 01:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-4-wsa+renesas@sang-engineering.com> <CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com>
 <arlA1YuH709wjtHm@ninjato>
In-Reply-To: <arlA1YuH709wjtHm@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 10:36:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6v6Fu+mTy83TNRoSEjbaaup8sZb0AE1DZbYc0ZGV2_A@mail.gmail.com>
X-Gm-Features: AclHuK8tJz3nMwMQn-AWIXUGX_sO1CRpFshT3Dx9kEcVgOI32UtUqTiw6p7Mi64
Message-ID: <CAMuHMdU6v6Fu+mTy83TNRoSEjbaaup8sZb0AE1DZbYc0ZGV2_A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Sun, 27 Sept 2026 at 18:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +      required:
> > > +        - interrupts
> > > +        - interrupt-names
> > > +
> >
> > Sorry for missing this before: the "resets" property is
> > completely missing.
>
> Yes. Prabhakar, looking at the N2H and T2H DTSI files, I assume that
> those also have resets for the RTC and only N1D has none?

RTC on RZ/T2H and RZ/N2H does not have a reset.
Please check the MRCTLx registers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
