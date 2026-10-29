Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280886;
	b=Hni0fNfJDjps7lTjIHtgKEw4spTwM/Fugt5yoS0k2PC9iT+MQvHKr7HgCZb2UR/WQLrc
	 VmJa+GH7hDx87vIh9I7fuI4R9ThjRjYQswdavc2p0cqruCv02WDzoIJmnzUNhwPOfsfiL
	 ZV5RFIQZsX/Ux4fIbBMhRExG7C/Ibrtvc6kJbQUnSj4K58gz+yTBKlcJT2Ju0FIZMlpww
	 iZJZhY4E5K2c/eb6iFqGbVb0v7j+3RuzQL0WF6I0RM93WoOPYvrm/Z0fv+s8G999tRMgV
	 eJNDzvGL4STVg5GRMR9o01WU4ut72pQHngqVkvi1ZYXKlmwJUfMqdzLsoa4AwzTHxYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280886;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=w1hruLV6HKN+T5ZDxe76kALw51wUirPXG5Dg9/PUjtI=;
	b=ztTpDxWdQQit0s1IvDcN6u1M797sATpvwe1TQSGbaiRxeI7kD779oUxc+TwKpqqHDR1+
	 /uXTXBbHLuBnlcAn8SZIljRtJ8C5OpQvtONrz2rHx3+pQi7lYBHBul8edgxtQFAL56uM+
	 2XkIBAbBC3ZDzrq52bKtO6cP8IDRlHJ5yYDZi7fr9WfWvUqron1MzSudotvm4Xceknw/6
	 zJR5G1LtyiBE3V39KhvdtwcKzL9EaIO3CktFv8GDVLS5VL5bBATMzDyhNqNhCus4gfkTy
	 oVBYRQtZPbcuQ8rRXZqzf9wEWR6FqrWeFupy/idKYynSbaY0KbMG306uv3dXMIV74Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KOSn4OM0;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE0606A31E;
	Thu, 29 Oct 2026 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9DE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KOSn4OM0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0A473C49F44;
	Thu, 29 Oct 2026 13:35:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A548160360;
	Thu, 29 Oct 2026 13:34:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF7161032900F;
	Thu, 29 Oct 2026 14:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280880; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=w1hruLV6HKN+T5ZDxe76kALw51wUirPXG5Dg9/PUjtI=;
	b=KOSn4OM02uxYUsSdIh8FVpuXFlGngEbqnlCCVU215SXAiIYk1SqXabNmo2Rxk+XpyDE0Ub
	0E764U51Lo1GNlPAd+3m2R9ceRcWsd9KMEX+q2GIiAfSa9VROiZzYjTzm/Mf2AZBP/KExZ
	06N/M99GgwHE2VoTqw2OvkHEv7aUv7qKo4XuPxkKdwvRPDmwtx0h/dDwhOj5vlwf1Cqgfv
	17Qfcw8j+FGLnjwuYeiivDFngGRFHqYDPzTABoSN/P8b1C+czO7Fku5K4q35Yw/LLWKQpF
	62+Ujq5y7+dH2zmRMsWGP14yusBWUvkwdJxqMbZqDDlVRjqbnN9Hx9ErpF7cAQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] rtc: abx80x: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:29 +0100
Message-ID: <20261029132339.925021-6-alexandre.belloni@bootlin.com>
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
(autocalibration_show and oscillator_show) to conform to the
recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-abx80x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 1c69d0e2f940..a0d67818eb58 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -442,11 +442,11 @@ static ssize_t autocalibration_show(struct device *dev,
 	autocalibration = abx80x_rtc_get_autocalibration(dev->parent);
 	if (autocalibration < 0) {
 		dev_err(dev, "Failed to read RTC autocalibration\n");
-		sprintf(buf, "0\n");
+		sysfs_emit(buf, "0\n");
 		return autocalibration;
 	}
 
-	return sprintf(buf, "%d\n", autocalibration);
+	return sysfs_emit(buf, "%d\n", autocalibration);
 }
 
 static DEVICE_ATTR_RW(autocalibration);
@@ -490,14 +490,14 @@ static ssize_t oscillator_show(struct device *dev,
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
-		sprintf(buf, "\n");
+		sysfs_emit(buf, "\n");
 		return rc_mode;
 	}
 
 	if (rc_mode)
-		return sprintf(buf, "rc\n");
+		return sysfs_emit(buf, "rc\n");
 	else
-		return sprintf(buf, "xtal\n");
+		return sysfs_emit(buf, "xtal\n");
 }
 
 static DEVICE_ATTR_RW(oscillator);
-- 
2.56.0

