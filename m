Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B89357CF8;
	Thu, 27 Aug 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812306; cv=none; b=VseEFO5C+n7dv7/Ecixtm/9pL422yDaHGI0ecTAytSxUDMRSv5YWj5uIt9DC/Tnn6Qg6Ur+cXDetXRNsovelnuGo31LSSGd/O1P6ojEhznqw3VuSGpLd907JBtvTcEklw9F4W3EOCTD7nAFRgk1G0zoqqVVOfa3MKUVLKxwFI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812306; c=relaxed/simple;
	bh=LoIxppfXfkAKK5goic8HLKwwdZaSM4Vo0F8gA33eUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaKLKIPRCTYMwknC/4QhxTrQKFowBZttl3FA7NYRPQ7DuXWPiJOAU1Sf2ySzV8y/M1kpffZsSy6Ep/MkKTcosJcKhyQcDU4pI8218vmWecVmzHm6g+dM+6kRsT2WclRqEyKLefAFdfMIaeWUMh9sXbBPcCfFs2IV72qSEdPBcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz20t1787812240tcdf2c45d
X-QQ-Originating-IP: 1DJtWNx3YhLenhIB0FYvT59Ray3IYrfdfdAfsbybCLQ=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 14:30:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3173617341218191905
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
Subject: [PATCH v1 1/3] rtc: ftrtc010: fix clock resource leak on probe failure
Date: Thu, 27 Aug 2026 14:30:17 +0800
Message-ID: <16D871E1646724FD+20260827063019.3342085-2-liudalin@kylinsec.com.cn>
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
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MiIS17MxlZUaSUXmqhs+oyd4Ya7cdXLy5uVOEZqu60WNmIskGOPozYZG
	ESqbBgqIxnejlaTaIG3LaXyR/iKrM8oEWtu5nkM1O9rbs+/r0EAN4Qlog859neHDsffg3N7
	+RKJQx8WvrMfz11eSd7tdrcbC5Sn9GFdMvdbvbWiIYVwBDaZY2516h2RnajDydbYTp9zNz6
	wg5IbdFZWdNBRD72W6PafQHfnJ0c4n5g47Rj2fANMp+qYCIJhqGchqAwa6HabMyAu8mxkb8
	BylwGpHSmDb2mIeua+/TsPETFuw6Z9oL2kQtsM1hdDuYLNYG/goSsYuPPgDawIOs84mp+Is
	tJyS+fB20pwh921aeXTrDHlGxuWhgwZ/ibv0XZw8idFFmQoZXPAZYnFngbwlUwT4yNylZAy
	LAUGgfwkKgdKPuyAVZ37ZfxTQyFH1+2ljVyGpNlQN/knCQZEhzu9RkX0jB5Vu/m+XPiXggQ
	yHOAq6vInBS+5lN8z+4uvMxqRiQ+lWy/DRJ79NRigsZ//fRAwF7MEHOP7iDA0IQbXtX7V9u
	8gz6q9nsrXZ5el9LsLBxbsTsIEvBbF+qGAfVNzQvXpVhkrjXK7KYJ8u8L8wfk5s+Oe8xYsI
	JzUSp94Q4g3SBfVmn7cQxsctrn+BW4vCIopvQY2lKLXyxwThUc0QfXgt4mQ83AGdJcizimL
	jCmIKwCWJ4NDAyNH9XBra7puPML9VTxXcG5EjNyem9KIm131EWW0wKAE2ng9Qudkp+g4XOq
	9DNs/fkmAO8ADsc8TGRslmY+cPGs8aqGAesOQpRTupz9VhbDb3CnV9mHIS3iy4KDK6m3Kpk
	lwYXTsZPuxY9vmEWNfllO0qxiyJdKplLgNBi+UXmHx/V5d5XMlg9asHDw9O+k3Oq4LDfD6Z
	emUFhr6rpdp49iq6fw9Jd1xNS7C0kAqc+WphPn3JpotMY1jDpKJ8+wJsr+dyAZAmGR1N4Y6
	pcKkuaDf3UZht4eLeNH91ggvDNyZo4u7R7jbL6Sc0JioO/SZ+0QbSW0Et+2RzDxHYvtXa1E
	hXwSieKVUiVZM87guuU55Onp1reYZhFxeyY7THHaSM9sRLTxq/u/1m2cSpz/UgqTq4ksev8
	m6hSJ9mOko8WjCARjT6DH38tIjorfhnKkpDWpCQyd3g6RGf0JVwzQtr15oxysraMg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

When devm_rtc_register_device() fails, ftrtc010_rtc_probe() returns
the error directly without releasing clocks obtained via
clk_prepare_enable(). This leaks both extclk and pclk resources,
which may prevent subsequent probe attempts or module removal.

Capture the return value and jump to the error handling path to
properly release clocks via clk_disable_unprepare().

Fixes smatch warnings:
- drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
  'rtc->extclk' from clk_prepare_enable() not released on lines: 183.
- drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
  'rtc->pclk' from clk_prepare_enable() not released on lines: 183.

Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource management")
Assisted-by: smatch:2.0 [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/rtc-ftrtc010.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 98fa0f518303..512790bc3f2b 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -180,7 +180,11 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	if (unlikely(ret))
 		goto err_disable_extclk;
 
-	return devm_rtc_register_device(rtc_dev);
+	ret = devm_rtc_register_device(rtc_dev);
+	if (ret)
+		goto err_disable_extclk;
+
+	return 0;
 
 err_disable_extclk:
 	clk_disable_unprepare(rtc->extclk);
-- 
2.43.0

