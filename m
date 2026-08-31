Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9E420488
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199883; cv=none; b=YzUwxarE4kwqOa0LYcxWF7XUvRonxhqMhxH2O4lVks7v+aipeD82FxccnM+peeltbKaeUPvhjWwivsq4hsDvZjF7sUlOBsP65GCgNkUuVd/pUTImGU1ANZ8WszfyLeAiU7Epg8vQNEpBQXQYgv+/2Kg6dQ7LhwE/LNh9wvDuZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199883; c=relaxed/simple;
	bh=GwvVmdOasksVQpTljB1yONv+ydx6AdGFOmBJEsuZ44Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kFTgS4+N0+6YwjXpyqANzM4pxMfAI6BYsImrspbNiDZspDDNh/9LKkGrx/bxPPlM6HYCj8aPb255g7R9Rq6APqZIpJTJG0hfMNllVUO+JN9DveDE3zYllqinhCT/7xigEMZzIKHzuRxH0zHyZ2/vVTbP7aBDS0Ao3s93rF1vos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A1c0ZIc1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A1c0ZIc1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so140320a91.0
        for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199881; x=1788804681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HY8aVkF7j6juR+nATWesw8MV58ZoElmwKvQ+IQ/wROo=;
        b=A1c0ZIc1QmUV4KAlhXdTKv6KAdA8YI43TyW+oTU2iX0wWtIgcjLF6OGOhEQAD4/R9U
         eIj+fXec7VmepV659hDg7gkNuJWk3B2jPEfV9jqDZs0YaIY1HFybYCS+2g1NFvrQMgag
         6li4zSIq85/s9qez3EPCHGKuAiyqJlh9CnI+U0oinwGMzn9uQQ7xMJhZm5sM7x/b9w5Z
         H8q2S3UgBLgfjkglVMlavAI0NsNO+BRMdIuHA7CZpo+HPVABoyMzL1AdA5wA/QQ4DEv/
         pafwew4AxS8kr7XQ4mLub5QA0JOMScUvlM/mw4AvpLPIjG0DRZ2YdI2/xxAKKs9nF94e
         HBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199881; x=1788804681;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HY8aVkF7j6juR+nATWesw8MV58ZoElmwKvQ+IQ/wROo=;
        b=deRfpSCSvh7B5WbsD66z9WBqOH6uP5fNN8aCF5rFx2+Mo0xXLBtZl6XguHAH6j1/uN
         dzvi5GnKssk0mrm2nqtqAdgaNUVhDE2Jsyj2yMGVMEneahCRmrFN52o6D1MfiWGYPGPj
         L3dx6oaU9HLb1oSDxgw1yBhEZv4rvIiirk9q/cb1xglNbeoLySz8PLs2U3V0q2v9e5gr
         b3Qy96sELVBL+cDZwJhPHGSy2RhCkKENiF1Q/fSuioUcvY05u2nfadMoVnaRS3FfY9e6
         zEgd6sMS5VIzP7vPquOKGNLra+8ozwtIN5xwsSvKb1UoDD/0Lj66/i1hsXZ084XSQpzq
         6utg==
X-Forwarded-Encrypted: i=1; AKwUvBxQe8+B3rXF4zcwuHyX9Ka6rB41TN/4YmL3qJq7IgSFPsDwVlqIDImdz1nOBHR7z7Y82TPb3uVQyhM=@vger.kernel.org
X-Gm-Message-State: AFuF++nkD7j3N+RRGHdLfBt1RGK4+YzZ8jdC4tMokR8vXxUzKyjnLUJc
	yWFTs9VslOaSZncWVimQV2EFv/zzU1AaHeWodTYl/WQw3Wdr8WReARrjIC+1JcQ72A0=
X-Gm-Gg: AYBFou2cCvQ7sgS40mm0SkZAwB4DPO2sINGMH8VwTKIkjuywvCAQG0QSr0Axq8FqLo0
	YMlcnFHI1zzBgP+L3qN3E679tRPp7B7W9lzDR94qvlmQPhQekLFsX0azwHEFUidnnbqZRAvmw/k
	DpPHok92iAFAakJLhYKxMvviBsjPM/+gbwnjZaDqa4G7w9sHUvgMWFnHYs1wmOmioyXF7WxuldE
	IJb6cTBGpvaTp+2iVO7aWjPhEtDMTQ+pPWrrFcSNWZHbbN98VHCgm1OTO3hkmmJj/GgzwEKHwJL
	pdgIu8xqhSjCy8b99LCb34G/dALUT9yUSEoL5k83QzACmsA1A8u5m8PSQbr6NezK5PXoD4xXLjx
	RLajNiyaYbyTPKRo4V0ZR/3XnjWyxUj0ZxABEJjyjcjv/zm8mtiUP3InbCF6pPUy9+Yjp5ZP+9J
	aPLZ6x5e1tKmReqkvxOAI+CBgh4bn4aVNd7XDD9RSfJhaCqb58ZqT8I9Y8Pw==
X-Received: by 2002:a17:90b:5102:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-396d0ea862fmr45988035a91.6.1788199881361;
        Mon, 31 Aug 2026 11:11:21 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990bd1b395sm915178a91.1.2026.08.31.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:20 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
In-Reply-To: <20260719141008.3562347-1-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
Subject: Re: (subset) [PATCH 0/2] dt-bindings: rtc: Convert to DT schema
Message-Id: <178819988045.2869653.16639071093612124641.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:20 -0700
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sun, 19 Jul 2026 14:10:06 +0000, Eduard Bostina wrote:
> This series converts the Texas Instruments Palmas RTC bindings to DT schema
> and resolves a node name compliance issue.
> 
> Patch 1 converts the text binding to DT schema.
> 
> Patch 2 updates the tps659038_rtc nodes across the AM57xx device trees
> to use the generic 'rtc' node name.
> 
> [...]

Applied, thanks!

[2/2] ARM: dts: ti: omap: Fix Palmas RTC node names
      commit: eaeb86b1194ef162254059ba6a2c5145d1ed7ef1

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

