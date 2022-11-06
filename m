Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1369AC433FE
	for <linux-rtc@archiver.kernel.org>; Sun,  6 Nov 2022 17:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiKFRMy (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 6 Nov 2022 12:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiKFRMZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 6 Nov 2022 12:12:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9614D1F;
        Sun,  6 Nov 2022 09:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C7560BFF;
        Sun,  6 Nov 2022 17:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5669FC433C1;
        Sun,  6 Nov 2022 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667754443;
        bh=OCq411Ero81o/ji24Kw2gCP6jOBeej2cIJITZ6eOp2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZWfafUG5dXPS09cOm7wP95SgjSDMJIqxO+qfs+7I8M7NbFgDZguj6iPmKGfo+HNQ
         Ftzn1rv+R8SCZevlHbzu7zWlPRjgQ1vAvev43YkPD4k7kcTeJJuwD6dru/J5K7g1r/
         gJMHaBNlFbJUYAh94CCZSvuEpcfpr1j9kBULIfS0wQaJODkHDJ/HKUqWrWkjhJjWim
         /sInjawMFpyVmD/OMNQiYz9kGH/r4wthmK/yYldMDToC5RVstnk9ufVbOuqMh8e0F1
         ipYD/X36Yj6H22/v3atioij6RXFf0yIgolsXv6n1DCQbnwXs7CCuE8IHcYCjxPKljv
         fUMEOs0FWw3AQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/7] rtc: cmos: fix build on non-ACPI platforms
Date:   Sun,  6 Nov 2022 12:07:04 -0500
Message-Id: <20221106170705.1580963-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106170705.1580963-1-sashal@kernel.org>
References: <20221106170705.1580963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit db4e955ae333567dea02822624106c0b96a2f84f ]

Now that rtc_wake_setup is called outside of cmos_wake_setup, it also need
to be defined on non-ACPI platforms.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20221018203512.2532407-1-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-cmos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 8545f0da57fe..c6147d8b622f 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1294,6 +1294,9 @@ static void cmos_check_acpi_rtc_status(struct device *dev,
 {
 }
 
+static void rtc_wake_setup(struct device *dev)
+{
+}
 #endif
 
 #ifdef	CONFIG_PNP
-- 
2.35.1

