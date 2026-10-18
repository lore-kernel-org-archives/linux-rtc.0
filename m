Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB0486434
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334274; cv=none; b=QJ4v1gxmG1dQYjO/ZUuLX5MheNzYE0NU6dq0J7p93U9WfDFM87lNek3BCL07IvYzCRZkU5xPogbyJUJmwlD9oKtj1e6dC40cmzrPnUVZdCG/5olwGo7fCRkO95gMY8YgAMkFxhAUtZALa5oDa+ztaHtsg0T4O8/N1UTjHZtSWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334274; c=relaxed/simple;
	bh=xRbrP2eD9E7EByFwpgV/lYFTol0PMFEEMAgvqN4yRm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1YhmoZEFxeyby2SipCroduKrqUQhpmuDBfpLn31xql+kNHNqP/0KSXGP/VsdYFHkoXccNcnzCWR9KFbH5qwiDtUokT2oOVeP7aUuslLAlmBGzD0eq7g+8UXx0H14WT6wTHQad+i/745E2jksceoZDmFjPcbotM7613JLA7Psns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+3m8bUY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+3m8bUY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so8461285e9.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792334271; x=1792939071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=c+3m8bUYh6UulGm7vgmxrs3uD8Bz47hgZS6PryrarnPR8gxkHqJM/ZLBE5WvdmpzrZ
         4jaWy+Gmn23YiFjfWwFO4G7edsNhFON9cWw+hNbw5g8jR6FpIEh5suy1AIAl6Bf3tpFl
         V33xHYStDLYnUY/MFPK/m3T6cpeTKfTwSDmuTBJaojsN0G1q5pvytr7k6pQLIa/iFQmG
         iriBtmsmORBVsR75lf6PJMyiWAAfR2R1scHQvv2iG+W/K0bO4aTwaiinRd6MBidProLU
         UYa1u1Fmbe43BoWdA28YZ4/2P2urzD1/AwNh1BhSPw1dle3R0qUaPqp9yLVee93kfkd4
         /vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334271; x=1792939071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=cARCAL99LZ+1PcFpEywFm49fYWKnGanHJ4oWy0eg4FvIrcIum5uWGIyBTCrRfnkNW5
         n+9MijS3/qVMm4ULxCRpE6jxaMpjlDtNUYGwTnuTFIC0Js1qxUGH7jilQ7ICwC8CxrtN
         /L7YdSkKZCp5bhLiY0O0u/PvuYJ42Xmh5f2p21ze+0VuRb4hHOelBviIPKTFTk0U1o0N
         PtTfXDFKLQFDOdQrsWpags+RouixFjcWNoqdvsW2NVC6efKS4kgRxSJCUO6UIGeiJ1b/
         /ed29YIZWGaFKtTfIp4YQg1jzxYjY9C8lch0Wiii8qpl/udQeiQqw8uZYa1b0dHjYBFs
         TWHw==
X-Forwarded-Encrypted: i=1; AKwUvBy9t9l0H3rlMFF0AiY9w87aZOwiNDcsBINfBf8bdS1POQjtXh7fd/fy9vrLe72W7bzrJP9R9vLH29I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi+d1RuXPzx8kdigsuD2a50jPshbvKWenYIMmH5j2izuq214Zv
	7LNtJYbZWOHiLEhFYlmIUy35jImRW+nPM9HrD/FhU3lIYsNtBfQHw0yp
X-Gm-Gg: AYBFou2WYWvQ4OYMv/sgS+oUjJaNjFKprW74PFBKDJOBCV+J2u8I6lX5+EFbuGHDAZL
	k/P7R+G+tRcVV+fVH++9rzvDAVg2ZIZVo7la8ltjmWJ+f34YppugvuajQBGyQqE7htWnJUn9Szb
	TSymnr9fJTqQMp5r7JbX9hY1jcfxpJ1k0Hyfwo8zHLbZlOYMxpSRu7hBucriYeVfpiqf135qlN+
	qGMNkKeihrW/jgfOy/wbODtnpr+BmVZIlU3gjXmGV4LmYSEmrkTl4YUxExAgXhhdXj5bI6hB7dM
	hFSVwb6d90SOOwxPVcdt3dC9cCE7tgsrNlmiLBafGMWAhMaYMTz5YBdDvUHGVN7C5/Cxi0A50CQ
	6D5bJDrveUruR+dx6d96gq5HG4CHyvKhbmnO5aJG//8rFujHWhkJBVa1rjuDQtJkytH8VJypXnJ
	SgicPdI97MfO7ivwMC4F7kE3W2ZsVLrgZVH7HYmtPItKADUcBAwRGLJCJOYvvXGZlUgrHiHQaQ7
	xlCU7KNDmnYV8ngiVwDAKR5CXJ5NaV3LE5nSDLv798o3A==
X-Received: by 2002:a05:600c:314f:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1e6c5e47amr12571315e9.10.1792334270968;
        Sun, 18 Oct 2026 07:37:50 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510d60sm16559652f8f.58.2026.10.18.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:37:50 -0700 (PDT)
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
Subject: [PATCH v12 0/3] Raspberry Pi 5 RTC driver
Date: Sun, 18 Oct 2026 16:37:09 +0200
Message-ID: <20261018143712.1040152-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
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
 drivers/firmware/raspberrypi.c                |  24 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 278 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h    |   2 +
 7 files changed, 324 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0

