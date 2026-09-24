Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFD47F76C
	for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256150; cv=none; b=Vg7TrFdhz4UVaQyOYi77XfixYZK38xZK15KuQ65XYuCrGeMNVeFeKGCyqMnrA/dwy4hzjZfT7wNrDbxepIIHzJWtZfx5eBBhGkULVrRIA75QnW8NVZKl3ueCKxEW/VhlJ+N6k0HeeHOHwbMcKvrVW2WIFgTDnJexazS7v9J3eJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256150; c=relaxed/simple;
	bh=kPTOZqyJ+bUaS6nWmMWMRPMUKRm2JvBCA3sd559mBoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChjtTfHfPTPDhFGBoR4XYJFPACzWYoGsflFpkb0ZyDBz1L30FuGOJeNMT3x+ugCzb/H+y6SWSEt7lS2mXd6t4ILpBNFRU9RBFWP7fAszCsnn6SETy944FZFw1t5kKCYIQkxK6YpwKAIj6hslKhn/o8KVCsWtMyhFuI1apIeghC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsQH2RQl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsQH2RQl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so1591789f8f.1
        for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790256141; x=1790860941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZbOHcUrqzD3VKthCx7J3x5Mps25Ab6sTBEfuEjyv3Oc=;
        b=PsQH2RQlxa/HArHPjKWngtSz7BAzIayABd88w8qCiHuTEGbAYpR8xoMctwfgMi1PgH
         nUkPbK+s0WfmYD42lEUOVdqbr6TXDYXyRP0AUDqqLAg1QssyfdHjcmjKkhG7Z1FST68r
         Z6VU+dc7C/BQI8jUiJrxllyeMgf/8/T/LSJeqCi0clV/pRO/BoZOLdk3XWfRlFpoOKD/
         ZPq/DZ9yAwGui3IVqk1nDlo0hg3wzOPGfN6/bncA3eitOOAQnNcuJ5f4sqEai3/BGeNK
         ghI5+tQc2NIdLmpp71huPBE2SEixkQGmr+fgMILYmOhmywSemKzX/azZp0w6a0oIHNaq
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256141; x=1790860941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZbOHcUrqzD3VKthCx7J3x5Mps25Ab6sTBEfuEjyv3Oc=;
        b=GamY+FksB3otjGTVzs04X0Iyh6M1yMvtDdoEJW3HA7xyXurRhGJlN3kQcLtF2u6nZR
         fzTp522taEsMiVQ+4oAzIgir5qabcLOqgLReklXWt6zNhBExWQRMnA6f6Fc0rYxp8AHR
         n4+d3igSSGDz87hZ5yiGhYxu8nGSlbLN71qlLroxZ0PbKDqcf0U1X9uvf5K91E4sJwbK
         EU4IASRB/evhDLWrUVtSqTXVNhh0IRsB0ISgrCMigYpk8kR8Qh3RffZH+jMHoH/g6iul
         VjR0DwicPywhGW0JheNIV6eAXUnVmjEW9NngnlEiyp8csKZVoVfx3aHd3SJ7BBT8sxOb
         rXVw==
X-Forwarded-Encrypted: i=1; AKwUvBwzgXXlYZnx1ro/cT6/sqHXbiTkmlcHZyZJdigX1j4dajxG0fS+RVYwEIiosVAOuiF1VXED4OwLvrg=@vger.kernel.org
X-Gm-Message-State: AFuF++kIzJwzEnWjFiwNz8XxaGfPHqBM4C5In2be3pvOyU5GFPFU0ODo
	gS+pm/c2RGN9/5HsYnDdGDOdY7DYcMn8COdtwefbsX/aWDm7arZEEJJn
X-Gm-Gg: AYBFou0+XTCGDAPL/BWK6Z3+j2xYa1uGP3aWYuO1+/IWhGRjJIRzjyCp0glhHXKDpZy
	bISJFqDdZsJNYCrkIWUjW2oAYk/xQzeJjvzes+urfRUo6UQkUCrx4DNCmLc1NcvLT/92QzkS+EC
	qzDdEVU1vegKc0/BvZ1HohQTTKtFCuecaYgFhcfRKfNZ7vvxaqy6slB1V57mVtk+TJAoh5+p0mn
	PCivjCjsT2YHPdUCiXkWsxrGBokk6SnOxhrI2TERRnabls+c8eGR6s8ccYjqBb3ZP75XTOIn+BI
	TTpaXlYn0KIbpekgbvW0Vh7bIkERpnFu+J+duMEIOfY7f6zrItD+5XcuS1DOSCksJlGkkMVaqDW
	oldTTnWkCSTQEbw1Z/mM/rr5VBVNxBq8duPFq75drmFfcS4HN5smmkG/GwO3Sjh8ddIm29L2iRe
	0ndwAlgIPZ/Yq+0FZgN0N1qElXOEHB1XoinC8A0IqLPcjqB+J6wOFeDoRXBYgUdbwFANNffakUe
	ttOEZzeU00hX9QmPHSdHdmebc41SisfSRQKL5ovHVNjfQ==
X-Received: by 2002:a05:6000:2007:b0:488:5fa4:e2cb with SMTP id ffacd0b85a97d-48872abc779mr3687759f8f.26.1790256140353;
        Thu, 24 Sep 2026 06:22:20 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm14642949f8f.16.2026.09.24.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:22:20 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Raspberry Pi 5 RTC driver
Date: Thu, 24 Sep 2026 15:22:15 +0200
Message-ID: <20260924132217.1281752-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a battery-backed RTC located
on the DA9091 PMIC accessed via the I2C bus[1].
Access to the RTC is provided exclusively through the VideoCore firmware
mailbox interface (not via a direct I2C register interface).

As stated by jamesh on the Rasperry Pi forum [2],
"There are no plans to release a public datasheet for the DA9091."
So we are stuck with the firmware interface for now.
PhilE also states that "The firmware needs full control of the DA9091,
sometimes with extremely low latency,
otherwise there's a risk the supply could just cut the power."

This series adds:
  - a DT property for the charging voltage of the RTC battery
  - the RTC driver that talks to the firmware

The driver and binding are based on (and largely taken from) the
downstream Raspberry Pi kernel. The main changes for upstream are
the addition of a dt binding property for setting the charging voltage and
binding the driver from the raspberrypi-firmware driver instead of from
the DT.

The driver supports time read/write, alarm, and optional trickle
charging voltage configuration via the device-tree.

Testing
- Hardware: Raspberry Pi 5 Model B revC
- Kernel: v7.2
- dt_binding_check: passed
- Basic RTC operations (read/write time, alarm) verified

[1] https://www.raspberrypi.com/news/introducing-raspberry-pi-5/
[2] https://forums.raspberrypi.com/viewtopic.php?t=359073

Sander Speetjens (2):
  dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
  rtc: Add Raspberry Pi 5 RTC driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   6 +
 drivers/firmware/raspberrypi.c                |  25 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 244 ++++++++++++++++++
 5 files changed, 288 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

