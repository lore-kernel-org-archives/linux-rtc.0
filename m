Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EA3B9DA6;
	Thu, 27 Aug 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817878; cv=none; b=s/iJc7l5ekgzWx3JdtpEYeqQI4pYSBlfCU2NI5FUUtPhH6mYrR437G5hNrzNQN1pc5eM9LOnMoTMTU+1l7c2nPJsdgpUz2swuV/S4fDNW5FkQrkJqqRd+BL47/9c8iw4iVMkq0mlQWsWsSSCPazKpZnG4PVVg+R9I6r1lO4XitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817878; c=relaxed/simple;
	bh=LoIxppfXfkAKK5goic8HLKwwdZaSM4Vo0F8gA33eUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iysBGPg+xuSuNX84jL8SxD11+BAvWeTNOioVb0DvvWTwG/vJIAL6S508fy3LHz7RPMskeTullBaZP/MN20eQu5hd3ldoOKhQNsupRZJKr6L5jAVGdGQiC+GXwIcLWrpG1w/M762/QoXRerj/g2u5QwKsiXwZtGW5dEtHkL+e7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz1t1787817814td7d3a987
X-QQ-Originating-IP: Ptz95ERRE1amiAopFHAgp8ZWVU4j35InjTBb5Bw/64Y=
Received: from rd.. ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:03:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8574756199102774927
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
Subject: [PATCH v2 1/3] rtc: ftrtc010: fix clock resource leak on probe failure
Date: Thu, 27 Aug 2026 16:03:18 +0800
Message-ID: <AC51B5F2C5FFEBB0+20260827080320.3351155-2-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NU2MhohCfzQFvFdngKdCegQT0pbsta6x5dL1Qo+PQhu77RcNOQbVsji0
	0jfCNGZQ5pOMrljtn6g7G4gpbp86/dbFc3c/OgdRFp/mZ5noOoQ1b0fk/eGfQHEvtFF84oe
	6eGlOxjQDwD79BOz/lPTduWKYqmb0lMtkLo8a2LDd3Njpqt3fmPB2hQLAcxYEXNUlx+KfE7
	Ans4tazqAqXlDYrdqFnDjXR1xmaPxtWPLUMofB+k20AvxLjxcldgiuRXDFoiK0wDZ1WbU6D
	YxIVe8cat+r2ezyvuarbyEjv3SwKEA6zgpuxL6QXv+9TwyEdz292X57xtHwB0hOhRNVYZ+j
	f4AnmzMWT1kCtI5xTMy54NujmZT7EJDzvHdNvqNURCBwMuV8IH8wUdZTIpiuXvpIuSDAlK9
	aCYLD92YZz0wDe0ch/h2Zu4p5BiUFH88+CgGB6yujiLwzH5OeqR/qMiY15hTuP0DJS3gGiB
	eTperLSSJLHfC+26Kns0FsVg/M7Qt1tFZCvrRZGDg5b1PEdBcJwS05vgKSYbE+IxNgGgQke
	EnLSx0KsHC4qEJ25w3Cc00v8IIN8Z2fUAK25S3qX3jVGfQiyV+4lCszzLJn/y38yWDch3UH
	homWxIPHBdVDvpYMJmw2OuqCP61Y53kPMSjxtkB+R4X27PmUs/KHwI9t7JBeohtHUjiDp1d
	GDO1xtEtPywXiMDvx9OuE22WbhB5YEAtXrdnRP4cwKNXNP7p/0sbIlYfvKrmbfEIU8bI4Fz
	TI+YQwOjhyqkg7ygxJKmtUaM0i7hC6unYedD+b0w7J73I0ZB1a7NHqWh7BeyjU9i/Zy0Fbr
	lP4KrkBs3f+r9qspkzdoS1zcZ7dFZl+/S2/MWjyolf2MPmQnF/pWLxqr7Wunb+IZzRkkxB0
	OKQTUU5C0mYV7CZqujaJZD/xmCtK66gj0ytejAYXnwUcu66E89VCFiem9U5s+n6GrUX0TQT
	txz9Blyfh28WH8WlGqIqJK5Q9WixZZ3jAI+MqRle3QvvDdijhsfdwZeuW0h01w2r1REtmtU
	S5bjmSDR8cctI8jNVZPnSfO6GnyRlm07lUGei1cK8ulQI6rlAGya6UUYW5aB491hATnuZU0
	KU42KwLt0GW294sWnhRK26RvRYahVh6NYQ7aa1AkguGMWvfIipuTCB0Ei1Pwfe+h1qpYfOA
	328KVkXo2j9Fe70=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

