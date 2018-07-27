Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33969 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbeG0Qco (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 27 Jul 2018 12:32:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so4740145ljk.1
        for <linux-rtc@vger.kernel.org>; Fri, 27 Jul 2018 08:10:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rtc: sh: remove unused variable rtc_dev
Date: Fri, 27 Jul 2018 17:10:15 +0200
Message-Id: <20180727151015.3930-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

When building rtc-sh, rtc_dev isn't used in function __sh_rtc_periodic.
drivers/rtc/rtc-sh.c: In function ‘__sh_rtc_periodic’:
drivers/rtc/rtc-sh.c:146:21: warning: unused variable ‘rtc_dev’ [-Wunused-variable]
  struct rtc_device *rtc_dev = rtc->rtc_dev;
                     ^~~~~~~
Remove the declaration of rtc_dev to dispose the warning.

Fixes: ec623ff014c4 ("rtc: sh: remove dead code")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/rtc/rtc-sh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 25ec6a937858..51ba414798a8 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -143,7 +143,6 @@ static int __sh_rtc_alarm(struct sh_rtc *rtc)
 
 static int __sh_rtc_periodic(struct sh_rtc *rtc)
 {
-	struct rtc_device *rtc_dev = rtc->rtc_dev;
 	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR2);
-- 
2.18.0
