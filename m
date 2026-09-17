Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005B477E4B
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648570; cv=none; b=EZDUu1St6JQzc9kNvVyLggP7YRVNWfrehDqnVy8FfIDZrIKvDK65e3B18JnmFWtLQJFdwiDXs/WgDsl3sGrzw/sp0wIGcP48F9XXghCnOvEsZN7fGNQxA4UuIX61MEduee5/ouLlzCU3tfkLRZUpw9XBzNYMQGZNa0EHWFNRgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648570; c=relaxed/simple;
	bh=3jBklx3OV81z21pgMfCutwA9rsrppPeVwShGVq099SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS/kdFh7U8Glgp0ZTuZUB3GwmIFINjuZ8S9nO/46L+xSQo3OFyRgg/zE4SHcWxwFaX9+S8Y7y4P81RYydnd4OtyuPNuKJ6+3kaE2WO7tUSZBKmTtHK2lGEj83ffizwcPkkJst7IfrfYZCwTC4vZOLEgAHlobrr8F+jP+8RHgGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so209878e0c.2
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648559; x=1790253359;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aDhAcwvSBAcGlBOnGD+Htro9uYMnuj1oYxROHQFN0Ig=;
        b=2iooeV3Bp1Ga1XXsHko7JXxcqlBlUDXl8zPtFE/tfDUx1dvLRmLvB219d+lJYD9Rvb
         ZBkQoKppBC2b+8loIK66mx55PFBM1BgHX36YuUawSgSG8wbsQCoPg8/QoOdgFQJ+fvmb
         bLCoi05rCGzqKZziiWvY2YvThdkLwxge34vWy81q7zttSwHxJiyNUFRIWIlYs/TNdELq
         Id3OueOoo2btVjbe7XzI0rgfiz7LXWeP8osoQzpQC1qsnCC8iUjLoFj9+7gfglPFw/IY
         +QJEaYAFJxKsR2wbMAbX5V/hK9vEmj9VQF3+8fNzxDJXysX/tyzKRvad5Yncu9XA0nBm
         f0bw==
X-Forwarded-Encrypted: i=1; AKwUvBw+lDCsi5XnTFEKF67Mew8oIqbvGpNlD7L/TE6lK5qC6VkkhyyilDnfKRSatHhpXaQwEkp2D7e7fsg=@vger.kernel.org
X-Gm-Message-State: AFuF++n29fce8O334NETZwD0XYtrXaTZTV0P/jM+y19ebqxVF+l6pN6N
	eeacDIqjrWTyFnaUNAN1URBe7gbjKUuJ/9ubC9jmX4Fl6KkIE6TrN/uBzAvWRFnMuuk=
X-Gm-Gg: AYBFou1k/WoVUaap1pNqzN1Ai1dcDHH5HuKlVNwHeD8epJlTw4T8/e9FH/WcO4vqxUt
	PXqG04sTm0qiau1dTsOAybQb9dUQ6gsIgUB3JglWOUfglmvmfYgHCV13n1YvwlYva0PF/TBLfhC
	3i1Im96ps+ZoOR5sDLFdKRH5yBhs3mmDjN05jimb/KqIoO9Oh40lOMUXuhoX9rAzCP7cVoV8Wxs
	mHFaMm4e66qDgU8IgD6zE0x+b4xH6aM8Avh9SzdeouuJQTLN1TtMglcXrI7LQqmaRIlwx04gx4F
	jc8iNSVvGmU1lbWNF3tAAFjuZLjcarhpo6ooLodQzuZHHFhmfi7JIkoPeU9EXCasWTXTB92X51h
	/gvDsLUmO2WvU+kPJbV9XeiJzE4QEm1gl1WgJ07NKWfx7ECaEePTM7uZHR6R66jgVZr6wEqcBmo
	FR6qKAQy1g4obiTw1Vt9yJF+e0aMTWYWxC2nmOT8W5L1U9hFEI7aEcrEGWbu9704Khn/8+Rnqmv
	1bWdaMrY1kKp1K87P3KNuZ1htQbGYd3+yV4WA==
X-Received: by 2002:a05:6122:6612:b0:5c8:fa1e:9f5b with SMTP id 71dfb90a1353d-5c99ab0e8acmr7377954e0c.2.1789648558899;
        Thu, 17 Sep 2026 05:35:58 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9a5357472sm2568488e0c.3.2026.09.17.05.35.57
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:35:58 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe7so206934241.0
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:35:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJ/X9r9BoWpDMyjzIkPUh/Cpu2LN+/65ZYTzOyMwhmJ0thov+tv+EYTjYlOSkuwdITuTd679kBj6A=@vger.kernel.org
X-Received: by 2002:a05:6102:160b:b0:79f:eeb7:d643 with SMTP id
 ada2fe7eead31-7a028c6cd05mr6743315137.10.1789648557334; Thu, 17 Sep 2026
 05:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com> <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2026 14:35:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcFKZO7GA-nQ-BH-1k127ZAjtUaZqHAbu5FGTmuCmk3Q@mail.gmail.com>
X-Gm-Features: AcwNN1UeqeHi3FMvuG4r-xFK5-Yd1nEb0E4krEULSwZN0Cf2ZFOfdU8KBvHRK1E
Message-ID: <CAMuHMdVcFKZO7GA-nQ-BH-1k127ZAjtUaZqHAbu5FGTmuCmk3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 13:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v2:
> * handle only X5H for now and do not fall back to generic Gen5

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
