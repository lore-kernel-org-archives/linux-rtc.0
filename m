Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280867;
	b=nOBsLkvwKgBITDyVJYao9ITj7OgbJffpqf8suEiFxSYR7evWYR3IGECN6TLkKi4KOel5
	 HJbgx1ixe/2b/BaoyudswjzeF5fZ4r+v4Ko7CrQGzl2+OMyfc7FrLzoTPNX3ImV+N4teJ
	 D+DFGxIRIWc/jcZTaDp7Ii5NOoTCEa5AVt8fHwsHIi5UVSo92TSWlaItkSJycEaI1fusU
	 w7gDXXusuBC4cT+shuHCwkub2UbaTQgA9IsPra5i/yQIcEz8n+UOw7xROmVK8TQVqkeIt
	 w4986g7sXeBcH9AFSx8yOH/MQWWK3tpUsR47wxRJ5c/sa71t9+d5ubmeucIvP6ElMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280867;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=3BG7e2ZIZ3lcaZgbDCSylnzGgJB1uDgJ+stIiLqGSuQ=;
	b=hyCUZkUERAYHF8KoNxJYNB4v9MaVwR/qRvw7HcznpPBEl57Nv4xPwM19DC0m2dUSt/+A
	 RvQtSwgrmhjexzc2iC/4zPOSZhXKw208k5l7Yd9r3K4rS7ANrQRrq9PT4+bzcKz4BSwBB
	 hGx8f5UF/HDEAnq1wfcoqzlXwy3dKVF6bNmM2ASblpB4uvRR4V4ClE8e9REcDedo+X3r0
	 b8ybea5ZhS6b+bZUrA7kLl8NMgt6LI/WRz5/gptV9VJEhBlfdKgthi5Kk37N73Boakpyf
	 if6IIVK46orNqXUn0c7RD0ff53fRekg+X+0kznI0jpeTOvjwjxqmiEd1rIrk8hBYo3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IdfRae0K;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55817606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55817606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IdfRae0K
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 763914E4138B
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B6F060360;
	Thu, 29 Oct 2026 13:34:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 789BE1032909B;
	Thu, 29 Oct 2026 14:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280859; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3BG7e2ZIZ3lcaZgbDCSylnzGgJB1uDgJ+stIiLqGSuQ=;
	b=IdfRae0Kwp1wxoIpISENWn8bUlR9/5WqBZg/mip1q2eNA26Eb2YJZbl4pm3H20sPtlIUWN
	c2pazzMgP/ZUFNBEs9GNwh2A5ZQJIC5GdLXlIbNkLkBQ+H4mSVwQ5A5phEeoS5NPYJG23Q
	soJahwfPTR6kFkFzsyK9p+HiBD3/aawdUdALkG+nPiqli0oofgnSdtHz91zgwSswYIb7ID
	6noF4x7eyn/H9FPnyOhr2tqy+YMSNzQO2tY1F9VmOAJ28UC0mmR30IcKwxsuXq7GoLcDOf
	g4j7E9dUZ7vKXkqjHI7S3kWA7bczDl2nxbs4x7e7XYGhSJ2sJGHHrMYPLopivg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] rtc: pcf2127: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:25 +0100
Message-ID: <20261029132339.925021-2-alexandre.belloni@bootlin.com>
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
(timestamp_show) to conform to the recommended sysfs attribute
formatting guidelines in Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index ff2023908f5a..49542cc53411 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -972,7 +972,7 @@ static ssize_t timestamp_show(struct device *dev,
 		if (ret)
 			return ret;
 	}
-	return sprintf(buf, "%llu\n", (unsigned long long)ts);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
 }
 
 static ssize_t timestamp0_show(struct device *dev,
-- 
2.56.0

