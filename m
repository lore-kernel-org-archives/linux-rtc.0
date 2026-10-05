Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5D36A342;
	Mon,  5 Oct 2026 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198421; cv=none; b=f9cmF4UR5d+muY3IE1IcHevsgKr0VcxZX3WXvEEv3Pvw+XPA0c53cpg/Erl63lcIA/axzKnlMGffjBd566Pb/VdJHwiukugBkKgksYPduwJ6QkeUuEAyvRT6Qk9VcNkiws+2vyxfjU+odRCgVMHlP6w584/qbbORe/eow9zIj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198421; c=relaxed/simple;
	bh=p4kwr6/czL7IDjJjVwIip9/nH/NY0jxDS30CoWJV7DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akrW8shERcyjrn8e9PYHkF6Wn/xgroOvOMOK7AWc63NYVK1p8MQ5lVUksMZ/9RHOBqelpG0/hidOUgayXZ//tQQ95F4Nf/12fcFmfJoZjrFABKNPY5hTygpCG2GccoKv2sppL0Bw+5HX/nC3AJMhM79+FvBfgWDUhaVyK7RkuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wvRly7Fd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wvRly7Fd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 000B91A1165;
	Mon,  5 Oct 2026 11:06:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B24A0604FE;
	Mon,  5 Oct 2026 11:06:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E28E1103306F6;
	Mon,  5 Oct 2026 13:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791198409; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=RXTcGIh1GIa5MvGd8v4blk9lxYWyhyiXSKLxHHGBdAc=;
	b=wvRly7FdIZWbU9n/9R5coztTXPA22gW0b2ROqePniiOFhU0HM62PP8UN6nRppRHc0u8WfQ
	w0seR/VPdYCWu57lM8RaLuRCHmjmMmecVLrOG02keo89iqY9zeihHWMFMs0eDyiC3M66e6
	qkY8/4faWVOFyhmzCkgIo3Vr+LknDDwuE5jouglJWB//aHMFe9VBhzZX3BXSu+7h5vtk9Z
	BkoGIdRI1DiokQY7k/sRJAdrzudCIZ7k0CQ+N8UTwZigXjbLq6GrsREDUBMCGwH+apgGn8
	pwXl1QeS8V9r5kwb7rQ+529Gq1K8vCnVmj+rRrsW6arcQUJ0kus+uWXiAwU1tg==
From: alexandre.belloni@bootlin.com
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Dan Carpenter <error27@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ftrtc010: fix cast
Date: Mon,  5 Oct 2026 13:06:37 +0200
Message-ID: <20261005110638.156559-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The hour and minute registers will rollover before the multiplication to
convert to a number of seconds can exceed an 32bit integer, there is no
need to cast them.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRoXi2kgq8FTSaDPA@z/
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ftrtc010.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index b29c96be40f4..5332451bdaa0 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
 
-	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
+	time = offset + (timeu64_t)days * 86400 + hour * 3600 + min * 60 + sec;
 
 	rtc_time64_to_tm(time, tm);
 
@@ -92,8 +92,7 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
 	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
-	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
-			 (timeu64_t)min * 60 + (timeu64_t)sec);
+	offset = time - (timeu64_t)day * 86400 + hour * 3600 + min * 60 + sec;
 
 	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
 	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
-- 
2.55.0

