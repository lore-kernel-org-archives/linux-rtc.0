Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B31456297
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523806; cv=none; b=eaBeml9u9OxKAwqrm4syg6FpUtwpwHNH8umMD6jxx/mbchpcM/OS8xRnLEFlJOJQubEyEQ0mTSlPEdYm1UoHxfpO3hdiyAEympeX3nXGtJLUM6PxhbR4KM7WyNF0BkXP9LhOYWsL5CNhRJ1Hd3pjtmxuOiznsL8ok4UJG4NxJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523806; c=relaxed/simple;
	bh=+HpLF7B1OmOHTjGfNr7/J9YbTYjSw35ySUr9qOfPZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMVV1XfX7ywsRUfrtHnIllkUpWpXEZZ3M5R726WlMmUKS+g5+B0TvtHWn7BZ3IxCM1h2pAJW3nE2EJJK1u4nKCMV6PJxd4B7iNDTPeQL7+p08ZPz0B+F+KOefdxj4mZZsvDIvP5zaazfNo8UBc77faDiS+MkBC24wjr9ouBWIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INjnWPXd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INjnWPXd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso890141f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523803; x=1786128603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/dwrQc0AkWTja3JDMgvLCLedoVDAqUDFupO11rwljE=;
        b=INjnWPXd1STAQlqlhSnG8tp48rQlf2bvF9y6mlAcGxPziAPX+waxUszZaQa8Z5OIRc
         B/M0tA2LV+IxuWIIJpFrHdZZET9kS+hNXyjAaLwfdhRYkm/yfMgc2c+vHeiTTXykdhON
         vqOPs6MmfhN4qpdc9k2GoXN35X78MLc90NEdwL6a7l15rfA9w/4z58xlV19KZP9u/ydC
         aZ5E1wa5Ig4jSvJi3SHHzfJCnOvtDG6l20nhRS78zv5JLm0DCIWXIZ9HtKgkHEkwliCL
         3HTRNXp8NUrs6rddGHNQ4Wb0Urbqq1PLSUgBRMzLFWw0hIOH004NZViYhNWwzb1OSueb
         dFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523803; x=1786128603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/dwrQc0AkWTja3JDMgvLCLedoVDAqUDFupO11rwljE=;
        b=aWE4AmudrrmD18qFD2zbWAh+sYLcvLuSZlalm8hKQ5pI9Q95RoT9AZDKvEmyuUwLz9
         sVjjHJhwAcEfGFHrjahTUVh2jexIAD9WMDtgMjzVzpu0cquYkCvy11JcWROaUALaVORy
         zLGkkeOSVb5tvE6392fIq2rzznYhPlU7XV5OdORTeSjO8ZNU73uDgVz0//9oObBDstz+
         RSErBwAdXTkl6bJzaaz9Fju7PRW4QUcVkZFrqtgh22PavkmI6UBQef/lgidGGgwH4mBe
         vT9mDgifOSSPKO3P+sbaJx5mPb+qRpPDSXdPGJiI4WT8vKBymVsgycO2EPmjJ7l2JJ+F
         rWiw==
X-Gm-Message-State: AOJu0YwSaypKi/9JTu3/WJAoqOKpJTei2lo8sMfx0n7JiJN7oe0va7K0
	D1WBWlPl2UqgtJJNswn70Ib5q/mawQ29aCTV0ruCIgFgNwaKMAvPFJZc
X-Gm-Gg: AR+sD12j7mYmQKS1EZCL+LFZ3iBdmxlVtfjxlwhHS2/VQR4KY1cPgHsincxGYwVVMlW
	AX/il84pezhdaNeIqFi4r6J9mlGNqd2HzvJvuuymqkMOIapqGfCzLL8WshbMsxXuhHZJjpRQ0Md
	LVZrxQjBsIfbJFZzX0NfxBB12MS7ARGGEJTsNmuQtmqwnqFodC3l+GLUkJdy/MCu7T2XkyyDyZG
	FMuk90bc1Iv1O/gtlJTco6qooozdHd/EHPVCty/1uj/HLX8FUr4YkgYE+/5ewtMfH9ufRNmPQPy
	9mb1mKRy9UYMGq8JLdy5YQsEF0RUYsYEOTSmVmdi5JQzLzjYbKmaV3TNO8nxuaBz9Yzn+3Asjtr
	1YIwh4jr1kuGH5/jicc25qW5YwKRI9m4ZnhG3qo5lDMF2pSI2Hd1L38Ua6kZFVqtQERTkBXIFfg
	5SN+sR5KeigPrgiGe98Wq9sjV/VJKbpDxOH2ZakcDb+h6O1vfLgXAqQItFeCbDf3lU
X-Received: by 2002:a05:6000:2f83:b0:47f:934a:3029 with SMTP id ffacd0b85a97d-47fd731c35fmr1567209f8f.60.1785523803244;
        Fri, 31 Jul 2026 11:50:03 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 0/8] rtc: abx80x: add support for abx81x
Date: Fri, 31 Jul 2026 20:48:23 +0200
Message-ID: <20260731184831.44037-1-apokusinski01@gmail.com>
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
SPI versions of the ABX80X RTCs. The first patches (P2-P3) contain bug fixes 
(added after sashiko's review in v1 and v2), then (P4-P7) we have some cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

Kind regards,
Antoni Pokusinski

---
Chnges since v2:
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


Antoni Pokusinski (8):
  dt-bindings: rtc: abx80x: document ABX81X RTCs
  rtc: abx80x: add mutex protection for register writes
  rtc: abx80x: properly handle shared IRQs
  rtc: abx80x: add irq to struct abx80x_priv
  rtc: abx80x: use regmap instead of I2C specific API
  rtc: abx80x: replace read-modify-write pattern with regmap helpers
  rtc: abx80x: create abx80x_i2c_probe()
  rtc: abx80x: add support for ABX81X

 .../bindings/rtc/abracon,abx80x.yaml          |  18 +-
 drivers/rtc/Kconfig                           |  25 +-
 drivers/rtc/rtc-abx80x.c                      | 639 +++++++++++-------
 3 files changed, 427 insertions(+), 255 deletions(-)

-- 
2.55.0

