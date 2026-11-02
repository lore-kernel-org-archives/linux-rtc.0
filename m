Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597634;
	b=gHMzJRMamE2ag98y5jgoy7ElNwnWxs1dPIVZlVIhtOBlsbX+dhJDGJNdbvJq6WyynAD7
	 sU7rCGsZQHZS6XwW0M3tyDZnYBcWUoTl0n6KgS1X222hUSeavSkMnuZZNULm9ttpuEZ+h
	 GhBgTG3edifoCFwUNC4AAfyx4JyMvGII8OaOv1sxSoAoWFOXWoTgnvZdloP47CLRFMfoY
	 xE1OZikJY9Pcn8cygQsQM96UOnH6ehJ7/YpDmGyWa4FfXNXS2cqFU/DVOOu7lPWWZIC8S
	 l7QYaxf6FU1F508CBIS33PWFZruwuBJ8D0oM0U1ABJ8SPIXWvbW44Bjg9qPRye0XX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=I5XmwGd7P9E6+oiwB7TsngJgYsa5mbeAvM601lSlbzM=;
	b=a6na4vuwV7iNNQ6GNE8izOLBoXrLr+O2z5ydxIRI0nwfeTKq48/+L3m+hvoMKRxEXtET
	 oMQb4/XS6Bacv2qppRarPHQOfPOnzkw02N70hCK0e8Ab1DJ223Fgt4AtIG6FDoc31BpW0
	 ZlvqItBc0AXlqFBXp9CAQmAqZlERfj2algFnAsc3cII3JpnBQuIxOHM/mmg9pdBRkOvX2
	 G0eG7Sqnrk1u++46HO0uE+nkolxbxbcaoDfZRJyE+D7dcxD7xL/g0qB2X4sgAZRdaYcSY
	 aFJyDabcjVqYOMlXLiBgCiXHgffLZkVFOGMIBpFk4qz2KwPFRpbN5Efw+Rt35BlBShA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gC5JrwAB;
	arc=none smtp.remote-ip=74.125.231.132
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0BA606A32C
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 05:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE0BA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gC5JrwAB
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-70073621339so1569637eaf.0
        for <linux-rtc@vger.kernel.org>; Sun, 01 Nov 2026 21:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793597633; x=1794202433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I5XmwGd7P9E6+oiwB7TsngJgYsa5mbeAvM601lSlbzM=;
        b=gC5JrwABTEgrHUcKQSph9CPY+fkkrfymHcqg5dnBovsdySJf8Wf+t6gXIID7ZwVMab
         213xfh/PT/H66fsEzJs1qZz8BO28sPN9i/7dzLrNaDasGb73Pfe9sY4mCLcBE2Q5/xY2
         +3huQcp9h6O+kpGD1diro5UffKGnF66W4HpE/HnNyn8RpYD2lrVpnBgx/x/jxNoVdt9/
         GUbbYI5aNRvraCEAk1+3vNDT4SxB0cswUwX21ylxdL5Ib6q1ghVrbXVR88QJL3G7Ynpf
         Zk5FahiBxEfSPNRKuleq/wSdzTZdxxHloyAYrm9uOCMA3qtfdx4SxgYk7NzrunyCe6bv
         5t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597633; x=1794202433;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I5XmwGd7P9E6+oiwB7TsngJgYsa5mbeAvM601lSlbzM=;
        b=OvWBUHYbbHaol3UbfpCvj8p7L+48JNHz9efru26ePYdFWZX/VYGFfqX97fONhr4Pnd
         /2Hxl7Q5mKdvnglXMcV+UU8ULMKIKngVuzZkUhDeDjmeFJAXX2uwWSlCn6Pg9CYBrMBf
         cnVnmGUJ5YgomVszAA71OeUIDfXBOqY2edzNtS/XOE/DuUw6Mu8BU1s2h56yU8EZMH4i
         ngpTXR1wDsdG4ZQhasny/3h301+fiCa4YUK6Fi2L6UVNHECoIf3In8sNczysdmyI17af
         PKGj2ni43+65rAS7Spg/DEsotb661bahEzexBufPcMqjxsxTPh/6b9aWaAPXoHCybale
         Cjxw==
X-Forwarded-Encrypted: i=1; AKwUvBz8/MPyedoecGBgyIGcWiDReXiGGSqLDOFYbQ/16ycWzBQ249tp7e7GfIpGg9BxDGx9aFNsmSBM//E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiiQzA9tiGGNQLhs716+/5gzJoWl/k7ZzVl3TEs7Gr/107qENv
	W+9J5AC8LX4kEsrwB4aC51jWmO4zg23cTniU03y9jmruUC8Kt/iuCDGJ
X-Gm-Gg: AYBFou0t0sOhQ9Xoz6siKSBn+UDO1NULqg30yE3A5b1PxjH2rQo8Mtoeqob6pOQ++pq
	k1EmiwRCMS/eDtA6o33FUeQHuykMDABCW5sfB4QEoXvwUzrrdCE5AoePxXpfks/CeyfscCHSXfo
	INcNTKHFXEdYk2MHWbANF+iWL1jAwcKe4WFJyR8jM0rZ8kT4BO72nQMieogNSuau20P21kpwUFt
	uF4id49UfpknMY91rtJawO2SDK0gVZFdkNBRTIKlfo9JoePvXaaLv5aXdiCi97jLCuGxmpwb4fV
	GF/a0LtlePAq8vIn3bCL+NpJ655Ai0RcDYd/QIEG9igN+hXQBJQpIpYygQKshBRc65e/QlT7yh3
	pzlv6NxId9i6liwyNMXK0BHIPRh8ZKbXcLouV/bwOQ/xueaFXAEzZHg85eQrUgZcRQQVi9DGKJt
	u+ag+T54qT7YwRBWYIWlyX0qD8Vw3Wch20zGmnZi/zxL57uhKND0cVmuYFKlFp+5/QSWBNiFttw
	s7wqSbHhtqXNplc5DzoOx7iGhcV/N/NXECxAD2Zwhuq1rprGqEBpObqSrKK9NPb6gHWeKqLTK7q
	gCqQDEcr9+dR6XMB3S3NfyVC
X-Received: by 2002:a05:6820:208c:b0:6f8:2346:cd78 with SMTP id 006d021491bc7-714f24fb531mr4934585eaf.5.1793597632682;
        Sun, 01 Nov 2026 21:33:52 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm8321164eaf.1.2026.11.01.21.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:33:51 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH 0/2] rtc: mt6397: provide the RTC's 32 kHz output as a
 clock
Date: Sun, 01 Nov 2026 23:33:45 -0600
Message-Id: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQrCMAwA0KuUfC/QNqNqryJ+dDWbQVZH2oo4d
 nfBd4G3Q2UVrhDNDspvqfIqEI0bDORHKguj3CEa8NYHZ/2IOmlnrJ2/2LfalNMqZcG1BbqcUFt
 G8k+0yWUX5kB0JhgMbMqzfP7P9XYcPwxqctd3AAAA
X-Change-ID: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793597629; l=2043;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=+AH9smEBqnGEd7Be3eQjkLdg1eIcwhdAuP4jWupgQ64=;
 b=eov85h6Nzm1K0qbn0yx99tHtOauCX37OjFlOU3aSi5SRuzvUuLcnssjUB6YtD+fdgUHfOIXME
 oIzVcU1KxpLA/SNkK/Wou5Q7v2zxcnGEVyrhCx3FDnngfTHaWMF3e7u
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives a 32 kHz clock out of the PMIC, which boards use as
the sleep clock of a Wi-Fi/Bluetooth combo chip. RTC_CON.F32KOB gates it,
and mainline never touches that bit, so the chip only works if the
bootloader happened to turn the output on.

On the Amazon Fire HD 10 (2017), which can boot through U-Boot instead of
the vendor's LK, nothing sets it in the former - the bit is set at every
boot, and the MT6630 combo chip's Wi-Fi and Bluetooth never come up.
Letting the RTC provide the output as a clock lets the chip's
mmc-pwrseq-simple enable it. With the clock wired up both came up on that
board in two boots out of two, and in none of three without it.

The driver registers the clock only when the RTC node has #clock-cells,
so no existing board changes. The MT6323 shares the MT6397's driver data
and gets it too; every MediaTek PMIC RTC whose registers I could read has
F32KOB at bit 5 of RTC_CON, but for the MT6323 that is inferred from the
shared driver data rather than read from a datasheet.

Both patches apply on top of the RTC nvmem layout pair, new in
v7.4-rc1. That pair went through both rtc and mfd, so I'd suggest these
two go through rtc only, with Lee's ack on patch 1, if that works for
everyone.

The board's devicetree that uses the clock is not upstream yet and follows
separately.

This series was developed with the help of an LLM.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Ryan Brue (2):
      dt-bindings: mfd: mediatek: mt6397: describe the RTC's 32 kHz output
      rtc: mt6397: provide the 32 kHz output as a clock

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |  6 ++
 drivers/rtc/rtc-mt6397.c                           | 85 ++++++++++++++++++++++
 include/linux/mfd/mt6397/rtc.h                     |  6 ++
 3 files changed, 97 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

