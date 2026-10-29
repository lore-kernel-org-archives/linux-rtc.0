Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280863;
	b=vjo8aOUKE4ArkC5R/ykmuCorKLsft27lz5VvjGy/JZaFCRFhVa1B+a05JK3QZ8wz3UwJ
	 ec+wTsyr/Yb93CFmXdUbxr2CKN8RWmdNsyJoMlWPD8sgk+I6b71LsWApS+IxchMBnuUJJ
	 kkxmH4aqG8LDAFxOkmjUeTD5hsqIn+SsKwqCnQb/Zf/37/LDPqWlYH2Qaw2Wpvj00S/9A
	 E0GhAWV26fBzkHg8UhhoqldZAY8AmGbcU5suo1Ir8Hl+YkHvkbwrJtCk9vKhGn39YpdBP
	 WlXnuQ88urfZCVf3ac3VLKZWBHgCoUg0hoUqGWADLP6p2XhIUFXK6wbEBuPeTGZj/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280863;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ehuNm5962bhBfrJ2br0vFB3kXOTeu5TKvkjY7nlUvb0=;
	b=TIKXaNPzoz2QR62FZlThAHQBjPwClKPhLNBByuhs1adbwNLETq7jrXVmPwnIFpSjBBbi
	 UqESLx2C5lCBWQLDxHX+LPvLcAikoJdtgpkmKtqrTqSZyiY7/1OrBo3Va3cSx+cFOAcq8
	 ZWlOeik6HzVYay8iPmkVDT12OSEaijgZ3NW6FzN1BdXClgL6zoIq28xQEQrzlCYyltMfc
	 C10QcN9xyjLipqJvvntiGKdyY6r7G+ldynyGUDeSWXcvBKEzUbTpjVxovFz2pFOmNkBMH
	 n8lA3e/WYP18hE8Kx/phzTE4kkG14eoa3EGCYT2VFGJ0Gfn6Dof74mSiNvdCQW0XV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iaDwkGoX;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE90606A31A;
	Thu, 29 Oct 2026 13:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iaDwkGoX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5DB131A139C;
	Thu, 29 Oct 2026 13:34:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F5EF60360;
	Thu, 29 Oct 2026 13:34:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B118D1032900F;
	Thu, 29 Oct 2026 14:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280854; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ehuNm5962bhBfrJ2br0vFB3kXOTeu5TKvkjY7nlUvb0=;
	b=iaDwkGoXxJKFSekSi3irLDOn/T5iwDPS5xGhyuoufnGMNb/PU8Il1ID67Ot22ctaJQnc7I
	WMzjLUpRbBVDYn+nvrcRqxf9Y4sDWzBYwtNvN4CMr9RY0U5qjhabukAQbxl+K99cqCMMZV
	/++dP1NiNRavmZCHTl/+YDNVBmQZNFhHPADkUlrlpBdS7YyQYY2Q6JX8SbSZ03/XRmER2y
	tWATKuic5qKC/Dy0aCAfbZInYJjb8pnNhmJn8XAB83UrC4AMGzxevSeesFoNEe0rC2H0m5
	5aQoZeaApTA8lxrPTDCbGxUQAY/O3e0IBH9Cl0T3oIVon42tZ0xsh+O/VD4kmA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] rtc: rv3029: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:24 +0100
Message-ID: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
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
(rv3029_hwmon_show_temp and rv3029_hwmon_show_update_interval) to
conform to the recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index c348b31928e9..33b73bbcaf52 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -601,7 +601,7 @@ static ssize_t rv3029_hwmon_show_temp(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", temp_mC);
+	return sysfs_emit(buf, "%d\n", temp_mC);
 }
 
 static ssize_t rv3029_hwmon_set_update_interval(struct device *dev,
@@ -654,7 +654,7 @@ static ssize_t rv3029_hwmon_show_update_interval(struct device *dev,
 		interval_ms = 0;
 	}
 
-	return sprintf(buf, "%d\n", interval_ms);
+	return sysfs_emit(buf, "%d\n", interval_ms);
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, rv3029_hwmon_show_temp,
-- 
2.56.0

