Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772D568523
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963201; cv=none; b=rpWJfX6OJiSuOMXq5xId8SRC9aucvmdEmVkXUSqNAV+Su49GEP/E8VZeRoqW0UxXvJ3qvTlEThhX+hEOmlljFdBO4bvult8p6zwajBjENG+B+Yf2LIygN9VQrNzkT2SUpKzpQyYbVPhWt5hrZCTbJ0s8weszAu4fbvkji/PSv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963201; c=relaxed/simple;
	bh=gmFmfrJxoA7Nug84IXGdn2hbInOVt7EfY3z2c5RGPzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db7ZrU3+VXI8JbkMLf4i6uBoOcb1Z52amS7jA2D7OezW6WgkydCz57HLHY9I4x8RLXySUOyDnVC593W9xNJSe33lLePH+H2/R38Ml4lECNt0IbAHVBdwP4rhTIn8IMIHPia4VE71ctDoTdtfPUJSneFttft88qN8owr5fm1kpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hej+Qxsg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hej+Qxsg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482ea739de2so4085635f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788963198; x=1789567998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVGNbjOGRpPw3H08VWW1qB2tpMVtFhtvxOuvQrtYFmg=;
        b=Hej+QxsgaMjR8YUZQf1FayQskkaC3YcXIj/BSyVBk9HLGtfb4nCVVBOnUd7MD1lcr3
         b7AvvLeeDJKSagAFIVq1BwhEGQqmABXAR9CR5b3MzwHXH1477tsUmafPIC0zZ3lwepBo
         YWcbQe0a/U+WT4q0GcM0XS+rooJPm34LfDvABXFDDZWVgtf24A4gaJcrTbaH3UQfDfA2
         3dV8HFNrKMA8E/b4OssVO8ZAp9mf+iLDp5EKtcOME0nXpkS3CubjzsN6X3aNDit+xxYU
         LSvz9DvHYKj0DMHvvuRMO0rwgAfaOm35DMGAOHeTFddtPGe5WwJmaN2wWwNRGVwNrt5R
         hYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963198; x=1789567998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVGNbjOGRpPw3H08VWW1qB2tpMVtFhtvxOuvQrtYFmg=;
        b=m4KTDsRXRVtKI7uj+xGTaeloReEfskV03CvZgEJZnsWAuhpR113DEooi+Ll0ODboiH
         eDaMlY0D/U1/YOSbwU2koP4XmyQnIolDJJh13cQaR0F2C2u6za/xrpqecTXbD858+3JK
         onwf9GnfmmXgYzuLkMymvtwiOx/h63MU7QrsbJy/gMUDL8wRkDHN1z/rsPrlC1jqfAds
         p9eXKZy6rGqVdSm0PcHd5YubpsiSpt1K6vb2sAnMQCwuHxlRI+8/yhzTSxFWxs2iq4VN
         Hrxvk+gqLJWhUdYtuXsRwS8nucMmGtbYYhMXXwGdVY5jHrIsMg5TXY90dfXCN0Rglwty
         OE2A==
X-Forwarded-Encrypted: i=1; AKwUvBwdbkmwGQ5S7lsAqtYXJMuIcSMRA6ygbm3gbZGCxZ21Qf/sthelwaFBeFBswAOfurzAFInUc1ZZ0LQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m9JlCWDQBGtmn/2kl027/MtzT+3hCM7iGYExVB/UWJw+oMsQHj
	tMy2RKl9F2DDXWN6FUwaosWYBo2RuVUf1hzHYAsOBKSUZ0j/PDyD9qB4
X-Gm-Gg: AYBFou2cI62yJaPOUYclHtu6gHW7fNOgGdQXXTopTWvYZnXc1jm+5Qsg/VPNX2RAUVt
	JbkLkFSpNJts3EYWzuKV0MBkBqCePigZu4kVNKqVvqDOmo0wemalmEFm5ooh2qA0C7EV/PimRNO
	xLSJW0OZEGQUJucgHh4ModopbgvN7x85prTsMqQRgmvzW9lk4F7JUM7KkKhGZ3o2Ic+ILSerSfy
	1BDEZ/TBO4zwqBgYv+MxZ5XakzlEI3fVPEsEvZUHN/kxvt42dZWdXwym3Caoa0sQY37DEVIw2Uq
	MUubf363s6gxW/WrksB9O/81eiI7ZylQqnyb3B6KDzvvhY/UKHYVhbPHPHjD5k6Ar7gzbOlxJxr
	2ch4zQbrtH8L+Y/YWdQDOvOmRvmbNmWKGCv9cn5tcgtSyAHpvzrogs/62B4KIyV0G/vwMHK9Jsw
	hA6HnUZVqhDeCUuC0EgPHT/YMeY3mXfozjbHdMLexHDmTQ9c0e8q7keaI6dVFBkHTR3DvsMrlUt
	P5ntyQ33Yxo5oTVsIGBzIFqPgtb0K/5GGjgAukwzEPN3hwcQOw0OIEJBA==
X-Received: by 2002:a05:6000:184f:b0:485:b148:aa13 with SMTP id ffacd0b85a97d-485b148acf3mr3046846f8f.40.1788963197769;
        Wed, 09 Sep 2026 07:13:17 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm43273521f8f.23.2026.09.09.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:13:17 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com
Subject: [PATCH 0/3] Raspberry Pi 5 RTC driver
Date: Wed,  9 Sep 2026 16:12:57 +0200
Message-ID: <20260909141300.1368790-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a battery-backed RTC located on the DA9091 PMIC.
Access to the RTC is provided exclusively through the VideoCore firmware
mailbox interface (not via a direct I2C/SPI register interface).

This series adds:
  - a DT binding for the "raspberrypi,rpi-rtc" compatible
  - the RTC driver that talks to the firmware
  - the corresponding DT node for the Raspberry Pi 5 B

The driver and binding are based on (and largely taken from) the
downstream Raspberry Pi kernel. The main changes for upstream are
the addition of a formal DT binding and moving the RTC node out of
the /soc node (it is not an MMIO device).

The driver supports time read/write, alarm, and optional trickle
charging voltage configuration via device-tree.

Testing
-------
- Hardware: Raspberry Pi 5 Model B revC
- Kernel: v7.2
- dt_binding_check: passed
- Basic RTC operations (read/write time, alarm) verified

Jonathan Bell (1):
  rtc: Add Raspberry Pi 5 RTC driver

Sander Speetjens (2):
  dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
  arm64: dts: broadcom: Add RTC to Raspberry Pi 5 B

 .../bindings/rtc/raspberrypi,rtc-rpi.yaml     |  48 +++
 .../dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   7 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rpi.c                         | 277 ++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
 create mode 100644 drivers/rtc/rtc-rpi.c

-- 
2.55.0

