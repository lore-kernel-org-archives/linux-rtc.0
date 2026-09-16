Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26A4DA9C8
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592025; cv=none; b=mkHmesrlaY2qKpg7dNfB7AtIv5FYqs/JhYbL5TWHxG1QkeonOlqgA+yJ2Y27hKeLqssefHxIkTWEA3Zs427Ukid5pmVxcPsApvHigEJNcbdikbkkyo1UmMWNKAl4CSkC9+WAmWCAsZkkbhWt0JTCI8MYi7nVMvzz0G80735+qQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592025; c=relaxed/simple;
	bh=XPHm3b8/rIzDZZ4STJ5Xi89X9+v39OyO2AgXiID+OyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFMu8M7VHzDxN3UA3Yp6f2QT/kiehjClsKj8HfQA2pIrhihhYKsS4zFl9JszA4xJZsLXi/hVnvAosfjvyE6SD4qjbL7rXeo9vRzhVK+YR07TiFJb0ixboTBP4zW+3yeaV8w1zac1PlqJA5tEwmPYcthxFHYS8G6z4WHRaP7aL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFW1PcAv; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFW1PcAv"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so74464f8f.3
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592008; x=1790196808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzAo6Eq/l+nsylIXF7K1e1k88qd5mp1HvFUw+KqVPy4=;
        b=tFW1PcAvmDc95YkuSdhRz5SoYlfkeaRaKKgZcDOHyDWV/OiIUX393yutYIZpGnVs5M
         q9XjG4tPqaqL5UfWmJZParl1QNwUjS8tYk96aJdfJGfq/PIvrADcJcq6p0puRNPdTuuR
         sozCTcbShDVNLOP0HUhfnA4dCd3qbuCDu1tM0pU5DB3Sm9FaPLOGbPV9KbpRVCZ5X0EA
         6xBgBjugDHSQUQgklN4kK7p9oMO5HjAM17dNbIl6WI/NogiFOfBDDb2uJsDSEtf4pBkw
         uCv0aQIdoGq2b4Poyj6NqQxt4U5ZbHSrJo2UvGduLhNhe1exH489+QgkWoDxDSJQi7d6
         +lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592008; x=1790196808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzAo6Eq/l+nsylIXF7K1e1k88qd5mp1HvFUw+KqVPy4=;
        b=mVN3QQ5yVBiwis9FTTjbwlux0A/ZYmJ+32XLcqvQrBDUpgS+fWXauHd+7BzYylqCMF
         9nalu2e75x6IE+VoJHeKRFpSYN6PF8GnREDG6jEyBOxdR9GpSxV9mR6vO4N+kgBq4T8D
         QFuZTmopH9S3RsmAoGhudhrY2WC42DYLTp9rSaI7y+CZTeXFqy6sAmv/ZkBjHHD/2iSq
         ijYBlq7jlSK7Yc40OUDKi0QzF3QqluPas1zfTVvldkkgrdaVtoXUIS8Z2H3fdOvJjEvv
         2RLX0jxQWOjejoWXslLYkTwUI54g81aNCMHQjZx69/rQIwbzVIN05PyawZjb5YtRkrvn
         pHBQ==
X-Gm-Message-State: AFuF++li1MAhEDGZovpslMD7/IK4sIq+HZ3vna/wb0Y5fqIsCiBzt8wD
	AHb+4a1SA7MZNNsvFe9vJS0qG3S4kj1LIRWWm3VwuEFgDBjSSE7x3hFg
X-Gm-Gg: AYBFou2+NU5qlP9QEcLDDkJsKiRtmeUtLdOsq7xQrHRlF7gmYilqov0gfB0l4KjW1Yq
	1RJMZM7gBlRMFvooiMFQtg5mNclg2V37WNc7CiU0+Q5dwF+bdzamEoEWDgwy87BON+moaug7N6m
	UfFKaUn6CZVRyIBRCx590bfYnHEafb1+ifpcA1qghn6xnbZMrRBBGza/PxTUSX9Ms+Z4pEXhnP1
	xL/jv9JtaNfJsTeG1ax/6YKJ50NYUleMdWHkXkO6W9hdYIzutHcVteyODqI9TlvwJ5sWqG9hers
	Zj3T61xV4Tu67po4bfYo6XY54ry1Iop0fwj3zUx04cP2N78sjKayjgUnzpEydPG8s0IRdNNU2NZ
	KA7oDykDlVz8qHLLaZp/NnBoUcwwS8ve6/5tsz6UJEid0fTxPwxFTf9f/hTEzFYv4xYav0LceEG
	QzJU8ghmu1MQIrvXPVMsxFbCl5Ek2YK1ZpHg8uHI8oNo1qvJaykKRSZkt2PblUCvb8d5IhVw==
X-Received: by 2002:a05:6000:41d3:b0:486:f767:8be0 with SMTP id ffacd0b85a97d-4870cee660fmr4802574f8f.12.1789592007595;
        Wed, 16 Sep 2026 13:53:27 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:27 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v7 0/9] rtc: abx80x: add support for abx81x
Date: Wed, 16 Sep 2026 22:51:29 +0200
Message-ID: <20260916205138.16771-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patch series adds support for the ABX81X RTCs, which are essentially
SPI versions of the ABX80X RTCs. The first patches (P2-P4) contain bug fixes 
(added after sashiko's review in v1-v5), then (P5-P8) we have some cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

Kind regards,
Antoni Pokusinski

---
Changes since v6:
* PATCH 4 ("rtc: abx80x: properly handle shared IRQs")
  - handle_irq: write `status & ~status_flags_clear` instead of `~status_flags_clear`
  - probe: setup watchdog right after register writes
* PATCH 6 ("rtc: abx80x: use regmap instead of I2C specific API")
  - removed the `return -EIO` case
---
Changes since v5:
* PATCH 2 ("rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()")
  Handle the case of 0<=err<7
* PATCH 4 ("rtc: abx80x: properly handle shared IRQs")
  - probe: added missing configuration key unlock before writing REG_OSC
  - handle_irq: fixed the value being written to REG_STATUS
* PATCH 6 ("rtc: abx80x: use regmap instead of I2C specific API")
  Changed the type of "flag" argument of "regmap_read()" from "int" to
  "unsigned int" in "set_time()"
Changes since v4:
  None
Changes since v3:
* PATCH 2 ("rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()")
  New patch
* PATCH 3 ("rtc: abx80x: add mutex protection for register writes")
  Replaced "guard()" with "scoped_guard()" in "abx80x_ioctl()"
* PATCH 4 ("rtc: abx80x: properly handle shared IRQs")
  Disable all the unused interrupts in "probe()"
* PATCH 6 ("rtc: abx80x: use regmap instead of I2C specific API")
  Changed the type of "flag" arguments in "regmap_read()" from "int" to "unsigned int"
---
Changes since v2:
* dropped patch "rtc: abx80x: move part autodetection before RV1805 configuration"
* PATCH 2 ("rtc: abx80x: add mutex protection for register writes")
  New patch
* PATCH 5 ("rtc: abx80x: use regmap instead of I2C specific API")
  - return PTR_ERR(regmap) on I2C regmap init error
* PATCH 8 ("rtc: abx80x: add support for ABX81X")
  - return PTR_ERR(regmap) on SPI regmap init error
---
Changes since v1:
* PATCH 1 ("dt-bindings: rtc: abx80x: document ABX81X RTCs")
  - added missing "spi-peripherals-props" reference
  - added abx815 compatible strings to the trickle charger enum list
* PATCH 2 ("rtc: abx80x: move part autodetection before RV1805 configuration")
  New patch
* PATCH 3 ("rtc: abx80x: properly handle shared IRQs")
  New patch
* PATCH 5 ("rtc: abx80x: use regmap instead of I2C specific API")
  - changed regmap_read() argument types from `int` to `unsigned int`
---

Antoni Pokusinski (9):
  dt-bindings: rtc: abx80x: document ABX81X RTCs
  rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
  rtc: abx80x: add mutex protection for register writes
  rtc: abx80x: properly handle shared IRQs
  rtc: abx80x: add irq to struct abx80x_priv
  rtc: abx80x: use regmap instead of I2C specific API
  rtc: abx80x: replace read-modify-write pattern with regmap helpers
  rtc: abx80x: create abx80x_i2c_probe()
  rtc: abx80x: add support for ABX81X

 .../bindings/rtc/abracon,abx80x.yaml          |  18 +-
 drivers/rtc/Kconfig                           |  25 +-
 drivers/rtc/rtc-abx80x.c                      | 656 +++++++++++-------
 3 files changed, 449 insertions(+), 250 deletions(-)

-- 
2.55.0

