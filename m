Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345F37EFE7
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333759; cv=none; b=cIWyP6A0Fg1kkWC0+ECWCVD9y6+Byg/N7b03B5bPzQmb45YC/Gvdmr/blr7nKlrnqGOGqVq8jp0t9pNPHAHJ8Eru2djqhxQ+KYD27tvLQE1xV47PDKeEsEPWV+KFvfit0r6UiMiH38QRlDTcu1NMzXdsyUoe/x/jhbYZs4QEvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333759; c=relaxed/simple;
	bh=eV3RLdwrYpvnRxpaT7ykifbtaMmBU4By71Qjae+DnaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbgbXaCj5ydx1DBLPbqbggdbgVqrWrbfLnJVaQIK7CAjX+cln31G3WhTtptvJ/pJYpHDfO/CXcv61L3ItdgWFhCCtpgwVQtd79w4U5X9gIs09RNZtvVAu7D11Srqy/Gz3gLHmuYgQ5DicqlzpnQN+zJo7BIhN6ElmQFg5L009T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GGRZPFGt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GGRZPFGt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 148D5C6B3B8
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 20:42:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8C05601C5;
	Wed, 24 Jun 2026 20:42:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABD0C106C8077;
	Wed, 24 Jun 2026 22:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782333748; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=56nkf3YR2UqkxmwO0BUlPlKpHtNTQ2Vrg6oNoaamskY=;
	b=GGRZPFGtgRS+cmtDWbmI6iiBKdzcjHA1dwZ2ow7OLIj5D7hoCI6NWTnWw4NVa9gXjB8eTl
	KD/C24XZtnKE++JnQh2jz4Bz/7RgHgzKeFUZSLo3Dpwz8tHR1yCZ1KCM2gKORQ0HVMGvKr
	spWmxwrpzClWSQx693YBlpEFugABz+mqFjBRKz/8aNDveAdF+1cnhWJXRcXarV3qQWYSlc
	FMGdMU1D/J/2MyCNhRCBfh4+hyhp36B/xmkJmijXzaJV9vavW5aTuHGtNbPqYB2fnJabxI
	KthtbcKF20xnsaSf/H+fkf1xnHrgOylA9mE7UJOhb8P8usVt7QDxslVEtvSIZQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: s35390a: fix typo in comment
Date: Wed, 24 Jun 2026 22:42:22 +0200
Message-ID: <20260624204223.1479003-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Fix trivial typo

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 31394f34fb70..b72eef4fb099 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -297,7 +297,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	else
 		sts = S35390A_INT2_MODE_NOINTR;
 
-	/* set interupt mode*/
+	/* set interrupt mode*/
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
-- 
2.54.0

