Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97F3659FD;
	Thu, 27 Aug 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812310; cv=none; b=TgIJW32baVCxBB1Nf1R4NEOWRwyT6rSN0OjroSfhhOXShjg7GQfuM6EBiL8dqBHem9bmZ8Q1bBVI8vV+YUf8oz8DaSc6coy3v6Gwc+7rW1Q3V+EHp4MXJX/k0VpsCN1FnXZlaTeN1URHFECNiU++x3ikY2MJDvcj9knb12HvOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812310; c=relaxed/simple;
	bh=RCH0/4E+ybPOMoKfy7Gtrb7P4jrw0rsJxxBlf5cdD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXKjoUWHMWHdn/EZSKGevUGhHVSWm5Yrc+D5ChGPftawtWJvbircj0CIqhjqn3dZmdk04uuTGHzHHQnITPxlLoBnHqBf5rskGCojFi4X9AAiyutp0yMiCp01i4XPdhQQ7AHY56R1AJbMiTrOD3EdNYXf4cnH8cs211VWA9fvd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz20t1787812256tb4f00064
X-QQ-Originating-IP: 82KkePapeeneOtk0IMx8EA6E5nujxXT5q/ttGDpvGkE=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 14:30:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1738464052093361708
EX-QQ-RecipientCnt: 10
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH v1 3/3] rtc: ftrtc010: fix integer overflow in time calculation
Date: Thu, 27 Aug 2026 14:30:19 +0800
Message-ID: <B06A3E7BF268E081+20260827063019.3342085-4-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MC+jTyq9xFiavOkJydzmFxGopX3cNGRIoDYvJmoAyBZlS6YgA/qvVlpw
	sdCU6/KJdrwazq/XRsagvq7v5QyOYSlQtahojb6AUG9cMVzZHYl9SC/pgmNMl/vHfW3JqrE
	suEyvXH/qydnTg1pGdLlmeID6rgL9zzFZktToDNS4IDg6GtmS2n+uEAZFCSGhVd4nX7DHrC
	YvsThm/j5LZa3jIjHIhVVbJJmlcpp1J1X94kxjVCIdWyCbKBbTei1vvgLHzCoVNMvGPUQDP
	IQoLRThkvFuEvXNsx0sY5C4krHjGXQRJ+/Rg1bHzryfHW06LnoETDWcx8y53CUGUL12cFGm
	74PQeTYBSkj5SV87OzuUxnJMG4nz3N2fxVk7o34iuF6z58OC9gveB/gHtDNE3+/033q2WBj
	syiwP0dANqul6OiZ4YX/JNx4yIGyDAqMBBNjyKGGKfXUN8ULf6tMKaLJYQ3nKa34ia1PB1w
	73RWnu59H8Pr9Tj7toTAyOkbJDi1k69SkWQcVKuZRu45/1Se3SqjUbQRSgoVNAe7LFTWw4L
	wQ9Vniz4KKesXM/uIRluhEN/yv3VrUUoU6EyUpYdhk4J39kvjwqGLsgZJZ/ihC0bEVl3LBZ
	aYf9ZcUtwaOC6E3YN9VhlYsGWbCdsff1EKamDipltukjInspsQf/G3zItmpmcsXCZBG9hkO
	8bep+Milbf4AhGxvtlhSrp5MdkrnemZQKs+wvbgTpw7E/hN6jEqSfs/UNEabXok6+HOR1th
	q3Hz2TOHN+RxTctgj3qWtsqdyiGE7fl/B5ylxwpBm1a/azf7S3M4BecOdOSkQ0GF2D0ik/q
	o9JBGWV/pCN1TB34HJpHOvKHIU89gl4Ovlf3Zomzt78feWHHZaWi0sB271mIoKhePqHsItW
	zvJaPVLERp622Uc+46+EzYWasX4TOd2qUbqTI/9KWYzUTfqXo0wIhSh35GYIWVLINzWv9RR
	yBaqKRRkkQMXySQzfCL15vfQUjGsLGxi6AqRX26FbF7bIZ2zzDhEaEcFTaufSe7Wr+OEpLv
	QYn+ybT1yOcwePM+eF4hXCKdyosCZniF7uCK3kWnHR9mX21tzEP7iBF8CHAthjtwjgHTB6i
	/igb3uBwG996yZyLuDX1KJxuXfQKejdn0bYV4xF3ODp
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

In ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time(), all
variables (offset, days, hour, min, sec) are u32. The expression
"days * 86400 + hour * 3600 + min * 60 + sec" is evaluated in
32-bit arithmetic, which silently wraps around for dates beyond
approximately year 2106 (U32_MAX / 86400 ≈ 49710 days).

Cast the u32 operands to timeu64_t before multiplication to ensure
the arithmetic is performed in 64-bit, preventing overflow and
matching the driver's rtc_dev->range_max configuration.

Fixes: 1d61d2592c1f ("rtc: ftrtc010: Rename to Faraday FTRTC010")
Assisted-by: Sashiko AI [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/rtc-ftrtc010.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 19e6333bfbab..8f2652132400 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -72,7 +72,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
 
-	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
+	time = (timeu64_t)offset + (timeu64_t)days * 86400 +
+	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + sec;
 
 	rtc_time64_to_tm(time, tm);
 
@@ -92,7 +93,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
 	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
-	offset = time - (day * 86400 + hour * 3600 + min * 60 + sec);
+	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
+			 (timeu64_t)min * 60 + sec);
 
 	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
 	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
-- 
2.43.0

