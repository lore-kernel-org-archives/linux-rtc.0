Return-Path: <SRS0=XqKi=PD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A00AC43444
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 03:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9C02070D
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Dec 2018 03:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WJJGdwN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLZDJo (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:09:44 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45918 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZDJk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 25 Dec 2018 22:09:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 8096C6D8
        for <linux-rtc@vger.kernel.org>; Wed, 26 Dec 2018 03:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WO14S0jNyg-V for <linux-rtc@vger.kernel.org>;
        Tue, 25 Dec 2018 21:09:38 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 51A135AF
        for <linux-rtc@vger.kernel.org>; Tue, 25 Dec 2018 21:09:38 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id l10so1947156iok.9
        for <linux-rtc@vger.kernel.org>; Tue, 25 Dec 2018 19:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FIK1HRX1Wbbvae4jUifypk3LnHOa0FRphY/12zrKTeY=;
        b=WJJGdwN7RUnbTSx38holh0g4cxqTxAPE3vAhaM+qv68Kcv00YiB1LsT+/6w2RCN2q+
         S3vZrCwIE/KmZeTTuq4KtCW7jlhefrxbdYWkIRu66muo+jXVcZtqphTDqktt6cb1A6Ra
         uMeKVs8hwKs7UXD0S+6eappb4sE2Ue0gcbZFM6D/y5pm3trmeYFEkSNc1ND5tM8l5uyh
         RXC9ke2Qy/9rjS2tA2B8yfjESwQ0JGa2xCRJoLqoQT6Yc4byBdURi742yLLmveOQAmXo
         mYgNqY4I3XwAABktlns6teNwqrYWu8kyzVEzIPeLbApqugItaQ90hLERid2yUXZGf99R
         I9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FIK1HRX1Wbbvae4jUifypk3LnHOa0FRphY/12zrKTeY=;
        b=TwWFaA4xUj9oBgGUjw8lAw6OiKaYru2vqKaymrqIRn1197xb7uROBvYa9zRLx2kU35
         r3dNgAjvVCJ8o+rCHo5pxq1OBVNcr5ZSwm6+vGEg/jldjw4B4xD1yX4xHmOEBF0AwXNe
         Q3ElhQPCAKMQbofU15NahE+EcBza4iBjpbkguDnVBrfc4MlBpc8GfjrfgcT2i2JQoyob
         UY+3tDdkpRKqwBzBxHu+6jQ/kendlz9t3RzkzHIem9iJQmMGi+VmvAmdEaXE6dOGt207
         XJWzT5Rd4MqVetL10MHFgP1iatZkWzPqwrEZRNmlyLFO3aiTNimt3rwQuaRju6sTFGQf
         yALw==
X-Gm-Message-State: AJcUukcT9MrXDQZMR2rqIMau8ZXVgatfhwCiOwDg4eyrRSzzdezHCGKm
        Lf96PN8v0VmrEKAfQermBUdJcC1DMDarsymVbM0y3J3CoCimmPUVjcqaJHIIChRF/QsIbN3jC2m
        kAhXxHAt//QwOmw10suKjNoUP
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr11232040itd.148.1545793777962;
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4mYu3kTm4tGXoTcQnnrPFFDtpGZQdhq9wEPM9CGCPg7ThKlzfTQ4AY2aXodq3+SAGuEecdgA==
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr11232033itd.148.1545793777712;
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id m37sm12233667iti.6.2018.12.25.19.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: fix a missing check of block data read
Date:   Tue, 25 Dec 2018 21:09:11 -0600
Message-Id: <20181226030911.72845-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When i2c_smbus_read_i2c_block_data() fails, the read data in "buf" could
be incorrect and should not be used. The fix checks if
i2c_smbus_read_i2c_block_data fails, and if so, return its error code
upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rtc/rtc-hym8563.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index e5ad527cb75e..d03f5d212eea 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -109,6 +109,8 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
+	if (ret < 0)
+		return ret;
 
 	tm->tm_sec = bcd2bin(buf[0] & HYM8563_SEC_MASK);
 	tm->tm_min = bcd2bin(buf[1] & HYM8563_MIN_MASK);
-- 
2.17.2 (Apple Git-113)

