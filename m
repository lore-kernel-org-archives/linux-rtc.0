Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00244C4332F
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Apr 2022 07:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiDZHOZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Apr 2022 03:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbiDZHOK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Apr 2022 03:14:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B61A3B8
        for <linux-rtc@vger.kernel.org>; Tue, 26 Apr 2022 00:11:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1njFLg-0001g1-G2; Tue, 26 Apr 2022 09:11:00 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1njFLh-005IkX-3X; Tue, 26 Apr 2022 09:10:59 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1njFLe-004zAt-7w; Tue, 26 Apr 2022 09:10:58 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rtc@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/5] include/linux/bcd.h: provide bcd_is_valid() helper
Date:   Tue, 26 Apr 2022 09:10:55 +0200
Message-Id: <20220426071056.1187235-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426071056.1187235-1-s.hauer@pengutronix.de>
References: <20220426071056.1187235-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

bcd2bin(0x0A) happily returns 10, despite this being an invalid BCD
value. RTC drivers converting possibly corrupted BCD timestamps might
want to validate their input before calling bcd2bin().

Provide a macro to do so. Unlike bcd2bin and bin2bcd, out-of-line
versions are not implemented. Should the macro experience enough use,
this can be retrofitted.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 include/linux/bcd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bcd.h b/include/linux/bcd.h
index 118bea36d7d49..abbc8149178e6 100644
--- a/include/linux/bcd.h
+++ b/include/linux/bcd.h
@@ -14,8 +14,12 @@
 		const_bin2bcd(x) :			\
 		_bin2bcd(x))
 
+#define bcd_is_valid(x)					\
+		const_bcd_is_valid(x)
+
 #define const_bcd2bin(x)	(((x) & 0x0f) + ((x) >> 4) * 10)
 #define const_bin2bcd(x)	((((x) / 10) << 4) + (x) % 10)
+#define const_bcd_is_valid(x)	(((x) & 0x0f) < 10 && ((x) >> 4) < 10)
 
 unsigned _bcd2bin(unsigned char val) __attribute_const__;
 unsigned char _bin2bcd(unsigned val) __attribute_const__;
-- 
2.30.2

