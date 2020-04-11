Return-Path: <SRS0=Nw7/=53=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C83C2BBC7
	for <linux-rtc@archiver.kernel.org>; Sat, 11 Apr 2020 23:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9439B206A1
	for <linux-rtc@archiver.kernel.org>; Sat, 11 Apr 2020 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648490;
	bh=rjytP4Nsb3o8SYY72ku2H/NNEttzxHpHq53ChREMXFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgvxdbfrOb55xVXwGCF6Mc99O4SD1sc2vrM6SXzsFp6EQjzx2JHI/y7IGyCMETQu+
	 MhaLz5vCl3twK0HZjPLsNeJmZFhvwPe2+kdETXIT+2QEazGrLVl9uSIgwNEFqFkGBz
	 qH6zDj/L39iRAcUALohaBJp6nH0xL1QOVEfhIiL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDKXHG (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgDKXGx (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A93216FD;
        Sat, 11 Apr 2020 23:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646413;
        bh=rjytP4Nsb3o8SYY72ku2H/NNEttzxHpHq53ChREMXFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlO77yEQWkUuUGFBAe5TyPY/Hqy6khi8DFLoTnfcBjAaN8CUHmWs9J6fwmWpttShw
         OUwLfUxJN7GLNsRQnjVOa6hiwhBl6stPjwcKBv4O3e/MHJ9jW1rMtvqbSnZGGfiw/p
         9y0mG7oLdvkHRRRvAmtSo9mpTaCJ9RFRaEtWCE1M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 148/149] rtc: imx-sc: Align imx sc msg structs to 4
Date:   Sat, 11 Apr 2020 19:03:45 -0400
Message-Id: <20200411230347.22371-148-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit a29de86521d8a80cb0b426638d4e38707cafa2e2 ]

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: a3094fc1a15e ("rtc: imx-sc: add rtc alarm support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Link: https://lore.kernel.org/r/13404bac8360852d86c61fad5ae5f0c91ffc4cb6.1582216144.git.leonard.crestez@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-imx-sc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index cf2c12107f2b8..a5f59e6f862e0 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -37,7 +37,7 @@ struct imx_sc_msg_timer_rtc_set_alarm {
 	u8 hour;
 	u8 min;
 	u8 sec;
-} __packed;
+} __packed __aligned(4);
 
 static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-- 
2.20.1

