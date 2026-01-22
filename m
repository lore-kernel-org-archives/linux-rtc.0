Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8531DF759;
	Thu, 22 Jan 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072393; cv=none; b=aSX9JpRIy4UWHFyJjzoFxm1hPGCiJDZQkY+wWwvDO2LS9XmDOpECA1s4gO/5paMhNLAsd/CQCI0O7T4/MBmExhEf9g+GtmJ+74YmKwvwhv7ACDJpSEOQy/Tj6085D55wzHzYvYwjT7fKQQotL/C5WCISjYDu0yWN4VEfBjZVV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072393; c=relaxed/simple;
	bh=bsdhdhf3EYABCy5EEqy8mI6s5Sjuyo7aRwHmnE5UA38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKe+MJwQkkR+GvKiKBfZp50a5E7qF5LHF1fkxxV8U40jvg2wwvilZrCCFgDu94b2C4rsxfwkb5lBE9zRh3r/vRXhAggaZMBWtoeyEvAMc7edJ4yrJvfTwmZFLAyiwXeFz88nI/bolkfcUxvmSFRFWDiCwu5pQTCUoimJC7r2vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=scSq+P4W; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="scSq+P4W"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AOkNmjFjFDXqixFJ/aqZgwzlI5uVIiKM+mgkZVr2ysg=;
	b=scSq+P4W71btr51UWao4cwhLhWLt/EaPWbIUGBLSl5lb8Ok3vU0yNt8MPxQ/ImW+BdTflP3j+
	Ht1P+2xCNWu+TXOTf0yV+lj4hI//tOtjvAfpPKB4uraCREVSTYvkYutAxRKhYhsnZlOuvue5fen
	WvveD5oSxdDTE+gJIFSamf4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dxZf90q5Cz1T4Hx;
	Thu, 22 Jan 2026 16:55:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3257B40539;
	Thu, 22 Jan 2026 16:59:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:59:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] rtc: class: Remove duplicate check for alarm
Date: Thu, 22 Jan 2026 17:00:31 +0800
Message-ID: <20260122090031.3871746-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

In __devm_rtc_register_device(), the callee rtc_initialize_alarm()
will check the alarm, there is no need to check in advance,
so remove it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/rtc/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index b1a2be1f9e3b..84885ba6135c 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -410,7 +410,7 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
-	if (!err && !rtc_valid_tm(&alrm.time))
+	if (!err)
 		rtc_initialize_alarm(rtc, &alrm);
 
 	rtc_dev_prepare(rtc);
-- 
2.34.1

