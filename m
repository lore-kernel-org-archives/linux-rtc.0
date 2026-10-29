Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280897;
	b=evR8zRSehuln5nLh9PpblIXmfSBmoQwfG/WON2HzyYDPSaq4J39Jo8Ryf1CeCEufaxrN
	 QhxI8g8c1b2qn3GEzLDwufV8btGnVgIP6alqyutTRku+gl2PirWagW6jxmGdE9zyk27i6
	 GfHttdTiZZkEIgXJzIO3rRHkMRQhl1+dqmGIwVimF/egoS8aMBIfPa/nphhoGsrtN/Hm1
	 k1dE4e03oefwf1YnmGhHqi43yxOngAvEzP6dMke0XnRYPGfQjlLq/Rg8hHj/GX34oSLba
	 Qr6RL/41wq9KpJLBIHNRxZZhXeCL5LgOWeDGDPUlUU0D0OXZGZIqVdlhnYDzhoCRn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280897;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=M5EtELkjlCBuTVdRgQKUPQ6Cy1aBPE3OGjjKQZM1KyY=;
	b=J3R8U9SZXRG4yazxt6CcoDMUqprWYflRkD/FwUCbiAisi3r1rL672PJxOQeEcFpyeDEq
	 RNjCP/Id0sTf2/68OzInwjgxYHckOtLVn68Awlf3bJw1Ljpbow7PqxK3nTn7ok2GA0T4P
	 LdC9BXcBfdikXVtd6d7KdVIqaJJPVjW9Q4MNjUq15CzMiueZUNp2PpcB2+b6bwNUL/Zpl
	 q/4hgIYVuRB/GeXTNSiVBS56M1jbrNLIPp0EcvXIfise8L+C9glf7yFeWZ4rGB6Gp5lAt
	 IY7lZqMUT7srE1AaZcW/W0qAwdPcapiBxofc0asa7qSj4MDCZwXMXCNiEBoyi6Gboug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HYpyBFbf;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A9606A31E
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4A9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HYpyBFbf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 10F9A1A139C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D378160360;
	Thu, 29 Oct 2026 13:34:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF2761032900F;
	Thu, 29 Oct 2026 14:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280890; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=M5EtELkjlCBuTVdRgQKUPQ6Cy1aBPE3OGjjKQZM1KyY=;
	b=HYpyBFbf+nA/IedgVmnPbvDdTWh0sTAQp/6/rkgOSO2A+eOAPi1FXbm/dyuDb5lipeVZHO
	CLkc9BJamJWB3SVSMlXq87jdlh87b9IQSqTuL1rnXKAVMftIftqEXQB1KSpfd7xh1q+nrJ
	Xj7cwsVpBO/dPczynN2uOFKxiPI479mJzwcwYRYLLvGLyY75iOOx50wPDgQ8H+/qLyEauK
	tUvpgu7JX3bu7TWmZLGB1zQNlydvZ6zxMPyz3hniXLppDeSSwUrKHPV8EPaFc7Q2NSj61f
	n78LPDLadJSkS+zFkYzuFJr6wdlTq0T3NB8Vi4Hi+cU0kKus4YZ12kSiu9UGlw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] rtc: ds1343: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:31 +0100
Message-ID: <20261029132339.925021-8-alexandre.belloni@bootlin.com>
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
(ds1343_show_glitchfilter and ds1343_show_tricklecharger) to conform
to the recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 22abec4ba656..0ec5eaba6bd4 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -94,9 +94,9 @@ static ssize_t ds1343_show_glitchfilter(struct device *dev,
 	glitch_filt_status = !!(data & DS1343_EGFIL);
 
 	if (glitch_filt_status)
-		return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "enabled\n");
 	else
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 }
 
 static ssize_t ds1343_store_glitchfilter(struct device *dev,
@@ -180,7 +180,7 @@ static ssize_t ds1343_show_tricklecharger(struct device *dev,
 		}
 	}
 
-	return sprintf(buf, "%s %s\n", diodes, resistors);
+	return sysfs_emit(buf, "%s %s\n", diodes, resistors);
 }
 
 static DEVICE_ATTR(trickle_charger, 0444, ds1343_show_tricklecharger, NULL);
-- 
2.56.0

