Return-Path: <SRS0=HQnH=EM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167AC2D0A3
	for <linux-rtc@archiver.kernel.org>; Fri,  6 Nov 2020 07:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96428204EA
	for <linux-rtc@archiver.kernel.org>; Fri,  6 Nov 2020 07:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4JMvlIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFHbA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 6 Nov 2020 02:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHbA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 6 Nov 2020 02:31:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C8C0613CF;
        Thu,  5 Nov 2020 23:30:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so499074pfn.12;
        Thu, 05 Nov 2020 23:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PjmfGm4EXurKjtMQzJKg85PMtWxg6au6fvWpF4KZFQ0=;
        b=k4JMvlIFGEdDNueJ49Y+2ob3zUipwp/qt9WNR78Oe/B51Jn1xMOPEQNfpx9mtrAsJv
         xqOU+OfapRBwkkpwbF6wnrROHmyP6SC0T5CEMxCcOuogL3qaji63QJBNilt2LOuhEASO
         5CNP4W5GA+JiY5K8kFoZHIIx5+1NRz+Fl3p+ByHMyN49PdTJgcTme721qlmiOBuEozmY
         Drv3OBfUhxXuW+lMJSuNyJiytCPzTpH1FKgrpZa3moSyr2DB0MSs13r7ansesTEhlLJv
         9WrzCKCCD9QNNoml0e0WFrDwKhD4dF4zNOx11yT3oGw2Hw0pTwhNeworsUZ+6USSBDa8
         YwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PjmfGm4EXurKjtMQzJKg85PMtWxg6au6fvWpF4KZFQ0=;
        b=izZW6hbdFUWDIKWFGc0uiQB6kEu/TWetK7vDykcOmFBbq2n6ybytdltFD0aOM0iLtb
         eif5WitJg+c3nbxMRJ4BjbCeV+PeuK/a4blzZd4RKvyXA4OXgxq0RkEJCIdWo2ilq2Nr
         rmeMmlJxC1d6LAn/WHjoZE2nUPgL46ZleI45RwyxKaLnnCg5VqGPdm8SDUqjQDvepU6O
         xeepaB1TyM/OdEtMdloSgJhtg8yMBoSE+Avc9MAcSpXG7LJo52UacgsesFZMEgJGmWS6
         js8w/Cfio5KSuSoEuuvn9vYqvTxTUwYIBfGVrkW3zQ6MHQBJ+7BipdP0q8atSD6GAmUp
         4OzA==
X-Gm-Message-State: AOAM530CDXhc6CsJbc0oqRK1HAYTd6cx1mKMaPUqqBfRH7hoGMCmYKlJ
        BM0KO7hHKrXisCh37ifydppmL5UDro4R
X-Google-Smtp-Source: ABdhPJzSyINIgRGoei5f7v8jixOWwh21HKdF3nGUmlNuqGJSOxo3tZ/+OsAcY0fcIbQs0ndJkiPCog==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr1066156pja.189.1604647859498;
        Thu, 05 Nov 2020 23:30:59 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id d7sm722973pgh.17.2020.11.05.23.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:30:58 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] rtc: sc27xx: Remove unnecessary conversion to bool
Date:   Fri,  6 Nov 2020 15:30:54 +0800
Message-Id: <1604647854-876-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Here we could use the '!=' expression to fix the following coccicheck
warning:

./drivers/rtc/rtc-sc27xx.c:566:50-55: WARNING: conversion to bool not needed here

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/rtc/rtc-sc27xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 36810dd40cd3..6e65f68ea86d 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -563,7 +563,7 @@ static int sprd_rtc_check_power_down(struct sprd_rtc *rtc)
 	 * means the RTC has been powered down, so the RTC time values are
 	 * invalid.
 	 */
-	rtc->valid = val == SPRD_RTC_POWER_RESET_VALUE ? false : true;
+	rtc->valid = val != SPRD_RTC_POWER_RESET_VALUE;
 	return 0;
 }
 
-- 
2.20.0

