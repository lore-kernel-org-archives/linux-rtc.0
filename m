Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280908;
	b=5U9s2MMOjWc8u7CoZjyXgtqYzfmkYS1ruFS9sV1j11RCnoVawPcgUEtwiDWaG0sc+n7N
	 7c1BD4cBNFpORRCNFNinrxdbXQxbZhFh22Z5pySoniMe6YA/x9ORIZzavbKqS5/5Xn/wl
	 aiQyYSLyh1Y3uPF1ZIus1WtKgPi0zcHalfVH7UWxD2Kq6YG63G5zs0EIXzalxNWjegT9o
	 aY2lgL0T86MGtfwDC5bVOufH65FsHNCoAF5GepMrzZgxROE9DXVuFXXxdskQHzaNVt0zB
	 8+GaRc+jP53WoNY+GLbaoSK5ZXcI1r2lNqFanEMbNbghhNyb5DBXtcxiPqL6Un5x3Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280908;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=BfyENGR7lkZ0yvb4xndUvOYLF5GB3gvkTIBj7aLyG80=;
	b=Vh0Rc4H0W8VgHV1rFD9fpsf2/plBmtdM12pd53pwCPOQgUoBe6z3dgbzh1r382PChX39
	 AYyr51iwhvW+rCZuED6TpBPJ7kiuK/JmUgxj6t9Z0qGXdqPBHIgh/J0uguMEDmo9drHxZ
	 TguY0DD2Fbeb6ZsH9u2LJtE16XBgx4pomE2jPKkE2pIf2WLiVmeBTs/eR9fx8s66mVdgG
	 cZ/BxsYNlbzU565zg4sopdM2wtb1LOT4IydKtq56tDBO9gJVAiYfkpNS0iIRb471+LzSs
	 1L+KXoIJCUqZ5MKxmqcGTt74JB9bh5EYveTpZJK63D/zFNRv4bOB2+ziVQkDMqsJ9UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="cXG7jqN/";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC19606A324
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC19606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cXG7jqN/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3551C4E4138E
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:35:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C1ED60360;
	Thu, 29 Oct 2026 13:35:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF2B61032900F;
	Thu, 29 Oct 2026 14:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280906; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BfyENGR7lkZ0yvb4xndUvOYLF5GB3gvkTIBj7aLyG80=;
	b=cXG7jqN/P2X+KX+f4T2iF1qiUKwtPfHXdNJg1ocYPnUmUSwcvo/fYqIkAIPvB7f7/F5tBc
	b0fJWGYim/JZ0+DvrBZkTKplyO6UC0kRtzbvxQFG1jbuSgSA6X6/Am1waRRIAbg2whwRQ5
	cjzY1F/tq52/DPXhKV8lDKXVLnAi4G1gGjgHB53GOKW2m1ZO0RCaC3FJQ0qOHCqnpoe28r
	Qihb9y0ciO8FZmAJSNjFnYWKbDtCizwyoZOchTipES5HRgikv3FitPLlyJM8hRYLRd97w2
	hBp2cGiIyw5egtN0DKXF0NdAp+Ok1SfTG78st7a+fYpTNeiF265y7aVzPjGx7w==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] rtc: ds1307: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:34 +0100
Message-ID: <20261029132339.925021-11-alexandre.belloni@bootlin.com>
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
(ds3231_hwmon_show_temp) to conform to the recommended sysfs attribute
formatting guidelines in Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8627f84232ce..206a79d28568 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1380,7 +1380,7 @@ static ssize_t ds3231_hwmon_show_temp(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", temp);
+	return sysfs_emit(buf, "%d\n", temp);
 }
 static SENSOR_DEVICE_ATTR(temp1_input, 0444, ds3231_hwmon_show_temp,
 			  NULL, 0);
-- 
2.56.0

