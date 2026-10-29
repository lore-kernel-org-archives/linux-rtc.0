Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280871;
	b=tqD9tEupjZDs5K0BmBQLMCfVcjry7x02ug9CECrSgEYLlVj6zlDdHjwSYwsMIwlbc7yS
	 7ok4vLUPhSySIJ3g1AOU0LUSPu2lRfEyNcvhxbG1dCQ6xMLqlZQM4wkEhoidIfQZ0i7EH
	 PW9hgIGpvu9tIQPw8hKyhSwK+mUtEeEWuy4MW9Rl4f9eM7s/yzDDc7Vq9qJfQFbj1BSkI
	 9EdChgfJO5v530Aws7N7bVspFlah86WOat0nCO4OGR41nu9DIS2KZTo1bhSRUF6Ne7/I0
	 UUcYhZ4+/Mz05rt7zgIvwmeJ64Dycgmd8KyfzseFoEeKJ5MRBytMSUbyIXeugkcD6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280871;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=tiTyn3ATgJNnKgh5hFl7FDhnL41Fqwy+E3sMEhqAePw=;
	b=zNHB0xlQwUZOhtTXd+sZB7aEfVVJfCfHyX8VGhbjx4mdyPME+iY4QH0UbKEBWoSjiXm8
	 dYhlXnbSsZ+ZjxJwmS368+THE/JSTQ9ZJU7qqrhQVUZ6gsVd9/szA77o99hDpQSbhdzvD
	 n0r3m1n86HNAAtZ3LN5adKnQr6oPLyGbs0LmeS/mvnomHWfQl51VSUa5+U47WAJQGcPGz
	 E7+iw4ceNxTqClVlRV3e4FPL1muI6MNnYMd2CRowpF8XoxWgYLnSH/m7TOmy3jCle1tEa
	 gR0jXgTfUxBllyXFHjD9KApqKZ/sAlSC71+aAqDlHRO1XC6qUe+DAtjEggIQjnfL/Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="J2Y/R8+X";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF7606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J2Y/R8+X
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 77C044E4138B
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:34:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D6F160360;
	Thu, 29 Oct 2026 13:34:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95EBE1032900F;
	Thu, 29 Oct 2026 14:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280865; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=tiTyn3ATgJNnKgh5hFl7FDhnL41Fqwy+E3sMEhqAePw=;
	b=J2Y/R8+XCfkwyK4wW9+s4UrOFleqwQOyXr9+uBPBmveJPsgtoUMYR0/AQU1l9J7+VB3V4M
	yyeob4oOiduWfWKa7HCr58P3Ms8ydtsUdFytKd25VamE8UEoIwiLYA49l1I0WVpCCdhr0j
	Qf4/i85L/PVcyPGEJfn8EOKkIzWG9ZBxiDgwS/wo7VxENcos2R5ZsL26qvDhC0ixcrZr1h
	wW16wuHvT5t1ycjXeF1cVzd/RjSPohinVrsS/WSBPskRHajk+rxCE7Hmv4pFdiGgAw9WAC
	cn9X8nq0ePlGtFUARMW/ykAnKfX87XEzmzPHrRW7w/F0WDdpo6rjUJlCxrMQDg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] rtc: ep93xx: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:26 +0100
Message-ID: <20261029132339.925021-3-alexandre.belloni@bootlin.com>
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
(comp_preload_show and comp_delete_show) to conform to the
recommended sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 507c9f22036c..f105aba28459 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -93,7 +93,7 @@ static ssize_t comp_preload_show(struct device *dev,
 
 	ep93xx_rtc_get_swcomp(dev->parent, &preload, NULL);
 
-	return sprintf(buf, "%d\n", preload);
+	return sysfs_emit(buf, "%d\n", preload);
 }
 static DEVICE_ATTR_RO(comp_preload);
 
@@ -104,7 +104,7 @@ static ssize_t comp_delete_show(struct device *dev,
 
 	ep93xx_rtc_get_swcomp(dev->parent, NULL, &delete);
 
-	return sprintf(buf, "%d\n", delete);
+	return sysfs_emit(buf, "%d\n", delete);
 }
 static DEVICE_ATTR_RO(comp_delete);
 
-- 
2.56.0

