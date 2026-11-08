Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173311;
	b=c3I6oz5pYqDzeA3qKOogNPrkx23vpnweBKmm3+eScWdmxbtX2TpzRUwKGBhiXLn/OHsq
	 8Dap+6zHUp69fU6VswI8h0ApFGvfIv21ihKEFx4eUTlWahhr8RwFn10ZvrD2bMeWN2lxW
	 DpSEXLRI15KVTx8S1t2I7CS0BmbwMT0xtk1Ik02gM18Xxj1szB5vycDTFpRqEz7kAzy+i
	 MDrR3rB809xo9MTXYq1oxiYlOtpjtKW54OV1Fu0Ejli5cjcst8i/imCsWv+n4YgP56klG
	 iJ9P9PjOveulQBz9b0xyaJ746O2qiOyLcySLQolSc+lu7ZkLt23xMJFfuKKHT3TXIWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rNVFVaUcgRGLJ0+IH7bBFs2bHZ28CGULMybIpv6NCcA=;
	b=kAwrQOR1obIAi8nXVOhfX/GCq4MHLikXJUDzunTpxBXunud7sK8nzFfFBNFd17fCNurs
	 ILJXUjD5AIe1XUrx/Zruz6pqLkoBKVuoXnc9jPGjmiy7krNcvxjbAxSfPRjKzq5bzEIgg
	 5DhczD4IZDbz3RUqf9yxDsdUrgUowfk9/L6igo9U4Wl3piwRl57U6BojqNF2RHYxxJI8O
	 0f2df9OHjXpc020slreFn3nxT2oJa0jvmmxDS8p4UdIz89gpkVNiB0ipe5qndH3W/4Int
	 SY/1/HnBYNb2lgIv1BmQ+05LDUxgDQSYzoTOWFvKgAg7NDZjwAvwqaUEsY9tRLnxeOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+F+2Bwm;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9DE606A31C
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF9DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+F+2Bwm
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso117816f8f.1
        for <linux-rtc@vger.kernel.org>; Sun, 08 Nov 2026 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173309; x=1794778109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rNVFVaUcgRGLJ0+IH7bBFs2bHZ28CGULMybIpv6NCcA=;
        b=Y+F+2BwmYv0DtI5WOVJMdRg207Njhn6eyGCR6e0FzV4rgq1N/TQt94orO7XzdbyVDr
         69xU8w3l9e3PvI+9rmrpR/oUU3a8C6uBuSHNUhGmsDGhXQlM1dBkod8PZ9j+n2D5ZDfy
         ooO+ylP0lqi3cUDo18KJelZ6kbyoIvhqXAVcePTpfYbNfxkUArhC8R6BXN15GlV1Hrs6
         Ll4GWvpnPmDLVkACkZxFQ0ymePnrTlDBAbaW1FlGnmHG21eFkEW8SZa3VwXMCkIIHLbi
         9ETtdJ4lA0RlOYRNSgae95R8OI0XM/86YfYu2VtV36V8P/c6bo+Oy+M2oyBzFPL10dd7
         UYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173309; x=1794778109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNVFVaUcgRGLJ0+IH7bBFs2bHZ28CGULMybIpv6NCcA=;
        b=whoZlCba1LkOlG7iO9V78j47N+wffWVAZs9zcq7/Dwl+M/5y69BKy6JotTwNM7FeuG
         eWiXlDaRbBP2MxWX6Zx9uklnCS5WJZ78Zl5SqfnwQ3sWeJSSDs5tzGUxL/xjoOAcIhM7
         bzsXiJv9rpwMOOrB1jw98RO84j0wKaxrWheg+MZsNrDwXWRTW2xs8VzU7SqTSFwIC7Em
         dkU02bbA0rbNcaKrrHVtky0Vu6PM1zRHi1WCU2RgEREhG0XW16DtHUaBZvHwQJOkLXi+
         hq7M6rHd66WQoLsYv7XADUyi3JskzfShC41IMPn64OF9u4Zv27vfn0RFb3yiVUw8GyNC
         tKcQ==
X-Forwarded-Encrypted: i=1; AL+hErGIpKDmlhxq0zj2am13/QyBcxDN7gSTVUICvtuxHHy1BRE3i4x5T9vkm4OH30SBwHXlF/jRCP+t5v4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+u2j4rQbhrQFCGmKmuHXHaZg99c1/6hPpDDeu34SqpiqjQVjtY
	52AKvaOomTesLVlkVMQg171cCo3ExUAhV69a0gGxkXijS1X+77t8haBT
X-Gm-Gg: AYBFou2vUP5xDa8V6C5WUpyNKTW/1ZIfhZTX23gxX2VU5/SzLkp2Xcg1dIv+Dq0sBzc
	X5n0hw7n18wheKg+fmlqk7Yq2wvbj7BMupwYApD4Cmk7PSv/wc/AoUxA3YUpehb3+/y4vgiTHoi
	UiF1RxzkK5O0Da+lNWnzcg3mAAeT4HL0q13VktjdlcRN+vlxJHzbqXncCuSQd5FEIoqYvKwV2Nz
	7+eg8O2rnVJS3htdxe559lJjE++Dtg1ig9Bnk8CncsqLWwsU6cxHszneNAIp3GXYU3aFCkPUD2r
	7VwzNGXyCb9j74ennRQNDC437xmgbg1PvqDYL73hWkz1/x85WRHFTUQdepsNZn8o1qHHJdHMsBC
	VyYVTRMtogZ51RLdklLUdDmybAV3208R9yDYe3m5Ln2V/H8hc0dckIWk3t6m1mZ48ymtPPXGf9c
	dhY5g+2ojuiRjEUYhF4hk4RQ4ws7YfaQAxyMKNtpZX/TW/JKu0BH3r+VyXG5VN29LAPsWgElY/9
	CVYL8AV0BGtAOsqAylfU0IjpSy+pKdC4TjetI84WF7CYc7V/AFvvByvLjw9j6I3FaCaMbimXdo8
	RbN6SZf5A9LbwuP5pRQuGeLHnOgA/E2EAQ==
X-Received: by 2002:a05:600c:c16b:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4b963c6754fmr40690035e9.13.1794173309099;
        Sun, 08 Nov 2026 13:28:29 -0800 (PST)
Received: from hp-z640.fritz.box ([109.76.148.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597091400sm5692050f8f.32.2026.11.08.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:28:28 -0800 (PST)
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
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 0/4] rtc: Add StarFive JH7110 RTC support
Date: Sun,  8 Nov 2026 21:28:22 +0000
Message-ID: <20261108212826.15890-1-oo.hehir@gmail.com>
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
support. This series adds a binding, a driver, a MAINTAINERS entry and
the SoC DT node.

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

Changes in v2:
- dt-bindings: list myself as maintainer instead of the RTC subsystem
  maintainer (as requested by Conor)
- MAINTAINERS: new patch adding an entry for the driver & binding
- driver: drop the <linux/mod_devicetable.h> include (as requested by Uwe)

v1: https://lore.kernel.org/r/20261106175600.3877614-0-oo.hehir@gmail.com

Owen O'Hehir (3):
  dt-bindings: rtc: Add StarFive JH7110 RTC
  MAINTAINERS: Add entry for the StarFive JH7110 RTC driver
  riscv: dts: starfive: jh7110: Add the RTC node

ziv.xu (1):
  rtc: Add StarFive JH7110 RTC driver

 .../bindings/rtc/starfive,jh7110-rtc.yaml     |  85 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  14 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-jh7110.c                      | 323 ++++++++++++++++++
 6 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
 create mode 100644 drivers/rtc/rtc-jh7110.c


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.43.0

