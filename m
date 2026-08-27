Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099831ABEDE;
	Thu, 27 Aug 2026 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795723; cv=none; b=oLaYpQ5Ng9Pa7/vj6j7KSk7RybXkOGdccuW9Djo9F+d88d85ppJ/qxfEntSWxvn2JmLN76eBDU74UQfq2saAo1nljTP/u4Xpnyx7Yv2qOj/57Kaq8vKGXaUVnHFJfhRQr15f72VkEFA09RhFmJrzW6efFIT6sIxFjqKkgqUgvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795723; c=relaxed/simple;
	bh=+vSiDmfesHteRofWu9YnnJphCrUSSUwaHMRRfgYOmTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOjTo7jWS7Ap8M7BopAgi8ebROijMKmEQwucZqeqdZ+CMpwgsosmr+b9cyaQ/ATXNLhiQTPBVQ+2f2zA4I2FrXRYMrcSbCwaQbWEsn2CuPqaFs2CQZpcGrIlx9uw+ywZqiZNjq1Uh+3kueWaMaSC90nAkwzqDXwxsMJVAyaxvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz4t1787795693t5ca7b669
X-QQ-Originating-IP: oycE74GwGx4odGFUwygfHSfIm2zwZaPcCTkmglsnPSs=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 09:54:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4192742800306822609
EX-QQ-RecipientCnt: 7
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH] rtc: dev: zero-initialize struct rtc_wkalrm to prevent information leak
Date: Thu, 27 Aug 2026 09:54:44 +0800
Message-ID: <B28B7DE18F3A9447+20260827015444.3314227-1-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MDGUoPnBmw7sh4jokFVIlVI5f0X6NI/omEJGwdQWURBo6uLB+0pVJtI0
	t+Jmyy6h2XOXsP5XrrbFGC59Cylb9vCjliVAqqn1dOAlIvlRDKBFqtKu3qhLMtLYUz/hN76
	kheBlpQvpPdYexsHSJ8c4ihO0xqROGpGeu/MI0JEnmCfxKvmWmrwvGzBawro+xh1LTyJjJY
	lVDpycu4iniAiF046Mt1NKWMAjiyPqUgNPzseSuMuREki4gYp/6pxxRWnzGwlruorjN9Kzo
	RgQV8Kd7ZZKcWJRex2g4RhydQ9c1IKFCA9N0FKQG9vQ2sfCU/jZ5RwGdbP2j/tEvrGnfONP
	vYzCFWUjKSV6i/GjYyTwDbU/naItGob/+MJgNjzpDjwlDus527Ckexh4NAV0y7UFFjZSZYq
	EJc87NztSyVfuwGqRx/pRVwH103j2l08WM5dHmNfhO02nkmyC/gWwdddjegUIaREcwnDP91
	q48KYF07+hevrar0udPsFKjg8tmp1jzPzQGdOHYZXFuDXuQt92U6hvmWzxnZBA0AiwrfDb4
	R8W0hR27KzzccYqotpQ/SM3D70IWRkR5YlrfOWyFlf8Z8qjRYt0PvsYNYTrc/iKHIjRd2Zu
	6yrChjfUO7HAld7AB/7r7bmr/+yOk1kUqE3DZt5Ed3cZtvMHjNTNQqE9BNvjcslFv7FmNPQ
	e/iFRvjJfTu9W/8JUCQuTHVaqz/7pYyMy+I05fQto2JkTdihKUe2YcMhvzxf/1yESPeJjCp
	YdqhU2lXSdZWcbUQT+bnJk9NpHMTerd0JPl8vJO0xBaFgFH46tXz55liieCbIvvIX/ECgw/
	Ct7BvfHhOTI9cXSFWbTH9Zj7j/5gHeIKmr/KbT+cE3Py3gdr2pIaNrRRus8IiZdcvQvkrno
	OnIkBD1vF/bPDow8bel1Wy37lEN+WVJWGs8VSb/K5Ls6Tr9ZdEuuuxGWWrpTikWthexjGi8
	CjCsyOs5Up9Rvp1cROehcLbImejg8iTErazYGTECLWp1VDZlM0ZtN2WKd/K/YtttIJkk69U
	Mop8FMJ+AJ2fDc+RYzXgjFN6Wt4GBxsOY3NbVrPA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The struct rtc_wkalrm has padding holes after the 'pending' member.
When returned to userspace via the RTC_WKALRM_RD ioctl, uninitialized
kernel stack data residing in these holes may be leaked.

Zero-initialize the struct at declaration to eliminate this information
leak risk.

Fixes smatch warnings:
- drivers/rtc/dev.c:392 rtc_dev_ioctl() warn: check that 'alarm' doesn't
  leak information (struct has a hole after 'pending')

Fixes: 36e14f5fdfdf ("rtc: rename core files")
Assisted-by: smatch:2.0 [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 8ba7c25d2565..be173c9511fa 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -216,7 +216,7 @@ static long rtc_dev_ioctl(struct file *file,
 	struct rtc_device *rtc = file->private_data;
 	const struct rtc_class_ops *ops = rtc->ops;
 	struct rtc_time tm;
-	struct rtc_wkalrm alarm;
+	struct rtc_wkalrm alarm = { 0 };
 	struct rtc_param param;
 	void __user *uarg = (void __user *)arg;
 
-- 
2.43.0

