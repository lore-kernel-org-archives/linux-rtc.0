Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280902;
	b=zUapu5c/usN+SyXWZ1ryPI2q1loE1FK+9gSkblZPTbPmhZZ8pvsXyoldw/d5rsxlTDFT
	 aQn26uPSU/BI0I4EQSEyAsHp7rgXn9OJDuSYQXVA/d/Ddd/hQ6v38nTjWNH2wco3xV18Y
	 ElN1udFyL7uPibYxxvhNpbm0WnaOEpOnmgv8Ffo/NOwx7uYvCqyizs8HJu1UiTTJQ6M0/
	 AOHl7WmRsI6wmym3xMSUleSVWSKhAFLZMwzPXthq+w4G7fZlDWLAndssJ4ycOCLpAH65C
	 izMLrQ3lIbvqwb26IliLKbJ00u1YuWU2gDkpYGkUbGu8thGXyubh83tcnJyIkKakWwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280902;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=hzpa1p8pFos3CJzbXazpLtnf4XKtlgHWA6A5JBwhE24=;
	b=I3j/JT+H0OluUE8rX+B3m2BnJKPV/RdiLnT7RfN9cCwdG+nzbg9lonToPt8JYetHO4Mq
	 A0kDeXYFycIFM8KaLaC/n4rojcwDkH3Gw411LUYPLYLF2ULxHGhHAYpo9BHPZWTl1gMSk
	 jGlzqOSKYER3VsPnn3r7z2RpmBuoIkbW/TWms4h8lTXvxR37ZIMOiBMKOt8+V3uSGNAyh
	 r8t0Z1D0ptfRvkGsrMwhUifcUL0Q2D3VTQz14G4QX5ylOTBacBmv6u3sceY5LpB2mjV3T
	 9AwnDLI0ubqoo8QOnfv9GhmIxbZoSxu850yHqLsZQX1jNdVsbvycKLbipMk5WFiKNAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rBFoaLJu;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A2606A321
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C2A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rBFoaLJu
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DAC77C49F44;
	Thu, 29 Oct 2026 13:36:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F85260360;
	Thu, 29 Oct 2026 13:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99FCD1032900F;
	Thu, 29 Oct 2026 14:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280895; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hzpa1p8pFos3CJzbXazpLtnf4XKtlgHWA6A5JBwhE24=;
	b=rBFoaLJuB9HqBxQo683PgzTnPcxdPRoa9fz/ySr9OyvgksBOfuE0fsIC8lvYHxg7gYf9Df
	ZpfQdItlA5sVcNETZ0+8j2ByP2erJ3Vl9W/A4S53VAeWM7Pz+8S7I7Rf2Xusl/ooRD21KV
	MmTAVT7JAS6aHbiq6hXACiGa6Kn6/IS/6SKtvPKICSOibM4GE/cvuHZGyMSgW81+q0TK/0
	+WV9oKoDYoKkoWAsDDMXG8hd8N7cnuuyJ5EBhy6tampOEtsFjBzCNIzuWdz9mYRTWDC9rQ
	nkrso4ZtJLslFVYFkApRyHMAm+kQJb6LvIClOHBAAEiSEsc8I2/4HOzCeW8sdA==
From: alexandre.belloni@bootlin.com
To: Joshua Kinard <linux@kumba.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] rtc: ds1685: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:32 +0100
Message-ID: <20261029132339.925021-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Use sysfs_emit() instead of sprintf() in sysfs show callbacks
(ds1685_rtc_sysfs_battery_show, ds1685_rtc_sysfs_auxbatt_show and
ds1685_rtc_sysfs_serial_show) to conform to the recommended sysfs
attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 284815e5f478..323fc9c17106 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -988,8 +988,8 @@ ds1685_rtc_sysfs_battery_show(struct device *dev,
 
 	ctrld = rtc->read(rtc, RTC_CTRL_D);
 
-	return sprintf(buf, "%s\n",
-			(ctrld & RTC_CTRL_D_VRT) ? "ok" : "not ok or N/A");
+	return sysfs_emit(buf, "%s\n",
+			  (ctrld & RTC_CTRL_D_VRT) ? "ok" : "not ok or N/A");
 }
 static DEVICE_ATTR(battery, S_IRUGO, ds1685_rtc_sysfs_battery_show, NULL);
 
@@ -1010,8 +1010,8 @@ ds1685_rtc_sysfs_auxbatt_show(struct device *dev,
 	ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return sprintf(buf, "%s\n",
-			(ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "not ok or N/A");
+	return sysfs_emit(buf, "%s\n",
+			  (ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "not ok or N/A");
 }
 static DEVICE_ATTR(auxbatt, S_IRUGO, ds1685_rtc_sysfs_auxbatt_show, NULL);
 
@@ -1032,7 +1032,7 @@ ds1685_rtc_sysfs_serial_show(struct device *dev,
 	ds1685_rtc_get_ssn(rtc, ssn);
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return sprintf(buf, "%8phC\n", ssn);
+	return sysfs_emit(buf, "%8phC\n", ssn);
 }
 static DEVICE_ATTR(serial, S_IRUGO, ds1685_rtc_sysfs_serial_show, NULL);
 
-- 
2.56.0

