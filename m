Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987767;
	b=l59WqIHsNbYYyE5UYyBoyFM3jyL7UV7oUG0Sqk366EKGYzr4KhpOlAkJJAf5sFVm+NTo
	 Ss5OfT1cn4jOaisg3uY4a+dvbrmcxoo/ozb7uZdhvN5E8ZjUucgl4KyiRWF+GnsZEhA7M
	 PJjqleAqV8VB0HX7w5rqIfgvW37dRRmCkPySyzOZ8kQZhTZL8LuKHsy1K/UjK42vAwgg4
	 5fN5MML4P9JjL+hSDLOJvr0tc103jKYMdSnyjLK7hb3BMTE8kAJ4dznDM4GVTtP+typOl
	 ikN5Z070r0w5Z00dBgPeyLuKy7UJO5rlJpz6uFZ8eomrGRrnW6LCYitmqI//hs9vrnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/SbgHzD04jlGsEuRy1xPY6PzoC2hIAjh79EQrJ0tJMU=;
	b=OeKGgd0ncx4Cuog3uCHDqHeUoexNpNFyLXKevMTxZEtrz9cnk5Mk3iJuGIjdqJpeyTGq
	 x1OYOR+qqQOeluS2LOdv9Zi1uQUGjaiIKGSq5TZqTKQukUNs1SUWgozNl1SgeiLanstCg
	 YiZLBTwolNfAXHdZXBflgrDDCJ3yrZraK9thWriSrWE4G8QrZ373Ra51N5N1+F1btw54W
	 /gpSXuRZQhyt3muV518JlHEGCiatx1hfqXFEenK7cgy43FmdePs3yafnDjzVvLL2cWGKT
	 R5iOP7MC1QM+HBm3OfvY+HkWhbYVLzDa5qldFL7Yvr9stz3KMmSZHvhVvDBlubwKHng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+H0HZfu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A89606A326
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 17:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A89606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+H0HZfu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso8621595e9.1
        for <linux-rtc@vger.kernel.org>; Fri, 06 Nov 2026 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987765; x=1794592565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SbgHzD04jlGsEuRy1xPY6PzoC2hIAjh79EQrJ0tJMU=;
        b=V+H0HZfuTjx0Yt+dhwl4yeTKKlDgXEr3C1GsMwtWgCCUZjAxIesAi7BUXLUNUSahqo
         ICrbdZax4dlin0+p4rGRpLRVfRDMJavHxfuDXVl5AvWk1HxXqAG54IC6BERDolBsf/1l
         gJkrXrEfAtsF+vfP0ivxMiNmYG2tcMCbFPOnLa6cPd1Q4pQRkQIkwmiBhUV8q1iTAMaZ
         zlJo7pppydqapsxWdkYw5O2qjSbYx8y4TMeer+qhSvxjARNf3fBLSrxymEBy/u2k6TD6
         uRuRsBu8sMSaBLbjHUTk4ft50a65InkQLoA0caroKnBb0A8igA0KcIjdJvcDDTAcjIYl
         wYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987765; x=1794592565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SbgHzD04jlGsEuRy1xPY6PzoC2hIAjh79EQrJ0tJMU=;
        b=wTOIIKdXPartItdJx+kafTPICLY+QotkCQabJOvghyYvZGcAL+uksDDgk34LiQzk9Z
         87DP5vSGmTYuop4WDkY7aNgQGAJxjVG15t9KWWcetMoFQ4adSfN3wckZpFt0b/i1qeqN
         swXur41tDxOVTXaxxj95sRvtvc4r5dJpm2ngfS3qxIZYUaS3uVK9K2Czk4SPfe+fR5ii
         KxSXZF7m8+tAfb8dAsHzy2uQgu9K7btQU2wSbpXKHTBxjsHphMxCWMLaeysimPewCmn2
         3BhuxxoZNTLLvNkxXFbLAjY6kKNvNaIg8No6E+Y4Rgn8c2ZIwO3ASgJBIUT6aQgG95nK
         ve4w==
X-Forwarded-Encrypted: i=1; AKwUvBytnenHKyzjvg7ChobblYsPAgW3cu2LkWRT14Y0HLXyn51dTGEr84vSmEX1BLEE6qAYHH1Ik53k4H8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DP5utzuNYoW+PmwmXs9HwFcuZr1eXsNo9W4QI7Qs+KeUlCXZh
	8v35Zbd78+6EO88VgC7NOf0VA7F3IVY1sphgxYz1aQCpGXljmPH2D5tC
X-Gm-Gg: AYBFou0qU4yAjuk9U6SNr176qgYhVwO63aZzSFaseniOFtM7cPFi4yhtqVncproQ6ql
	Qqsdi5ZTUWHnsqcAYRfSQx0buGH5y0SilyG2A7s+bWGc0NzEH40FHjMqlpBqPajfWzJ4j5uaqkj
	9F6iByv9dB4768kR3EIfBKLfmB0CyjAmolFMOE4XNpWhyBNNDD3jysh/8XYhXEPyt1fLOJzUQ8P
	VIvqhYobsENcsgCS56BFvBOY9+kUlnQW7vLgTbEztu66t/FRutTNjCHUVMEnWFDjuoIxpOiJXOu
	cRVouMIzZCeOi4Iv6dKxSqIk3zJ9Eiv+X9G21+AhPcoPsSnfIzIwDklgTFSl702bdya3bmhictr
	rn9PMSpSN10cBV6qGRGEckxLMNYiBNb6DLWtwjIxoRvNZz0hnFjf31rSnDQD5PobB2E8gMJmTCn
	QPH/xx9UH9mV7IJUooF8htQtDCIt0j3bd5+3mCZgvIlZJcvW02w5XxLNTa/GSfAWtHkOEJ2JZbp
	CnXaxSZrtJWVDrp55U8u6KHRchx4IHyXQyQmWk4nSf8etfPcrPykgKIRK5WdQctSKJOEsTjA+Ra
	GcvJwNl6OTRL6GKqNUABmmmCKlTpTm6+k5SuVgw3PRCxO3Cr8Ylo
X-Received: by 2002:a05:600c:4f4a:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4b6e017248dmr56108655e9.30.1793987764822;
        Fri, 06 Nov 2026 09:56:04 -0800 (PST)
Received: from hp-z640.fritz.box ([64.43.161.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723283dsm4649612f8f.23.2026.11.06.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:56:03 -0800 (PST)
From: Owen O'Hehir <oo.hehir@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH 0/3] rtc: Add StarFive JH7110 RTC support
Date: Fri,  6 Nov 2026 17:55:57 +0000
Message-ID: <20261106175600.3877614-1-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JH7110 has an RTC in its always-on domain that mainline does not
support. This series adds a binding, a driver and the SoC DT node.

The driver is based on the StarFive vendor driver (rtc-starfive.c,
commit ebac2b5 in the StarFive 6.12 tree), reworked for mainline:
- hardware calibration and the default time set in probe are dropped
- wakeup uses the generic wake IRQ helpers instead of the irq_desc hack
- set_time waits for the counter to load the new time
- read_time re-reads if the time rolls over between TIME and DATE
- the offset rounds to the nearest step and follows the sysfs sign
  convention (positive = slower)
- the 32.768 kHz counter clock is described in the binding and enabled

Thanks to ziv.xu and Hal Feng at StarFive for the original driver.

Tested on a VisionFive 2 v1.3B with next-20261105 and v7.3.1: setting
and reading the time across the 2000-2099 range (out-of-range years
refused), leap day and century rollover, the alarm interrupt with
cancel, the offset, the rate over 60 s, and setting the system clock at
boot. Not tested: suspend wakeup, drift over hours, and keeping time
across a power-off, as the board has no RTC battery connector.

Known behaviour: the RTC loses about the length of a reboot across a
warm reboot; the counter appears to stop during reset. After the
StarFive vendor kernel the first boot found an invalid time. I would
appreciate an opinion on whether this is expected of the hardware or
something the driver should handle.

The binding lists the RTC maintainer, as no one at StarFive has taken
it on; I'm happy to change it if someone from StarFive wants to.

Owen O'Hehir (2):
  dt-bindings: rtc: Add StarFive JH7110 RTC
  riscv: dts: starfive: jh7110: Add the RTC node

ziv.xu (1):
  rtc: Add StarFive JH7110 RTC driver

 .../bindings/rtc/starfive,jh7110-rtc.yaml     |  85 +++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  14 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-jh7110.c                      | 324 ++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
 create mode 100644 drivers/rtc/rtc-jh7110.c


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.43.0

