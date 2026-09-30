Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D544F574
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757598; cv=none; b=HEhXUAbzibNReYjuoZCc4ilUcFf4JXh7whTuTDsFvh4OV/7Nzrb1O8eIvscgy4dmORwUDnYy+gE0y8r0v0BSJRfpz4ii/0uDLVTukCHhcNwZU6VR3qfHfg4gUhE6bPT+qSwwUBYxQYeMfXSHE3SF/smEr14nsLOudAGJ3ZaWAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757598; c=relaxed/simple;
	bh=CKwFKnvNGqJJ/q15B+A+DcP7BJRvr0+1X4UoGOdQS7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4Y/OSL0DrCz4CRZMIoWhSvGnJis3e+duZiFKECD+E9OUQrDcLJ8FKlsBIEB+McGlIwSoewLDrYMeF3Y9ywb3z4iM8snzkoUReHUjW+SBtBdBbVUMj+k6MeE94AmQOks2jGqDA/e8HkTmprVqE9WwkBmp+hLSoeWusR95rNw0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBcJKsnH; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBcJKsnH"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so212205f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757592; x=1791362392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGBjcoy4aeNTw10s5CjkbJAmRuqjAutFBgcl06eNiGA=;
        b=JBcJKsnHQRqMNAcnd413MyS3kW4bHzpbnBDdQacfmEb04UddtkB9ngar9tkELCmSxI
         tiPOjtzX2w5+K4hcWQd/vNR9HpTodRcVGTlYoxaareTrh0bJOmaOYittId8n2W+k3G1a
         HHPsvs+x0iV+0F20h7BcmSuIHEiInxaxzFctuJlB95nXWfTo/M9ukGacvI+Z32zEjlul
         OIBG+fE22qeCgdpeWenHjPzTMsRGHZlB9xchHHQbzIz3qdyjmOep3TpqNjmd014cuXki
         ep1h+X9oukOcMGsIgdtdguz3KISd6NsJs+S3uIYBMNmxKzR0R5RdJXw3HFIYL3Mu5JYI
         4QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757592; x=1791362392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGBjcoy4aeNTw10s5CjkbJAmRuqjAutFBgcl06eNiGA=;
        b=H1/MVlEgXdRMQY/THXi74+yfqWquDjG3+zxc+474BnzwbrQdbGxnpK6yksv707KEpO
         0pcSCTwlPv1MAGW4c9SB8Y1TsrI42VHKsiMJS3qNGaFe3rliPf6ECF4a8Qvs+FOMBD7h
         G+5DRqM1+ZnFjxExLDrWF4z0BD/3wGnHneGniNXuqTuLnbfJzjRzhs4j4lJO9hI4aB94
         bY2qBgLP5VX9l5K+WYVfil3QjLUwz/AFYa/UHT19xMCxXVZuZzdgGpYijiqa9lBL6N3w
         v++gKaDqOnRZgyNmoO754LtICoCSqbLA5xRAz7kCfgJE4vfahXDd7O0CUpKUL0GNBUSt
         OPOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1qc1YA4dkMd2kCM/mS8cXtV3D1eHZyzhxuorHrOMxGuQu6UOIO4x0G79BHRgoCvrySJgmrnJEdG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeeBPMgHC+3aFMm4lRtOjXoqsAMh4VXwdsfrPFIXrfFyhEmyNB
	GJbDXMVE8s6DqUncpdDVz5rLHxKERWCJiBCjoeMDT28c6W+sAsCridlF
X-Gm-Gg: AYBFou0rhTbVJOMIF1sA/VNfw8AP6C4JR275dweY1ATg33ad7fSOly9cO0Bfwqh+ZgE
	/nXSgKvTb/3YwjwiXvRzoDPJIcauanMFq3UUloa5spaLp8EUUjt2NohDz5XB1E83ycs7ticJgVT
	KVV/oPf/Q3n24YHUS96NODZ3OwYZUY40eoD5TFLfJOxtJGH8pUinunfX7tvI9LyicI4SxvSfGos
	Vkm5z+97JBLZtbHTEKrueeeEcX02DYMtFpDmalrI5qBAWmHUsatVuoDFyyD66p9mpukCIeZ6XXp
	co0ManHbMZ8qJ1MdkJubw4o41Yk6gcloST0xoicTDfrxytv8Lx23jNb829CtTaDeUkH5FuGTOn9
	wEPSuxAIbOF+NEwa8Y434mEcEbLdAow9w7hdBUJ2mZ19InGjM7/DNRxD8YNONGdXUwJ0WlULDzm
	TASHijxX10ePBinAt0rieYBgYnHQShJzPxeY+aXZ+MG5TzHxHBdmVdhqygeBR4Cq5hFQTqanCxn
	PDxMgQQAR0tqwwp1oBk7F0g3vPBL47olCuCjKgBTh0HFwErxA+rsnBl
X-Received: by 2002:a05:6000:2301:b0:488:89ed:4430 with SMTP id ffacd0b85a97d-48b02522f7bmr1523610f8f.33.1790757591711;
        Wed, 30 Sep 2026 01:39:51 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029bfd2bsm1757325f8f.11.2026.09.30.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:39:50 -0700 (PDT)
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
Subject: [PATCH v7 0/2] Raspberry Pi 5 RTC driver
Date: Wed, 30 Sep 2026 10:39:20 +0200
Message-ID: <20260930083922.484885-1-sander.speetjens@gmail.com>
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
 drivers/rtc/rtc-raspberrypi.c                 | 279 ++++++++++++++++++
 5 files changed, 323 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

