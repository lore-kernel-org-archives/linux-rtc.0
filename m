Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24F2D8DD6
	for <linux-rtc@vger.kernel.org>; Wed, 10 Jun 2026 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070449; cv=none; b=Hs1Kv+l2iSpd9++BnuzH+hS48tNIiss+cEdtrjcKu/MYETSgXqezNNB+QK8Uy8/h4MuGUd0Rfw/IRmuFzHFRFGRW7K77YT7lC0yVynHxluFnUIYH1pbGl9A/thntG+JSgW9VoTR1Pg1qId5XoG0mZQSmu3BwtResCAF+aG6T/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070449; c=relaxed/simple;
	bh=wgD4DhtT3jlFQnWg8IKkqA/Gx3YziZdcIzUvKqJLYGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4/6RpXi3vsIpN1OWuryNV/bzCg23Sk0Ea5sLgEWlvx50RzUhIfWvmfHQwCo69hjk75RSB7zebn7xu+fvBY16d8HH0XkwK/HVzzGGYPPlj/I4VH01z/xCskNVrzNZZZ6oEiPCODfFEfFF4REE8iKeOCMCKZebs+Rw+gv5NBQ+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8WyhDza; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8WyhDza"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-306f36df4feso4255995eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 09 Jun 2026 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781070448; x=1781675248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Z30uT+bOXN6TOUiYfdIl4fW9SYTC2DUH0bcN3+Ecg=;
        b=Q8WyhDzah/EAe+pDWH6Qiq0fK09bOkPz5rmesQFt8j3KG7z6uA0u9f6RJl3cnrbDCE
         Aq7i6q1/WRz0h06zsbp3yF/JIsm3AvnVepRMc1VlMgAbxxtVfxGkmtd80gNKTZCcY7op
         3+Fzayf2HumirPNqLTZi7ge2oZXLZCJq5SZjzTykmUitViwMXvn7H15j1p+3zUV/skV3
         4y6s5Y63anGX39F9XhWET8qBW/zoXN/k2wPsxmf/DdVtuCoRRGMqtKATE4TtE5LJgFzU
         PBnfe2oOXWL8bHwuWUDpVyxDFjKHuyXNgAp+muVxH+z/AiPps6IIM5yQpCtHrEubk1cI
         VRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781070448; x=1781675248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4Z30uT+bOXN6TOUiYfdIl4fW9SYTC2DUH0bcN3+Ecg=;
        b=EwDzcIHY3T2uCAmQR/3koQW2Awt7Z3iNlnqBJvKyko3YG8/oDFmyqlzhiBwp+5u+3O
         vy0fTZ1Y0PvnH8odo7NMLsyTwjy9UyOko3UnZYBHSyS7p/eMUwvyd5gr3cKc2IQHz+Ht
         folb3stu0llh2Eb+nHdk+qIhGgcpEIKtLw+uMyLx+AQU4pNOimBfG37rChAklDWULhjn
         hlDj0lQnyz+b+c5wFaH6XRKyeqphX9huRb8dPNLJg+x16rXjVASYrDD0P/FKuyVoYd+T
         6Yuq+AcRtzDWsZQiHVX0uaBPY/o11Cs2z3vaHhV5yPU4hDhh2SGG6M/eCuPzDWMbUgio
         TmUQ==
X-Gm-Message-State: AOJu0YyPMryEEFkX8UEOEzuq5Yez7yGnujBmm2B5prEnSaQrbvipDiMN
	3lOCq1jyRPWFQ9DfazbWEd6eZlSNeNe7L2oc/hB1RULigMYsxkNxA/ltLJ2HJYFL
X-Gm-Gg: Acq92OFLR1u92jSxbUNHJhjS+lWjbo07tsrT2NVehx6/zGZ3t2sAVqwRR2vaaQogbQP
	Ylor2O8RZQeO7fZrwX/JftyoDKl987E/uEYXgsXyUagxMgDzqPG+5j0dDXG2oYHIjkdHr8xAObX
	POclunHflmeMWebxpYsNh9n5hvKtUYPWv0ok1xHAfar77HzUCUR0lyWp1NSRgPifm1GKHaJoEqB
	IISDhYe0RNNRC0r2AcMH3K9qMYRsSMfO4Dy5OtiOsrJDHMD3XY1aw8BbYfteVetinK7AbW8JhxT
	zjBK2mNyf0CvkrgDl4rhCfv7DpUHAlDvaBSFo1UzJUZX06YAm3nO2moXBlY5WBe4M34CjRmbeBK
	pzwSu49KnBpe+UsiBvIolRTw8rdUHs66cPKLmvh99ZXuSshaeqE90zm6BRb30h/BQ9VG20SuISj
	eET19f0nnPOBfnHGXTgFYLsXNxxO65L2xjCCbwHko0EpzV9lj6tEsNA8yvEDrCw8JayZ9Gpryd5
	koUWvb5ytTHl+k6SfP/t84s6NVm5G+M85DS+fYFJyx/s6R7drh24EvE2ZsPRB4Q+bT2OUnOuyDf
	/YfEB30Cn3ISWW6qSX21DUFs1AvU
X-Received: by 2002:a05:7301:46a0:b0:302:8cb5:af0b with SMTP id 5a478bee46e88-3077ffb3c08mr8023810eec.13.1781070447509;
        Tue, 09 Jun 2026 22:47:27 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm29680866eec.3.2026.06.09.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 22:47:27 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: ds1307: update reference to removed CONFIG_RTC_DRV_DS1307_HWMON
Date: Tue,  9 Jun 2026 22:47:22 -0700
Message-ID: <20260610054723.261008-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_RTC_DRV_DS1307_HWMON macro was removed in favor of
CONFIG_HWMON in commit 6b583a64fd1e ("rtc: ds1307: simplify hwmon
config"), but a reference to it remained in a comment. Correct this
reference.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 7205c59ff729..6dce01e3373a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1409,7 +1409,7 @@ static void ds1307_hwmon_register(struct ds1307 *ds1307)
 {
 }
 
-#endif /* CONFIG_RTC_DRV_DS1307_HWMON */
+#endif /* IS_REACHABLE(CONFIG_HWMON) */
 
 /*----------------------------------------------------------------------*/
 
-- 
2.43.0

