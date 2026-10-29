Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280910;
	b=DHRO90AXqogTCs7uqEGiQqU7XJ4K3WT4Re70I0rmaxxBiI3ssEdoLQzh5jfYZF6Z22MJ
	 /FnQyKMOu6WryVlpgFDDgZ8r57Stsp6ZtALiZtoSMSnRYrs9zeVYrWApe5U5Y9W1CZZkz
	 CewZRRSQHdXtJ3Qb4OJ1fRrBW4KSCdWPci3mt1u61JvadQfWrOD+ZfCi8aJyrzzJyv1sm
	 wKcSTzPE5oBJg/8MHT/0ahcjKUzCnfbiT4wQbYbNAyCsn57a4li204raB7yjIJBPue+hC
	 bqWi40/2UZj2fT2bNYhMWR7bwALDZr6WQVxBPTFd9cBFFM4uW7YeqXyb9b0gODA4+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280910;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ewotBPttJsEwIQ9ge/HE7qXTU/gs1slzir9JWzWgWek=;
	b=eg4VLjInxf40PHohUnIfVtD+yEipZFZVdeyozwykpoIgtIPQ2K2mOtOhn2SIvoqn6U8c
	 uwRsJrVMVVxzQW6SMJe2zf6ko7WKPNM/j30qLvxXYBOmGmqvL19nDEVcCNcbyPslbTps9
	 kwLOfH5T1CDP1wtQ54hz2b8gBmKfB7VmWkYLgegZ7xxJAqWizCbVkTPKfvAqaB4w4wKJF
	 dFZy+HQDTll3o3232095/yjsu7D8q5cNPKqt8IOItruF7NeLcciY6lBzV9lR/bg7y/nJQ
	 sycFQcFFMirV4idzi+P6vIE9/LLuVoobso2w65WiS4uXKRxhzT7albasjfBvrOJuT0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cqTQv+2A;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5D60A2602
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D5D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cqTQv+2A
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87114C49F44
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:36:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E34360360;
	Thu, 29 Oct 2026 13:35:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E3911032900F;
	Thu, 29 Oct 2026 14:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280907; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ewotBPttJsEwIQ9ge/HE7qXTU/gs1slzir9JWzWgWek=;
	b=cqTQv+2AoWDhau9sjYIeMi4BVwVTQbGRdYFCfHvWAvVkMDEZfXSEd6GPX8O5OyCavYLUA7
	NbWgG37l477gzs24FkJZP8SlSPUKLrbTd6xCZ1nLSML2UZ2K+rfKXaArjYjCDR+cSV7Nwo
	zvbXvKdIJah8ejvTBz2ZYrDhz+Q7GaaPIJJw7Xv4qoJBhABBiC8YnyNUuhfvl9Mz1eP1oj
	8vMB8/GrixUUTgRZ66kzXimNARdVrwLG+QfJ4+ieT7Nk3jzCKcPfvazJfc7LH3IxqLG5Ju
	3g7RHoiW9o0/wkn8fAZv6JWVvyRzhte2VnTHUo6P981iKmB13oskDwSQoiZeZQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] rtc: rs5c372: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:35 +0100
Message-ID: <20261029132339.925021-12-alexandre.belloni@bootlin.com>
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
(rs5c372_sysfs_show_trim and rs5c372_sysfs_show_osc) to conform to the
recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c372.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 9ab6f2c28f7b..a4bd042908b8 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -699,7 +699,7 @@ static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d\n", trim);
+	return sysfs_emit(buf, "%d\n", trim);
 }
 static DEVICE_ATTR(trim, S_IRUGO, rs5c372_sysfs_show_trim, NULL);
 
@@ -712,7 +712,7 @@ static ssize_t rs5c372_sysfs_show_osc(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d.%03d KHz\n", osc / 1000, osc % 1000);
+	return sysfs_emit(buf, "%d.%03d KHz\n", osc / 1000, osc % 1000);
 }
 static DEVICE_ATTR(osc, S_IRUGO, rs5c372_sysfs_show_osc, NULL);
 
-- 
2.56.0

