Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13634106A
	for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443030; cv=none; b=CRNeWR/gTp9wL18AIQNtRbI54i6BH55I0ooIW4qr1qVx6jgdWNl9YqterFRwMHkTQXatV+HDohchQP6cqPC4qHZrCfs5UjNvDlUcGdK0pPBDERiopVtJ15o16TzSojwzIt8hlplxfO9+1rF6NWhdikxcX6RvP4Ufp/J0oHX9Vxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443030; c=relaxed/simple;
	bh=YLtBt7Yt1uOj6O5aaTFlwAQnG8l5W6SfahAW/Yz+oGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQsgoPNKOrGIYXLL2J7Vn9j1b8Du9NIDomQ4bcf7SyuT6waSs8s2sYrJerE7rPbzCZlEtIJYcMPxKIPtlL8cUW1BgMeBBdSMA11ZfO5Fd5x3G6KEjMLTUhyR2HMtvOCXB3i7q9XfCwRRjLpsHjEiBv4QNnv1s+u7a+X0D/N19T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-948104feb8eso1109735241.3
        for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 07:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769443028; x=1770047828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdijfS0+OQ3FioX0VO8ULn53/vOnmf0w3wcm1RiEZQk=;
        b=uxUr8TJhGaupPvhgt988r4xmYXvNNzbSgGEHXgRHIBvZbHdV7PPd6H9WDO/ObMn3Ss
         HN8IlrxrHhWRcm/QVEYp+ZjyZUHiwVfTYlDnMCpnzE/2fKaYD0QjESyoQH3zs+RRJzZz
         uijsBLummpSWxY+q+MwQtHc7xLVKaDpIOAy3RMI6COch9vqWgLjQ0jYa9nHBw3r43h8B
         wqbmOXIvRZlM5YKHCIsxKln1Ra/azQL0SaMgpn4LD8mo4jSVsHBtZq5rIGAvN1yI6zgV
         fVE91wfZOMwIjKtC59S7NQ/J6OtFzpf2mAVptNyXvWxOFKJBL1fbvspfoUx3E/OuJhsN
         9qvw==
X-Forwarded-Encrypted: i=1; AJvYcCVW2QhxK79Ap1LCKo5iMT2dtl1CvA2Ey0gOlGQmTgfMiWkNJvhuvL+EUmekJ79CsvDJcLzijk88tJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJnOr/vNIFisPeRHaBzNBwc2Sk5zPRq/6UBIMBH8ChYZPoU6f
	Si/yuunHFDGDuyDIqH0vNiWiev4SrYccPI7wDtEmohju2C/Pqq49LK0iORIXdhqX
X-Gm-Gg: AZuq6aLNhAQgs1LyESxDnTQB4WQSQoVH1dVHWRNloGoKfiGD6cuoE1Yq0ymPW5S8Y+i
	kjibPWhptjB02Ss6pHklusEgEtGLD/PX2KcBovqGRUeauwz0lcuFYOXr2TmWMJNWGhWQIO2ThSl
	hgwcd1nmNQyJ+FImFVx3wnrSemerku51IvixPzHMK2QHuzEmP9n/cxJ7W/ZO5jz3UaQ4Rw0XeWw
	GEpcY9fElaJbczTkK3w6wOOnH01rIyxK3PEoyZlE37C7PVh+sOO1a4P93IrBWUs0L6GwRiPSnWW
	EAcTOWPRsvqde0cH7Dl0b2/XFVkRVLgcm9RIduh6hHT4vhwwCv9Bqj7C8Hb/zp4Q8aDU46cvT4y
	8LhZGtc8gkeVyy2Wm/0uaQ1Wp5cYsgALiEyS7LlDx6iKfpzLhsYjZ7duB28v8nmD/sfdqYtg5TI
	niaCxaGHXZ6+wNZF5CisrBEPih3UaEaO8YU4ah64tyAGjU7o5le2It
X-Received: by 2002:a05:6102:6ce:b0:5ef:241c:e0da with SMTP id ada2fe7eead31-5f5762db540mr1381663137.11.1769443027964;
        Mon, 26 Jan 2026 07:57:07 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f54d3d849dsm1913848137.2.2026.01.26.07.57.06
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 07:57:07 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-560227999d2so1549502e0c.1
        for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 07:57:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUObHtQwfkguM9Fn8rCnbNdOq+iQPU0AnPIeimkmcoNgu/Bxg612xpbzjPVZZ6tgSnQYuwQUJDkt54=@vger.kernel.org
X-Received: by 2002:a05:6122:3a13:b0:563:6767:217f with SMTP id
 71dfb90a1353d-5665c93bc8fmr1333184e0c.1.1769443025008; Mon, 26 Jan 2026
 07:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192706.27099-1-ovidiu.panait.rb@renesas.com> <20260125192706.27099-5-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260125192706.27099-5-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jan 2026 16:56:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkXFvOOcZ07seJ6M5f=6ENEkCnoj29ueimdOJg3MRaUQ@mail.gmail.com>
X-Gm-Features: AZwV_Qih8gRGOzcPfHBZgLb81bZR1XZJrEB5kRB8S9RRMk4gAayWM-Q1oPZZvjI
Message-ID: <CAMuHMdWkXFvOOcZ07seJ6M5f=6ENEkCnoj29ueimdOJg3MRaUQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a09g056: Add RTC node
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Jan 2026 at 20:27, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> Add RTC node to Renesas RZ/V2N ("R9A09G056") SoC DTSI.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.21.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
