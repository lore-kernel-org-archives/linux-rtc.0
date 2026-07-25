Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AA2F9D85
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991543; cv=none; b=F5qaZgLpDKaF6DZC1nbvb10LyVKNHA6YFrGcxEPIs0+rtA3dijnFvI3wP4sZH6UppgEjso0PK5ujJ1qa1c2ighQV4ybiJ7PClcLvfCB66W5QICzIYuBnJT5QtTLWY+gKnSwv3hA4kh5IkyPfrkgmXBclfuK9m3DP2uxJRMidlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991543; c=relaxed/simple;
	bh=eDz3pgySkJ3FwHLM86QgjHFIaSpcds9QjU+yqkELM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov5hVLkRyYQV2mgeeM8lT9V5NK35KI9VrZWnSUBbQZcQb4gTMnBrZbYK5o4O2S0zy180Ndw5x5QawcbLL9d/9xjrK1bCeLvtj1rhLNa7uA+T5XzYWllgqFWZEf9By6x8CllzbcTUFUh4xmqHp4irm9bqG2+8iPFou+/TXHv8P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhLPJRSw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhLPJRSw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590ba856so12231755e9.2
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991540; x=1785596340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLYzxrPJVuTJC5CqSna3XzjrW2NluFGsdX52TDIqBEg=;
        b=dhLPJRSw01eAPgu1PnVaxh+GW7GyqNPDzRs+MqZzyxHvDdXcT+bCdN8V/1vvYefTze
         CAWFC6OZ5hSj6s1AlOYnSkCSbjll6wiG8RPmyzZhb462gko//avwwE2hV16hkYwzKYnn
         PWtaoW8U/C3CekD2UgIQx2TlcX8LrktsF0y7zYCc4vd3XfZ2+77LD2GfFFfk84752dNU
         Sg30NI5DrBZlOW6Ppz1/h3k6ptBH2CaI61qBE5DTwyj/yj6Hq6TR6f7LESJ+prPu+zRV
         24SjiPQrkWgcnZyI5iJdmiK3qBEWP8bHS3gpNxl892O0A3y8Vw9jySYrGtB/qUnmiQWU
         D7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991540; x=1785596340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLYzxrPJVuTJC5CqSna3XzjrW2NluFGsdX52TDIqBEg=;
        b=oPX97a8fFHzRHqG5VGE69BjlP4FeO3kl9ntkmUd8of2ApqJy8d3BN3KdVU8Hv+pD6+
         7RmyK3HoncNfYzCrsFEqOeSrS42assFPDSgPl78s4p1j/m8En4kM7wOOyMHHAy/hKZAp
         k+w7FW03Fu31NcykJGe503qKddIN/zkHYoarH14C+8ia+W7dyj+i8NCvrgdfJMqs58RR
         aoWDy8s62ZY/kfae+Edz7PBSSHDq+zzvqd/HqBiKOANVxgoBAfPtApqx6UdrBBJbT1Aw
         ljh/7TRepobpjqJb5FqkHw1UlOJfyWSucHjKnrSFp4i+vzHEchdUjRCfar1PMip7ZM5D
         /rHg==
X-Forwarded-Encrypted: i=1; AHgh+RoHAGgjBYEGpSMIjn7egFQ5YIRf5aPVbrhC/h39Dx+C1GMz9J2r9wHeYNRoz88BIT+ZM26yT5OuqlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILwoQYMscX3p3Muoab/mhRSwoAwC7JK4FXVf/HXM/5JFhw9Ui
	NTzR0eYj5eV+loLXp7AlwLi9pCLT4eFtwyS6n7f73fny8tNDJvDDssPU
X-Gm-Gg: AR+sD11v7K0BxOID4dwyrzoiZREaU332dKW3flErVKGwUJ3zx84nhS4Ci77kFCEXnxu
	/cb3kiEVMzCDwasJCMfunJVhlM9XujG0ThX0AWGtCZEcSDOx95F6q2bkS8bOVdBr4etBsP3vpDc
	5edxvmG1e4LWQxHETBdUlOioDCyl16xefiQeLnW/1LsUPRgY9iRcHm1Qm508vcB1VgFiHo8fNbm
	UEgB5Xonej9eG5ER5Nd05Q0UzPLw1hDGgaEUWybfgNCZ/Bc4DSPyWhEuIOHeaQMc1XoMMo8WJNL
	2w1Rx1+Kk7ICh8Isb+Mf7sU2xiRb+9mNcnLgsXBL3TOYoB1Dwgf5Gzper9puJUAiV/T9ylL4sC4
	CCYxdSe33pUU4HCpBvvFLFPOpLSjMy4EYnQU470zD+T5A2StOnXsiAlBlhYw1wv9NstdoD5At+Q
	UAog==
X-Received: by 2002:a05:600c:4513:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-496b56d92e0mr26321205e9.16.1784991539493;
        Sat, 25 Jul 2026 07:58:59 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:58:59 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 0/8] rtc: abx80x: add support for abx81x
Date: Sat, 25 Jul 2026 16:57:10 +0200
Message-ID: <20260725145718.14733-1-apokusinski01@gmail.com>
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
(added after sashiko's review in v1), then (P4-P7) we have some cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

Kind regards,
Antoni Pokusinski

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
  rtc: abx80x: move part autodetection before RV1805 configuration
  rtc: abx80x: properly handle shared IRQs
  rtc: abx80x: add irq to struct abx80x_priv
  rtc: abx80x: use regmap instead of I2C specific API
  rtc: abx80x: replace read-modify-write pattern with regmap helpers
  rtc: abx80x: create abx80x_i2c_probe()
  rtc: abx80x: add support for ABX81X

 .../bindings/rtc/abracon,abx80x.yaml          |  18 +-
 drivers/rtc/Kconfig                           |  25 +-
 drivers/rtc/rtc-abx80x.c                      | 650 +++++++++++-------
 3 files changed, 421 insertions(+), 272 deletions(-)

-- 
2.55.0

