Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E0442111
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390807; cv=none; b=QD2RTFI/f6s120C8QpIvF5yol00HpiDdMNEh8icO2MVmow+Q6c2VkkrsU0+SPPXCXw3dLi0b6ZDGDxUURHKjrE/PCxp5bYmPJDc7AVlbbdvhZ0tu8qLsQ5eno5sIAHc3+VFeCG/1KWZwRpG5z9qWy3yVh47qJbiS7moljwLeIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390807; c=relaxed/simple;
	bh=TaWewZmZdiyyYEvO4QXn387rDKrFrS1EPnJDYMrcQhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/dgU9OynpVaK/QGZPxVdUDbgNGX86nINQgZ70vtOn6Tzl/f1OqKUrH5jgaBq7s7ROW46aI8u+DQWLjtLqXzfpYc8cM1zdJLY5vra9JozCf5Np6kMh9Uraac37KmKeDtbjq3jPkfoEKqUI8+iDXlbTsVd0LoJ8TZbhGm6JGZdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKlg5tMj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKlg5tMj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1685362f8f.0
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390802; x=1786995602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sg0u8jIY3RdcCncNxYq4+4NKxyzf6tm+h7D9IVK82fo=;
        b=BKlg5tMjWLiVi9FOvm3y97U8uzf0AWuwDQE6pshs9iyngJp305+damhIhBUM41cBgJ
         4TLc7dVgv1LgHGUAEjx8nq6JT1HiYhiyS22eLF4GDWPA6KZRcqQmxHodYLL7s1EVzmVT
         VnUONPmJglLQM5BQZk5di0tU4JMWgbQfVw+Vk9jqNYpHbaO+TAiJUWsp+BdYaC7hBLXT
         qoXwmsbIGtmuVh86RfBlv9YfUfayzubC/Ckau2JLc0KgtJ1RCYnoeWIHyf4VswzKozzX
         v48AQE1L30lr7tTVEpLcbXrOc1N+kmcMdNSMEIhLKwu+XuJV6af1eIYXNBNgeSx+VsGh
         tb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390802; x=1786995602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sg0u8jIY3RdcCncNxYq4+4NKxyzf6tm+h7D9IVK82fo=;
        b=KB4E2pkcJdEH4Ry8h+1g98Hiq3zDpRtStvwOFq33k0o0+304s5IhV5tur3LAp4JFGf
         fmNkfi1YuSaKQp4nu6imoRk5+VP/clA+xw0HxHgNijB/vqMD5U62f7rm7dDH4IuDn82C
         ncPn56T13zvtqNdMJtegEvGmvi3SqhOK7gtXDuwdFqtacTtbig1eTaUSEK4uSDZ5NG61
         KtE6gwGZPGkq1ARHM7OKS0+uDRlgrqSmqQNAb1fFXG1d20KWii5Zj/x4ckHDpXXujgQ4
         22/yczJQnX/bxGApDhfWh4Gm2V1SDrnB2bCEa/18/rWf5T1H2N369RQq8CxCPTEAJlf6
         3Xgg==
X-Gm-Message-State: AOJu0YwN4NX/SeVv4y3JYtaYi9wsUjcRyXCpJoDcKytvCWxwrJWuyQWb
	d5aRvg1eZT1zX3fPPye/UWxYEnCs14yWqN1uvPkEu5ZNFoWAnkAfW/l8
X-Gm-Gg: AR+sD138O874LNsfPGTlBUUsxAhtRunXm3vQexs9xLXfYUXpFVT2nvtZrEdID21udVD
	hvpUZWUrLOXhlhn7LAcHN6zaxcsKiVd3AN/+PJ9V3zqe1A7X2HvsFBIcU+gtjHzNIyCJAebQ6fX
	Q7eflKsvAt8fP0tybvquLEG/apKp9W6D4lSH9Nsrx5LhqrTkqE0T3BKYb3Q5kgMWo1Aw5/vRvAF
	1BxmP3V7l2HdAVgR08jVpEUjyCutyoo5P+D5zdbDMz6/skr+Xzul4Et9iNUJC+VrLqTkaV6thsw
	T0nDMF0f26Fsjtff/gY9lrvlhFEs/jzUHevUws4Gt2ajistBIckEX852o6qs5MFbcxveW6YqN0v
	Kq5wAulAiypWRz7l4iCVl3rhyWE5RhKiJzZJKNU3off4e5YecygJTVBQaRXTgd2Rez7MC/VHiI3
	UWpIgTHCMRvkWo6Lzk3HYkLOwz2xDnWV8uDR3rMdob54NhMibpg62H1LOXTgEEmBg=
X-Received: by 2002:a05:6000:2588:b0:47f:91f0:9a8 with SMTP id ffacd0b85a97d-480026d7a50mr37788215f8f.23.1786390801677;
        Mon, 10 Aug 2026 12:40:01 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/9] rtc: abx80x: add support for abx81x
Date: Mon, 10 Aug 2026 21:38:17 +0200
Message-ID: <20260810193826.210683-1-apokusinski01@gmail.com>
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
(added after sashiko's review in v1-v3), then (P5-P8) we have some cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

Kind regards,
Antoni Pokusinski


---
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
 drivers/rtc/rtc-abx80x.c                      | 663 +++++++++++-------
 3 files changed, 451 insertions(+), 255 deletions(-)

-- 
2.55.0

