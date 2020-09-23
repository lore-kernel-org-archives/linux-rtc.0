Return-Path: <SRS0=m1go=DA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A0C2D0A8
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Sep 2020 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E67823741
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Sep 2020 08:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="jB8glkYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIWIGw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 23 Sep 2020 04:06:52 -0400
Received: from [115.28.160.31] ([115.28.160.31]:55520 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgIWIGv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Sep 2020 04:06:51 -0400
Received: from ld50.lan (unknown [101.224.80.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 91D86607D4;
        Wed, 23 Sep 2020 16:00:08 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1600848008; bh=CMSSFUI7+7uXMRUsxhzFU79TN/n22FWBBRFjjbunpgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jB8glkYpwoY4YTZKQh1GDNcgdC8A6X01Vv1jAnmR99TT33kmQDw1V043/A/7dbzm7
         KgxM3lOhGfv1OJ07VetTHQUiQZUtOHD7JY9b9gs9nl42aX9l9upRICeBMSVGICqERw
         3yz07x5/JE0FX3Ku/pkbzAJI0MGufpZ6enFKkL8Q=
From:   WANG Xuerui <git@xen0n.name>
To:     linux-rtc@vger.kernel.org
Cc:     WANG Xuerui <git@xen0n.name>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Loongson: Enable LS2X RTC in loongson3_defconfig
Date:   Wed, 23 Sep 2020 15:58:45 +0800
Message-Id: <20200923075845.360974-5-git@xen0n.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923075845.360974-1-git@xen0n.name>
References: <20200923075845.360974-1-git@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This is now supported, enable for Loongson-2K or LS7A systems.
Other systems are unaffected.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/mips/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index a5005c8cee8a..d15bb0e39f9d 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -322,6 +322,7 @@ CONFIG_USB_SERIAL_OPTION=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_RTC_DRV_GOLDFISH=y
+CONFIG_RTC_DRV_LS2X=y
 CONFIG_DMADEVICES=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=m
-- 
2.28.0

