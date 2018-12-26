Return-Path: <SRS0=XqKi=PD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF6C43387
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116F214D8
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 02:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FOTHh5e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeLZCoC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:44:02 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38350 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLZCoB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 25 Dec 2018 21:44:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A5E6F5BF
        for <linux-rtc@vger.kernel.org>; Wed, 26 Dec 2018 02:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8xvM6Ojtqp1w for <linux-rtc@vger.kernel.org>;
        Tue, 25 Dec 2018 20:44:00 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 769515B1
        for <linux-rtc@vger.kernel.org>; Tue, 25 Dec 2018 20:44:00 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id q23so18032802ior.6
        for <linux-rtc@vger.kernel.org>; Tue, 25 Dec 2018 18:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gkg7uHvncdT2WNv9hvr6ppmnMbQBq4T0rfrlJwBoncc=;
        b=FOTHh5e4n/SNN7xcY5M77el+DNyPSNzxNcuT1l1BiEerKLqlnaq9tJeCfF2p1wMXpk
         y0Mg76DMg2Q06Cg3n5l4cQg+HIg5X7O7LEGMeltfi6geNAiasuEtlqrGcXCGzb0aID2v
         JmrqYKpGSvtFM+Y42CMzqkrODFSCdSZXml3rpGfiQKhdPczF3mUK7TwpyrexuppP43Bu
         gQBpWluHbhj/t+9f567WXOagk4YtxtJl8Aprs89g1q8fYI8V0KQ78GOaeFmTnKNnbOOh
         H/NxWuZcQmafc9ZNqbGEhD6iAF3qnHNlmjwsfFjGehN0Go3xXOYimfQq1pcAVFcVfe7/
         IgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gkg7uHvncdT2WNv9hvr6ppmnMbQBq4T0rfrlJwBoncc=;
        b=LRFadMtH5RLSjx+e4wbzxeIyFKss/2HujaMCe4DyBJcDcSJinI9YSavoj/aePIrpFU
         Ll+Q5ljsSImHbSSUAk8zraINVacSF4lcxpoZuWWAKiJ+Neb20g0YF403HNOKaWof+fAp
         E+rjjcZ1//Bpi39zxG9CJjV5mwc5SJjfXF9xqAU8tQvFnNouVe3ZsFoFQCoN1rUXGBUt
         YN2zbLUMDZmK/tmx0RskRx3nVLTnpYvXNxCK4vTJrxoT/XFdsgX6qT7OON77UoqZUu7L
         Stfp1u1EJ6c+KNgyNpuGDa6916VoJKpIgom3CGZoozsxjk6yyHykDEFeaIRI39Jp+lKT
         5dFQ==
X-Gm-Message-State: AA+aEWZHjFmrVzNqauIZy4yIoMfyK0WozLK8FL64whZw89WjWR3Jrmlc
        QAm/DTFtorE1J8GLdhZoiy0pxjdMx/DAGp/CgqFvWbHthwag36swDZ8QOqUzq0obt3mSjQVo+Fk
        OlTTQtBVj5iZnUivSnFCqPyqJ
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr12029130jak.49.1545792240046;
        Tue, 25 Dec 2018 18:44:00 -0800 (PST)
X-Google-Smtp-Source: AFSGD/U1RPn8FcC66zod/Zxjt8q/PyRqLZOnsnaOfpwiLxAooO7GoL5DWkhUlGa6IITWGFnb9pdCSA==
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr12029124jak.49.1545792239820;
        Tue, 25 Dec 2018 18:43:59 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id q1sm709491ion.45.2018.12.25.18.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:43:58 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:43:33 -0600
Message-Id: <20181226024333.72236-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

clk_prepare() could fail, so let's check its status and if it fails
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rtc/rtc-coh901331.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index fc5cf5c44ae7..0b232c84f674 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -235,9 +235,13 @@ static int coh901331_suspend(struct device *dev)
 
 static int coh901331_resume(struct device *dev)
 {
+	int ret;
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
-	clk_prepare(rtap->clk);
+	ret = clk_prepare(rtap->clk);
+	if (ret)
+		return ret;
+
 	if (device_may_wakeup(dev)) {
 		disable_irq_wake(rtap->irq);
 	} else {
-- 
2.17.2 (Apple Git-113)

