Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB468C433ED
	for <linux-rtc@archiver.kernel.org>; Thu,  6 May 2021 01:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A683361159
	for <linux-rtc@archiver.kernel.org>; Thu,  6 May 2021 01:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhEFBFr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 5 May 2021 21:05:47 -0400
Received: from [115.28.160.31] ([115.28.160.31]:51072 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhEFBFq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 May 2021 21:05:46 -0400
Received: from ld50.lan (unknown [101.224.80.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B53A563571;
        Thu,  6 May 2021 09:04:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1620263086; bh=9v8f97ChqoUTAZr7mZ3Hn4IYe/rARMySCQCNva+ssAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozd9OxGrsDyX4vzJzq5LFO00n4CRB5A9T+3EBGH/JghOQV3kaOz+Lp7tDgKMiVtQi
         1jyM35aYvRUCG6SmPqEOvakDVc8h5Rv8LAb0DLnl1hIn1fEgXFwSF6bR+RPc3YEHnn
         TQBre9cBIEGITsBjgaSFQufHF8+Rn1rPNx8sg0co=
From:   WANG Xuerui <git@xen0n.name>
To:     linux-rtc@vger.kernel.org
Cc:     WANG Xuerui <git@xen0n.name>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/6] MIPS: Loongson: Enable LS2X RTC in loongson3_defconfig
Date:   Thu,  6 May 2021 09:04:33 +0800
Message-Id: <20210506010435.1333647-5-git@xen0n.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210506010435.1333647-1-git@xen0n.name>
References: <20210506010435.1333647-1-git@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This is now supported, enable for Loongson-3 systems.
Other systems are unaffected.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/mips/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index a18609cf0e5e..b34ca534b9b6 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -325,6 +325,7 @@ CONFIG_USB_SERIAL_OPTION=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_RTC_DRV_GOLDFISH=y
+CONFIG_RTC_DRV_LS2X=y
 CONFIG_DMADEVICES=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=m
-- 
2.30.1

