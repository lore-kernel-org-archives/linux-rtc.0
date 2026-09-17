Received: from mail-wr2-f43.google.com (mail-wr2-f43.google.com [74.125.225.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0833672AF
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647927; cv=none; b=rNtUpnWL4o1bh0nHtjF1rYciV49h30JpP9Gvb+FVjzAU0/RP/VblgbZW0iPNy11nZVLSEsf1jWNRcWh31nacl6y4r0bmk9Wtx1R+z94rqK8XH76UgSCSVkKTRF0v9WmJTEltyLyuUAO4BzBcQGNqmXi4YucucPBTLVyJaQILoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647927; c=relaxed/simple;
	bh=DTJBxrOGBZyw8FjjT0CEPO2tUaetzH9hgNCTJwsgJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdsbApnvQkzmJwtqSqHkYXQ/HSjbSCq6ttZQotHF0ZfsmLlbSE1LGh89s2xj0iYjmBxOdrPjjaMMAkzW7jafj9Sy7aDpgu1srfmPsO1hQ0ySUEAj4/hGfKJQ29wf+PAsL+UTSi0sR/ac9ELuSsQ8rkb5CaLpZ3JONDi0EljAdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrIazyI6; arc=none smtp.client-ip=74.125.225.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrIazyI6"
Received: by mail-wr2-f43.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so267361f8f.1
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647914; x=1790252714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDcuQ9VeUxp2M+Co3neI32LPx9A6FG/PXs1DV+w7hSE=;
        b=DrIazyI64uG49Otlx0ZHxJRirOkrQVhdHlh5HCCjJ78H1yEajzvozT7vKPJIB0oWe5
         /XvoI0SeQ5KvEuouied379XPiUhLp1yblsDhyyeRRW6PTIPFCp8nzz8ICGIGR53LmZyb
         HgtBzg01MW9g8htb/QocT+qXzUFp1wWGjNLMPUsx4iP/lK1OGEZlGLRsplb4zAR1sXhg
         wm0x36iGHW3rcdaldcZhMLBgYezaRGvPPWyYNSnlMvssjaBKVIZEBdXYWNdSeO3pr0FY
         ybkuRgG3IDsl91YKkUPuOooNmAmQaDqj1ClBFAQIYTHzEbviB1NaWZx3CmdTCaq+Qp+6
         SuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647914; x=1790252714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDcuQ9VeUxp2M+Co3neI32LPx9A6FG/PXs1DV+w7hSE=;
        b=g2yf0g5zi1V2lnlgUsgMb769g7aU3p9o3pCR4DTAS5hYz8wVAUyYd4nnEX3xY3NfZl
         bNHVn3cWALXEiGYtz+6AUjUcZket88C+tV6HEJjsD1baj3v7sfskJwtn1oX33F6TZW5t
         eFwX+teJqOppdKKxoR1iZZ3kNTzSKFbE8wj6XnZlOef7ZECCNyi9L5QFhIulxMYGgUdW
         xJSukeb2raNXbhopTUYcWQR3Zr6b459TM1ZorXW0z6+hQErG/SQYU/sSLQXBsW+5JMTo
         uoPcUypx0b/MCEMGFilkynPeHvpuuZV4H2vB+VsqoDaCEk+yb5lT7CakLR9t/swGGpMa
         NxOA==
X-Forwarded-Encrypted: i=1; AKwUvBxKnVWDhNKczyuqSMwwo9wlo0T9fOFp0PgvDrI+CCBKxBOUMiPnfJ0nusICihveFwVLmWN7Iw5vFq8=@vger.kernel.org
X-Gm-Message-State: AFuF++kJFsF6uNfxG05vMoL9epqhI+RjLlU+liKMsY9r9ZJALxEBSvDm
	332Hp8Jbmd69VH+IQKc7RBueX6Ar3oNoVQ+7zJWjJIpTWXS9j2Zo+fI0
X-Gm-Gg: AYBFou31XztzaOPjwj3LwkQMk24I/8CFZ+TP7YYncwqMgCg/0RIUaDHivoT97HBJui8
	U6Fp24ER7MBLoqEevLnz1GjyA1aPK1wQvu1qMsoP+aXibJgGoF7qYXpltbbFDMHnDuEfhyc46Ik
	zU3dTAvctMHqGO453H1hvGRncnc+R9ldEmo6JKDOkHt0sjK+33E2lKHcsJLtgX6QJB+9zc5sHqe
	xRWjIEucjxocqi9nXk3zJrnM66fAb7w0TfkUd7hiw3qQXbm8+YwmWyH0hj7qyYcJDLWTJCPbK45
	Cri4h0qoW7YeT1ZyMwxWV3GZCjT0HdaIaj2y9mccqo74cHvuqS2fyADtnbMKQMTZj7dpEDjI7Z5
	iOWT/td9n5CvnvePiWCKhlPWJl0sOgVGTfFHBNIz5T4F4IMktel1f1Yf3+GAXQ3VU2GnOI4w0Mp
	j9NAKvjcwI9ilq8jun0DBtaHOEJmXYBj74fkZZo3AoGg9RrIDDKfntx3+DsYV8zfBpEzB28YzCn
	Nx7h5iYWgXlAAncl1Xp1FZDXzyGakr/FNPXJEnYEXCm2aT09ZQ9m+vV
X-Received: by 2002:a05:6000:2502:b0:487:a87:24c9 with SMTP id ffacd0b85a97d-48713ae6895mr5484888f8f.3.1789647914291;
        Thu, 17 Sep 2026 05:25:14 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm15276567f8f.20.2026.09.17.05.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:25:13 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Raspberry Pi 5 RTC driver
Date: Thu, 17 Sep 2026 14:21:42 +0200
Message-ID: <20260917122144.703221-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a battery-backed RTC located on the DA9091 PMIC accessed via the I2C bus[1].
Access to the RTC is provided exclusively through the VideoCore firmware
mailbox interface (not via a direct I2C register interface).

As stated by jamesh on the Rasperry Pi forum [2], "There are no plans to release a public datasheet for the DA9091." So we are stuck with the firmware interface for now. PhilE also states that "The firmware needs full control of the DA9091, sometimes with extremely low latency, otherwise there's a risk the supply could just cut the power."

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
-------
- Hardware: Raspberry Pi 5 Model B revC
- Kernel: v7.2
- dt_binding_check: passed
- Basic RTC operations (read/write time, alarm) verified

[1] https://www.raspberrypi.com/news/introducing-raspberry-pi-5/
[2] https://forums.raspberrypi.com/viewtopic.php?t=359073

Sander Speetjens (2):
  dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
  rtc: Add Raspberry Pi 5 RTC driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   7 +
 drivers/firmware/raspberrypi.c                |  19 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 277 ++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0

