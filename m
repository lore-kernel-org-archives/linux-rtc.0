Received: from mail-vs2-f24.google.com (mail-vs2-f24.google.com [74.125.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821394E1C6F
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648733; cv=none; b=BYfReBHRqK0sURLD63k1JNzkJIvVgLTz5CbYkdQdMv/GxIBXqdE1PXD+7EDvrwxLIbP22nlhbuIC8Cij7RhDgNqMg1hJXT7mRuU6c9ICvOxFOMQ578TRZSAq/ausfPr6RLGwXXc2WIJcM4EHZyScow2HUts8ss2DhiJTXy6f1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648733; c=relaxed/simple;
	bh=pO6Tgcpo7rciPqcfm2I2qKhUQ+kRl0w7xU9/IWEOHiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOXHgupSgwyqSR/VPiYMNUtqLsQAgarHSIyH8w6pwRHwb1SLNItMU+KjOQUpHjxdg3jzRyKvr85ZfWxTTmuf8PdUpwhdPpKxBTbZpmCg+UGjJPHGt4KbJIcJB56ImRwTD7p4TlRP9uOx60rR+e9hzNLcQ0XFzmkRx2m7xkIV8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f24.google.com with SMTP id 71dfb90a1353d-5c97b28165bso583659e0c.2
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648724; x=1790253524;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RBQw87BcG/7SW7f/yhCxPa56rKVyuPomBfuHA7K6Ojw=;
        b=R/FL0DZrfoRggfUZ17mKF2ba6ELFJNg555yEh3n11E3srCfGrudodRI/jxEeWUWG75
         uQIXn0EeBZ1R60FgRZGBW1prbuL35EPspJFNaWgwKxLWcouxuowxrhraYlloAppQfoj1
         i6FLjD7G44X3emQU3xZwJqNagoLGcmH1/SYvYDeBoh4cIQTWhJt4YTz6K8r25CJvfw37
         kwgSgAL0d73nmhBXJpKRTAVwSAr/UUZFw/j5SJmm8ep9uOu1AcViZLKQ6zWJpggui8Al
         DSwJFhD37GVDjpeZbEeDiURKsjwvbn7P2ybimRwXddg7KaFP0sQHJ0ofIubj9YmzH/SN
         QjXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfDTzr9m8MuV0rGVTml01GtLnQwgfBVTgZXB8ZI+OJGA8wOv3shUkUAcRObOyYVjvV9cpZFTAXX9A=@vger.kernel.org
X-Gm-Message-State: AFuF++mJXiuH15P2XOVj+PUtthQTSar/ThoEXFzI7UqP0rhhno33Py+J
	GNRhz217uz1crN5hzzuefGPwgmqQYdantVBiGvN8pc/V8SlBlOdpEOVnMK+5sBzV8lk=
X-Gm-Gg: AYBFou1MOOJrKYNncAbXY+QB18rNwAXV0tIlmRS0JUHP9QbNWpsDE2FiCPhJGtgYcW9
	vSMExUBLrjeSn/Ulr+3l3Vsl+e50k5H8dstd5mWC8dwgM9X2qOphWLVXr/DWUlIl7SM0+h28JPi
	S5gW5rloslxnJ8ogjV4WnQr9NVy9b+mQ6N+8dMI9zNxhErYZUs6Fb8sFgqxbybrHzOWebnrGpv3
	0G6H0aOkroreHvl5ZKBXc6c8f9AF+yIhNRtoi2frxKvxS3uTJA9ykYCWtEK8MsfBQUlUYE3Tuge
	YlSW7P3n73p/fYsqklgZyYpJrGRbV7Jr0Y3Ogx4pCBU+OCW4y1JQ3l9wgYoFJCrpOCq0LVQ5+U5
	x0BewAIi0mYD1tpb0tS4Tjz+6KnamGzuVqtJ2ahsO7RJ9lc5BW2sCx+0FVbLBmBt5/Sfz3tvhVs
	O3CGQLigl55GnoOVwJ+3NQ/BWDqVebbCsudGF0Ym8NbpXdsks+fZvEaFPjtO9C3jz0Cic6piHP8
	p4SyxJEJebAUb0xBT4mEz0XX2GoPhu1oaDULA==
X-Received: by 2002:a05:6122:208d:b0:5c9:a60b:e5a9 with SMTP id 71dfb90a1353d-5c9a60be8bbmr2028925e0c.11.1789648723968;
        Thu, 17 Sep 2026 05:38:43 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9a5438c91sm2428957e0c.16.2026.09.17.05.38.43
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:38:43 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e9d8a79acso498733241.0
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:38:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxe5pbbFfpin7bxryApvKpaPQawiR+vNJyVjxIq6Led9d7N5Q42FOWh9J4nXjflDo66MGtCGiyL5tw=@vger.kernel.org
X-Received: by 2002:a05:6102:951:b0:7a2:568f:815d with SMTP id
 ada2fe7eead31-7a2568fad44mr791569137.18.1789648723179; Thu, 17 Sep 2026
 05:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com> <20260917111349.52250-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260917111349.52250-5-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2026 14:38:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHirsCAOH1KOuPrr6C1AVFXniG3yqqND8hyZMAJ4R1JQ@mail.gmail.com>
X-Gm-Features: AcwNN1Uwts9bEPQ2xARX4nkO381zcIEk6hOBCmQmv_bM_450tPFHeji54wCUFmw
Message-ID: <CAMuHMdVHirsCAOH1KOuPrr6C1AVFXniG3yqqND8hyZMAJ4R1JQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rtc: rzn1: add R-Car X5H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 13:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>
> Change since v2:
> * drop Gen5-family compatible since X5H is not compatible with it
> * added tag

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
