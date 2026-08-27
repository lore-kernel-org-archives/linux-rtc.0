Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAB37E5D2;
	Thu, 27 Aug 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795986; cv=none; b=tCM7ZXw2tdrnYT7/Oyv3szLWhMwVoU/Xvf37BKJiUGHojIrgKzib0W2TXw2p/Q+Ah9PvsWCrNNRzvBM6upXSjg6CUE6p8x/ZFJXlRcXBP8TrDGG6Ik1ca0j9BHZSTHz5pZ+SSYZEhjx8b+purlKAXJ2ckR+cRZXZNW4gOImff5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795986; c=relaxed/simple;
	bh=W+O/9mp9/JVLfiIW1PeiqEGnfXVHRJw2igOVhFhO3/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8IpNrOxKo1/+Qyze4JdInC4Mq6TXghul2omLYakDwu1mOUJaCJSFELQfRZ8P6a7bq0bR4zf6bu2sStLeFWk4JAlMxu1ZpOUzi34jVeOQ50M3o1R4POj7T8qWAuAQdzRP5bAqrZ7ezBckHy/WNjfUBay+U6Vm19pd8WqfX8dMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz4t1787795934t5c0f49a3
X-QQ-Originating-IP: GEDFv4bB65Ecre4lm7YeLcp+hBVtXW059UN5qMBKV2Q=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 09:58:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10146101652417987667
EX-QQ-RecipientCnt: 7
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH] rtc: rs5c372: add missing error code for unknown RTC type
Date: Thu, 27 Aug 2026 09:58:46 +0800
Message-ID: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
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
X-QQ-XMAILINFO: Mm/Yx8ZY6QnDQ8bTqU6sCHwjNzRwWvFUvdFfOJ4a/ZriPc8z5APL82Ug
	fa62MYb1xjIkc7j0LUno67uK1m2Y6AxDP2dkf+bdcPpWBWEM7+XendQRSx7aNzQVY21bdfG
	KfjHrIYkjzbH9wwmPbEAzcdQxl1AT6SwFFOBJTgYoXMMFWoEt+tzgvwm+fyHqZLLex/Mxry
	fBULuTP+8nq0zWv+74EQ1P0gaqCNgT4+03IQqlpVoIZX5g6ssat6/Izuq8r2EpnJTKeom2T
	KWn/vxiDfU8S/QAYXmi96+sJ3SMUOhQrWGtYHYI0/ofbWSy/RWKf2WzhhqWNo408jXGqXVs
	b1Ytgpr8fl1rKPlGfBoP1H7s/FBZsAl8ykSNeadUpjzpXY5Ilaotd4iN06bZUlTu9Qz4IIz
	BN/ZcTYqYbwcCQ8zgBFFL5wawbiCH97YzkLIw67GcYskq2TlkOunaKn5c1NHEe6nJdWYlor
	aCtHXTPNyTaU+RH1nD6gONCL280YWi8cdWbCOL8G0BZEAbYlDkAP9gVwfaHIdI75wU9yKUA
	5TNaj2jwLAb7GQiba+D58b0PHBT5YVn9n7j7TFrckmNyX9G7onpzX9xJp9eQzN9/y7Fzt2K
	ks306fZd9o2AGXSBCymuLa/GNlWWRTwBRpv9eZqglUp1gH0wCA27y6Fvnm2zHDD20LTZhQc
	V+iUD+OsDDN0rtxVC29UAUf8svybN35ap35N7IVGu02cMBSwfDu4d9IQFJ/1HhAFg07bqsy
	fAEXPEKUuXFCRAVFRk+2jOYbm/AzOTDJEEpxcpEo8hvhkKYLEDH0buIO63awTyAHY+3wNII
	WYwUKTRavhftubgsSvjRY+hkC1/Ds3m3GwOHGt8LQgjCFt4qxH/yJrIt0Jh/A5P3zLT9h8s
	lFHW3v6SiCW736Ao9pEu6x6NlpgFyXsipTbZ61s5gmfgW7jj1TPjhk4eRaWPRQsAqfVO8XL
	uRs4tRQKSUJjVaYBQMHP6YsC7cQ3HXKNCC65f2jJeGtZ2Z4Ldd6RbjWTyWWdPpdTEU1hZKe
	70va0ZKXfFU7/dG84e495J4OHJsyLT41DEmVudnSV88imNd3Fa3ZodopZZZ4U+IkPxcBIZH
	Hobz/Kl3a3QJOMu9ykvCHE3pp6itj+pxw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

In rs5c372_probe(), when an unknown RTC type is encountered in the
switch default case, the local variable 'err' is still 0 from its
initialization. The subsequent goto to the exit label then returns
success, even though probe has failed.

Set err = -ENODEV before jumping to exit to properly report the
failure to the caller.

Fixes smatch warnings:
- drivers/rtc/rtc-rs5c372.c:860 rs5c372_probe() warn: missing error
  code 'err'

Fixes: cb26b572dc394 ("[PATCH] Update the rtc-rs5c372 driver")
Assisted-by: smatch:2.0 [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/rtc-rs5c372.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 24bd795d9d95..84407119caba 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -857,6 +857,7 @@ static int rs5c372_probe(struct i2c_client *client)
 		break;
 	default:
 		dev_err(&client->dev, "unknown RTC type\n");
+		err = -ENODEV;
 		goto exit;
 	}
 
-- 
2.43.0

