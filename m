Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280891;
	b=k2ChKxqjcBUTNNAYckCXGn/k/C1fKq9GUCj9mfnOYXdEaVxXoGD6RRXuwwET/YiGnX2/
	 YXUuXKTdglmbGfZVPuqF4Xswzrwf+8NZ81Gfd+ZAbIcK3dLkERnnomJPqepQUKrzDeJzJ
	 n9MKOg/4YYJKlrwmR5kPbv9wpYFixqqc47CeL1UCEBMsUDvzU0t/AUMxZD3eeeNUpePfH
	 24cNnFkmc5QjsiLJ3tTRIJmUV+hbhIW0WufHfIZrI1II4hDrGJUefXhwa2ItMr9hKEqpl
	 bCf4qspAp7pUcRnmM0i0diKl3vcDgbdaFIgBhDxmScxOwq5ICpGtqajzZikMcdPf1Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280891;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=nNOo9ztPq2H1V9K18/duaVRD55SEQg7q5xZq3bqGz2Y=;
	b=hafCxEj+Xz8G5mHObnPdw5iAbfp844kjlwr2wBkJe9CtRFdUXViRb9Ut6JL6sYs1W7s4
	 WFNxZY4J3ekXWIPeKPeBwTbB3MefClxCtB71DtZheJzbCq2k5Oy/ZzJjRfdBGYVSt5QgS
	 m6o51Mz1KuNo2HM9/9cwb+97g2/AUc8bEwDjohx+Ch8b0ulre2HuBye1yTAbZTM1oNsdK
	 zlNx2t3VbZJuvRxcoJtxMf3Hy8M9lGIyTk5T7pSZjeaCBoA7RZawM0JZog8M6ew9k4E7U
	 E0BRKW3qU+IpqiAb/aFs3jV+oibt3KN+rAl5co+Ke7wePRngjMWQijzSPbKpqYFRHeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DoogYOgx;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC3606A31E
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DoogYOgx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DB1904E4138B
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0EA360360;
	Thu, 29 Oct 2026 13:34:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8ED31032900F;
	Thu, 29 Oct 2026 14:34:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280885; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nNOo9ztPq2H1V9K18/duaVRD55SEQg7q5xZq3bqGz2Y=;
	b=DoogYOgxvPvZsXRXiki1NVQmA1JmsUoDXuKTcP+1epCe9qp9fguE0SPcIcTFdR7Na2qN0E
	r2M/tnmmF12pYcmHrFTbiAaVun8nToKbYx6At9pMotgwCgQ5MO8vOJCGqYVwP/5KiQrw1Y
	ll2z5jwSJDep5uzGKTxAoRWPwiXBQe/MH2AGrJtYnqS5Ym1rF4R249hw3uG9OLyfaIC461
	ryWoKygSyx8dCbpx1+YRlkHq0lk8zZvP/cFIrfw16aXBgi4+1oG8vIrWGg9h8/sXOCfauC
	krlafdJ2RrI7ZRH0nS00MHCPPfij6ZGzqMNsLy7UA75bAuq4ZglpVtmHsxLhfQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] rtc: rx8025: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:30 +0100
Message-ID: <20261029132339.925021-7-alexandre.belloni@bootlin.com>
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

Use sysfs_emit() instead of sprintf() in the sysfs show callback
(rx8025_sysfs_show_clock_adjust) to conform to the recommended sysfs
attribute formatting guidelines in Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8025.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 2f2deb59cbee..96a04c977d0f 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -486,7 +486,7 @@ static ssize_t rx8025_sysfs_show_clock_adjust(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%ld\n", -adj);
+	return sysfs_emit(buf, "%ld\n", -adj);
 }
 
 static ssize_t rx8025_sysfs_store_clock_adjust(struct device *dev,
-- 
2.56.0

