Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E43A48F6;
	Fri, 31 Jul 2026 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485111; cv=none; b=ghme2GrXeYR7lLAf0X+2wYwI8mQVq4R//9SOUkYOMs6waRVW37QbjahK8nbnGpUKPcAS1LzcTrb1mljlEs9TTZL3KLH7cbA2KiN7s914KlGM5yO4WYzwKwZvZ0SpzR+ZiX+BOFMMhBkDUvNJiOmIPOs4h72jm9TpN1Zp/4TRDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485111; c=relaxed/simple;
	bh=UsnT39TT2zTmlbKn/908UDXfZ7cbsvLxDK2sxCM92IM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1otBAr8ZlBB0MvDLpimN2DL7Cdf2uOiPQB2JV+CDUf1TEOPQF+r5ehy+zP2k40l29uQV1pj4qfHnKeouJlmYzdgM98IilukZw4+VJRI7EKa/ro3HFhQ0lYWvsUQzFOxnUv+iHTsJnCuvQCEvHoO2tX+qXtEzpuBpRe8cpxgwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 88b691e48cb611f1aa26b74ffac11d73-20260731
X-CID-CACHE: Type:Local,Time:202607311602+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3a75800b-6e70-41da-b0cf-cc16a248337b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:1c371c63bb67442e506e582bee36bfeb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 88b691e48cb611f1aa26b74ffac11d73-20260731
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1346168160; Fri, 31 Jul 2026 16:05:03 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] rtc: gamecube: check return value of devm_rtc_register_device()
Date: Fri, 31 Jul 2026 16:04:58 +0800
Message-Id: <20260731080458.417532-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gamecube_rtc_probe() ignored the return value of
devm_rtc_register_device() and always returned success. Propagate the
error so probe fails when RTC registration fails.

Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/rtc/rtc-gamecube.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 045d5d45ab4b..889028cecf4a 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -355,9 +355,7 @@ static int gamecube_rtc_probe(struct platform_device *pdev)
 	rtc->range_max = U32_MAX;
 	rtc->ops = &gamecube_rtc_ops;
 
-	devm_rtc_register_device(rtc);
-
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct of_device_id gamecube_rtc_of_match[] = {
-- 
2.25.1

