Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB61A682C
	for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797617; cv=none; b=ktrjkYdEghIpsOOyMacAD3jv67o6cZAJGOSHhHRwV9c0+NJ2qBRU36ORE2rFCBmafve2QsfrYlE7SzoInkONojAM8TdjTnZxuBW04OY5ITN5wlBcn2Mb/XJXFPsmqxpcBneIGIsR2ucp+ZaniWSA7ePijOMImDcLetqLwd/XrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797617; c=relaxed/simple;
	bh=6OEDWCRMBhUQwuYN96z0QclZTB5fdpiw/4HbCIL4mzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0F22qD+99WeMuQTWtSD/XZkQPT413I5vfywBqOAaX/O8KlPn5jMoKTfju2c/sklnm2xIpof2XikwH9vX7QSe3U/Yg5z+dEn3Y/AX9zVGZRAlP2Kd90NBxJxsy0hk0g9QY4+kbuhW5Sa1evE85uIP6usrSCOKAbG+tpEMsqp+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c02791cadcso445506137.2
        for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 02:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797615; x=1792402415;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oEYfT2se9mQPZq99mjf04mY4Ov62RIWvkBSPqPyDyD0=;
        b=BQEthcaE8x+E+vXFj7PAgsMWtyP9RCl6wmpfwYn8YaT+te81v4X9dcgjCsWjH3/Leb
         cDSRcxDNfo3ZYO5mnB8faB3C7h+fD7TKo+s9aMx6cI/j0HxmXBoD1SOPudU3Gx2I0noJ
         tX/44iwLwHZm5qY7FJOoNQfrLPcCchwUNInvzFrxRsYpYrow2qk4dudNvIpnDEy825hs
         jLD2lM9Dda0RpDip3grYMpKy95RYT/Emgqa1Q11+dTpeJUpKO3qZi4ADsTD1q9ZGzdXQ
         cWdd80oCuSNv+rdQvj1PSoV35RcrR6rQGBjV1thP3FKwMEB7cBDYIJkVXFKjfPZ9mJPC
         W9xw==
X-Forwarded-Encrypted: i=1; AKwUvBwhzx16BA15mHymcKXqmQ7nP6LyAT/lJE0Lkea1UkNQz+YhXRhax8y1sn8Jxlsy5O2CE5NhSB6yw8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVeA4XF9SJjnxKXMBzZVXk/PGwFL3/z4IrV6O/+RO4oJIcd4uB
	6X+5UUFdvWx42kGUiHmeiX0UU9jNifDBNnb4mHtkPR7l1mEF/P21c1guVG80vhwq
X-Gm-Gg: AYBFou24KzwiNfZ4iKvZOcGVePufKqwVAqUv0UGaXWbzC2kCR/zRbRwSipT2TKfc3RL
	BMKps9SL86PxHuUkXxUBzg+TwSpVMoRoGKlXcG6A1MWEk0WyhSRf9WTA5hUboyKV7a4PUYyFjRY
	9xXLR31npTvtjxdDvbNld8J5CM9a+/eKNR2vD6FY8844O/uNdVtS2hW3f1b52mFUgFvvwLsf0Z0
	Ve/vK+Td1A1sii/EC/r2LUv4O7XkYfwUJDZjkkEzNxhxTv8vPgtBRmI74FrRFYT1KjBKMaxA5iQ
	NSCfMvEGg2LjpkePbwbDjfcolLnceds/WXXm6QMgWQg1pdwhTlWjSdS+ib1EKhbabJ++Q+a4blv
	pM9ih0RdGL+iqCwbWGK926lGuzlassPiRXLA5bwrWSbMg1qFvXrM8hs8o1V54jeTeIfOd27Burv
	m00FXLEPxL2h5W73PpHybQQf/pSiJiwDp23DUdyGoAoEHvmy93jj7AfT4cce6rY8KtvfUFhNPpZ
	h+lTLq6ts/u283WDmVsmaDc0j2bllrZs5b9
X-Received: by 2002:a05:6102:6b0b:b0:7cb:1546:f54a with SMTP id ada2fe7eead31-7cb373e6b92mr1982964137.31.1791797615376;
        Mon, 12 Oct 2026 02:33:35 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99004008421sm6052672241.13.2026.10.12.02.33.35
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:33:35 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98b2f32e67fso162473241.2
        for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 02:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzmj8WLX1QRc7GdJLnzFR1RGLdijAKkMbEjbqR7ueDUpG/2vDTXpzDuR+nJtYkysTMU49bQSFkUCr8=@vger.kernel.org
X-Received: by 2002:a05:6102:e0f:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7cb373c9305mr2142364137.29.1791797614854; Mon, 12 Oct 2026
 02:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com> <20261009-7b4b54034fafb7ad60ea917d@squawk>
In-Reply-To: <20261009-7b4b54034fafb7ad60ea917d@squawk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Oct 2026 11:33:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWFsg72nQ+EYYYwLUYvQBULa5Xz=RL3O3pwCECo9H81Ow@mail.gmail.com>
X-Gm-Features: AclHuK-zPgcfuS_w3EiTe92ek8871OrLWJ4iGuAnS9nipI978vqESTCZAqRzLsI
Message-ID: <CAMuHMdWFsg72nQ+EYYYwLUYvQBULa5Xz=RL3O3pwCECo9H81Ow@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
To: Conor Dooley <conor@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 17:36, Conor Dooley <conor@kernel.org> wrote:
> On Thu, Oct 08, 2026 at 10:16:53PM +0200, Wolfram Sang wrote:
> > The RTC on R-Car X5H does have a reset unlike the other versions.
> >
> > Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>

s/Suggested/Reported/?

Closes: https://lore.kernel.org/CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > Passes both DT checks. Kind of fixes 3b3fdc9fd40d ("dt-bindings: rtc:
> > rzn1: add R-Car X5H support") in -next, but we don't use Fixes: for
> > bindings, or?
>
> If you want, make it more obvious IMO that this is a correction.

Yep.  And without Fixes, it might never end up in the BSP ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
