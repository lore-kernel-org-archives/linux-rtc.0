Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280907;
	b=gBRYUrbk09PDy+WOMdD0Tl/m4h8DB5ggyxnM0ug4HsFiA325mNcsJgcavVgT5/nLeu/A
	 jSLPcBAbeQvqV5oANPi4G4+tJ1/lEDQvsj7CK23ZupR4/uC+ZJpv/Zod3wcFyu+9GTANy
	 X7NhbKeIvVCWhyDH9Z/pdQ007sJNn9IHfGfXxEzObtGdfJ3Q+4lCPpGntKlCoP/YFMXGN
	 jX18QUArHxu+WLccU8Bm3MZmUHTrZgX6zKS4Pu12pRo4XuKaVUU3x0xpt7h1/Rgi2F2+3
	 DXLAAWvA8TgcPK/AOLdO3GRJV9wLmot0ENwca1/S3L7bZq7/ncNx1AIRvmZk7nVpo+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280907;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=YIpbjuCDlSaLii5+zsY/iuh0QshEzbN/gZRLj19F/s0=;
	b=4+bKNCWQMwe8VZUCtv3AQ38hw6AHueOi7/qR08fbttX489hnGRZI7KuKQeWkV8/0/h0i
	 55hc20ybbg8Zp7D0tTsfHUzTD0gsz08iP2mFehCcBojitwtZ68+Uk9HO4lv+AflzHqBpN
	 HtcjDOHYFx+kLZ2n2A9M9mKsKza/sxxvANaBeu1sr2t01TeANq6kMKb4B8JdThVyll9TV
	 OTuu5ZvwwZVnKjmYunNlhgcwyhh86KMNsIcBTbu7uJlchZEa91BmVbm3fRvpy3wBkWMd9
	 /dAlmRPIQvSu8qb+tdahuqBYnhAUUdxh81+O4xGvkn+78ZNvX60lsG/q7wNoU282i0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cit2OSyz;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA7606A31A;
	Thu, 29 Oct 2026 13:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41AA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cit2OSyz
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E03AE4E4138B;
	Thu, 29 Oct 2026 13:35:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC32060360;
	Thu, 29 Oct 2026 13:35:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A56071032900F;
	Thu, 29 Oct 2026 14:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280901; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YIpbjuCDlSaLii5+zsY/iuh0QshEzbN/gZRLj19F/s0=;
	b=cit2OSyzI7jNR9FucFhZ6o1utcnYbgre+dCFtObbneS+5PPPbnfKxBhTij/xriKwHyEIuE
	smo0xZ7bGOVHkMHISXDUHq30XG3Yt76xfg7gtgQEuMco29IRaPEPUZM2pV4aPm2Y4RvjJ3
	Czf8mbYrgD426MgcZ8YsfbLYQ2GNLUQGf7/m7NzZ0wHFinEqbAeg5l1cnFJy3IVl1cHgcm
	9kAH0OL7A67J3+4889U6mzsvLnKp8ELxzDqqurK6rhQu1MfQ68FcUbFPbVBAEQEEh89QSP
	m4Qx+ihgCbr1uXJ1C1KtGrELdj99bIPGcb1aHAR5sOyEHQT3vv5JHgMrtoDSkg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] rtc: isl1208: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:33 +0100
Message-ID: <20261029132339.925021-10-alexandre.belloni@bootlin.com>
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
(timestamp0_show, isl1208_sysfs_show_atrim, isl1208_sysfs_show_dtrim
and isl1208_sysfs_show_usr) to conform to the recommended sysfs
attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-isl1208.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 9bdd5d121571..ee2eb8c475ea 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -615,8 +615,8 @@ static ssize_t timestamp0_show(struct device *dev,
 	if (sr)
 		return sr;
 
-	return sprintf(buf, "%llu\n",
-				(unsigned long long)rtc_tm_to_time64(&tm));
+	return sysfs_emit(buf, "%llu\n",
+			  (unsigned long long)rtc_tm_to_time64(&tm));
 };
 
 static DEVICE_ATTR_RW(timestamp0);
@@ -709,7 +709,7 @@ isl1208_sysfs_show_atrim(struct device *dev,
 	if (atr < 0)
 		return atr;
 
-	return sprintf(buf, "%d.%.2d pF\n", atr >> 2, (atr & 0x3) * 25);
+	return sysfs_emit(buf, "%d.%.2d pF\n", atr >> 2, (atr & 0x3) * 25);
 }
 
 static DEVICE_ATTR(atrim, S_IRUGO, isl1208_sysfs_show_atrim, NULL);
@@ -722,7 +722,7 @@ isl1208_sysfs_show_dtrim(struct device *dev,
 	if (dtr < 0)
 		return dtr;
 
-	return sprintf(buf, "%d ppm\n", dtr - 100);
+	return sysfs_emit(buf, "%d ppm\n", dtr - 100);
 }
 
 static DEVICE_ATTR(dtrim, S_IRUGO, isl1208_sysfs_show_dtrim, NULL);
@@ -735,7 +735,7 @@ isl1208_sysfs_show_usr(struct device *dev,
 	if (usr < 0)
 		return usr;
 
-	return sprintf(buf, "0x%.4x\n", usr);
+	return sysfs_emit(buf, "0x%.4x\n", usr);
 }
 
 static ssize_t
-- 
2.56.0

