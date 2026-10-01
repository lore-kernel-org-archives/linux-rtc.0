Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8064A4F1E
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883434; cv=none; b=GYjTkSi/+jpyWQPEl7E+ShYWX/cm5Ch4pkj3F9FNVZ+2RHJqr96KJ+4ISOD7ScIHpIAIuPGOX1jvQaO4rJsQ2k0Q35sUgW6L1EeD/DNNhVU/IdD6f/YcpTxRjL855JrWY3LA7IBbCEjBz4OpB78gUdR1mxMwSYuLnk/+Rz2AV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883434; c=relaxed/simple;
	bh=5RgDtYTk5iUuLdaRBaj67ga+lSgPsVMdMP98bZ9j6Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Le5HYqlTUEw3WPFTrOlFjpbBTfFPE7PqfSvmF8E5p55N1TDbkWlHlmWbwh6MoRPzgvOKVTbnd9ZM5/b4gs2csKZ0XwpCi3V/y9NqmfNOzwxUxJO3mHB5XvSUwsv6E4bF1K7Y/BbKqLxp9FOyPL/IHdo2xZ0ljmB12ZyS3Hxig2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuiiZY+W; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuiiZY+W"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so46104835e9.0
        for <linux-rtc@vger.kernel.org>; Thu, 01 Oct 2026 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790883428; x=1791488228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5aSPYVtc+IG0rQBUq4/NWp5pttFH9+1r/H+X6RBrkY=;
        b=nuiiZY+WFY3Cd5XgTOJ4jxnlDTAtLTe8OEOcMu0+hA6QbjUcmR1jxwGfn7bWiL3NBZ
         9v5HB1mLvMeOjIVfsyPKYLfV2SnD1uwYggqHsOnZJpPKIl5SUfJinWJPSfbCpYzo1mKO
         e0ZJf5sx0ZxF6S0C7hoG9ZxsUhzaqqnXdA6oQ3JOaxj+83bxYzzQlPuDj/7uMw2mzoV3
         fy7s1MhwOy7l76tsg7OVWNy9PPIAiwYQK/+fggPbDYzBH9uHzka7Equ+EUr2+5abhSI4
         CiEXXYrADjVQYIRsyIsRzzj4PLPS/YghGTYX1fDCL2DZMZvOix9TSsu3gdx04Sj3llQ7
         bmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883428; x=1791488228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5aSPYVtc+IG0rQBUq4/NWp5pttFH9+1r/H+X6RBrkY=;
        b=d6vAxwrNCLjnOsfMwRWPHHnZVQ3KHG+ruFQ1Em1jV+l0+wkFBviv/IusVmynBV2upJ
         ILKZGP8vJ+8jeHoZH2VCtOjUD737ScchdtmPgSEaC+Ac/7qFEzD7xynb56xKZw/eAm09
         D4iLLB79t9R/CzdyGMhmlJ0JqwB382pm+kh497D/jeaYhrIqFwX7rrX4z8MGZ/QO/mQP
         JkSsFXwYB2d4RPgyxo0173xwvoAvT4JBuvbrdBXoOQOEYkETjj5izmxHl2+RTzo80HDc
         0VQQjYJbBBInfDxdQ0Jt62tLWOPLXQrzLuHkZz9CJJPqqw5su0UjrZvir+GWfguzx5rH
         PSoA==
X-Forwarded-Encrypted: i=1; AKwUvByjWzD6oeu74CI6APP8YwJ+cBQP6+nyCoAPHFW/q3hiwbLenI0vVUft/ZJGAN2en/P6CD2gBiXJnlk=@vger.kernel.org
X-Gm-Message-State: AFuF++llfes5Jgqx8OCZ+YFgSAutjGsZyMtZZUv4VQKIVeo0tbAs5Cpu
	fQg5R+cMghNeyJnNpQSkMMpSNUOkLHsymkaAnLbr4JaZzkRk+wO8fSb9
X-Gm-Gg: AYBFou0UYgh3kAbCKMfIZYjUcEvkLfgQmt0LlgZgj5CwDAQaIXHyVSOBqI+f4M+SYVy
	goSu7+N0ndh5d4OiKNyIV+40mXT+4ePvJFVd++ty5tm4af3jLhgV2rb/y01zJ0PAXnDSd4nfRpk
	0028lG3vSM+Tcks4lg0/1vboKP+l5E1svODI3iFoBgxzb4l44jz4jTqLTbv+yuPn7Df/zSCbkh6
	FDY7l+kq20A+8e+fvqtZP+9Lmjj0AkJFhgUzQJA5FoMdsaGD6CgDBDNKHLB6jvSykfVYLVq85+a
	HHTLIFvdOjgwDEpqhgu8RrUbyBIaecxhPv09zVEqWJClN/bIKB6KopGaLSO9LzCmUvsLdPqAChF
	8A5RSzisU4nGgdZm/uCA4kbYmXF4klf1bJLJmVggS8nNJUOcGch27MQF8lWTSNhXbID+Z/sJ/oK
	WGrsqsPpuNfG1dKMg95AM2m5CEGkMO6hWiZX9w3NkshjcvlVcZr/BXD49uvXAunPJnEGT5TM5gI
	fsS2Dto+cgo1hyZLVcnkmrcqa68ta/YUeYaCqgGHzWQ7Q==
X-Received: by 2002:a05:600c:46ca:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a0275790b7mr11310385e9.12.1790883427699;
        Thu, 01 Oct 2026 12:37:07 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02770e8f2sm12312315e9.6.2026.10.01.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 12:37:07 -0700 (PDT)
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
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com
Subject: [PATCH v9 0/3] Raspberry Pi 5 RTC driver
Date: Thu,  1 Oct 2026 21:37:00 +0200
Message-ID: <20261001193703.734323-1-sander.speetjens@gmail.com>
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

Sander Speetjens (3):
  dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
  dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
  rtc: Add Raspberry Pi 5 RTC driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   6 +
 .../devicetree/bindings/rtc/rtc.yaml          |   1 +
 drivers/firmware/raspberrypi.c                |  23 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 278 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h    |   2 +
 7 files changed, 323 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

