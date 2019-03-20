Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEFCC10F05
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 10:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D202184D
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 10:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfCTKcT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:32:19 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:47460 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCTKcT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 06:32:19 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id qAYG1z00R3XaVaC01AYG5N; Wed, 20 Mar 2019 11:32:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h6YW8-0005Io-S8; Wed, 20 Mar 2019 11:32:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h6YW8-0005Jg-Qc; Wed, 20 Mar 2019 11:32:16 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] rtc: sh: Fix invalid alarm warning for non-enabled alarm
Date:   Wed, 20 Mar 2019 11:32:14 +0100
Message-Id: <20190320103214.20394-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When no alarm has been programmed on RSK-RZA1, an error message is
printed during boot:

    rtc rtc0: invalid alarm value: 2019-03-14T255:255:255

sh_rtc_read_alarm_value() returns 0xff when querying a hardware alarm
field that is not enabled.  __rtc_read_alarm() validates the received
alarm values, and fills in missing fields when needed.
While 0xff is handled fine for the year, month, and day fields, and
corrected as considered being out-of-range, this is not the case for the
hour, minute, and second fields, where -1 is expected for missing
fields.

Fix this by returning -1 instead, as this value is handled fine for all
fields.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/rtc/rtc-sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index d417b203cbc553eb..1d3de2a3d1a4d7a0 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -374,7 +374,7 @@ static int sh_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static inline int sh_rtc_read_alarm_value(struct sh_rtc *rtc, int reg_off)
 {
 	unsigned int byte;
-	int value = 0xff;	/* return 0xff for ignored values */
+	int value = -1;			/* return -1 for ignored values */
 
 	byte = readb(rtc->regbase + reg_off);
 	if (byte & AR_ENB) {
-- 
2.17.1

