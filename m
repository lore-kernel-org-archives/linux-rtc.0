Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280881;
	b=WygxU8tDAB9wv/HHVrb5zMu2CaW6dp58NTBfBeetPPxsFaFmTIfv9E/YwyVZL+N/yzvB
	 Pzleurv89xpukQcqyra5eIExHMfiknnBtd/U8Xy6sy24KxjSvFsSUgCiXVLLWJzMRQnos
	 xjptIXyfbSBFAKIwI5eKA89xUacAb0DSSVC76gHzSvGFZXwM7hLwwipfhZk+rDVTncsZn
	 f6u8ukjqCiiF3eFTg6xjpFulvBop74sOm1lrXh4lZH2FIULtO2Vlbt8/RdXg/SXliQsyO
	 a5tUK7wXwa9JsPg5rC9VhM/pLDbIuvquQA4vrpJ3SBP0BUiPc/sycPDO9ZMssqeOG2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280881;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=T0WRYk0ktwScdc3PA0Azn9yZexvl+vp2Wbcl+a1xTjk=;
	b=BQ/CL0Rqzkd2rfjzQqMrr2Yqed1t8f/ZrE6W0gRyTf7dfk2er4lX0y52VAKUIaGOk7M1
	 JyYMIXn2ASzCTpNThEmCh1f0+q9woE0obiWqrczyUhFKxLkGu2FCDMN5RSW84Ptq/nWWB
	 EnmmjQIhoHwpj/1It/FBXpXFquahovoTBEfvQo6CAc7wEvze/ESNR+P5Fyvl/Q1xaigml
	 GW0PeTwT5jJYsGC0jMrf0WzUI4OvI6Jbq6R4ESK2xvNj046ldq5WNbcQcGwip3nlOH8/Y
	 8HLiomCSlOycIR1EjAl4X/eMDs0M7Dt1fRvlwc9bNDeKFmooIljv+hW6+U8PjlrkGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ab7BwK3N;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF701606A31C;
	Thu, 29 Oct 2026 13:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF701606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ab7BwK3N
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8A76B4E4138B;
	Thu, 29 Oct 2026 13:34:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60FF360360;
	Thu, 29 Oct 2026 13:34:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8F5D1032900F;
	Thu, 29 Oct 2026 14:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280875; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=T0WRYk0ktwScdc3PA0Azn9yZexvl+vp2Wbcl+a1xTjk=;
	b=Ab7BwK3NA40qIasaJoygIyZwK5rn+QH7LUdhfzdGToCnxQiHC77H88lVL+iJEDFe+zJcRx
	X3D5xZWVJY7PTOBCYlKk4gmxIS7rmFKZdO9nRVuphHMXO0grpFrhsGCSZd8LBwJ4/XDkOK
	KT5hLozSY9al7w55HLAt5qaKnx19ndjWezD/JPQ14uuSEKrFlKNFRA1szDIVXigWE5wPai
	jzUiLktzedzhfQsOGgOHA7TKSmYf6ckzW/XDAWDKI1zwBDBSd8H/Bn7YJYn+nnxVkTOij7
	0zd8UsUaSRmwlFFsZZf9AiQ9mGtDeBHyUVoUlK/84KLyLslgpze2JAEzlmglnA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] rtc: x1205: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:28 +0100
Message-ID: <20261029132339.925021-5-alexandre.belloni@bootlin.com>
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
(x1205_sysfs_show_atrim and x1205_sysfs_show_dtrim) to conform to the
recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-x1205.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index bb1a5c86f621..6ca6ff45945e 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -575,7 +575,7 @@ static ssize_t x1205_sysfs_show_atrim(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d.%02d pF\n", atrim / 1000, atrim % 1000);
+	return sysfs_emit(buf, "%d.%02d pF\n", atrim / 1000, atrim % 1000);
 }
 static DEVICE_ATTR(atrim, S_IRUGO, x1205_sysfs_show_atrim, NULL);
 
@@ -588,7 +588,7 @@ static ssize_t x1205_sysfs_show_dtrim(struct device *dev,
 	if (err)
 		return err;
 
-	return sprintf(buf, "%d ppm\n", dtrim);
+	return sysfs_emit(buf, "%d ppm\n", dtrim);
 }
 static DEVICE_ATTR(dtrim, S_IRUGO, x1205_sysfs_show_dtrim, NULL);
 
-- 
2.56.0

