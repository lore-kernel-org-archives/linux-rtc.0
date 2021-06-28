Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1828C49EA3
	for <linux-rtc@archiver.kernel.org>; Mon, 28 Jun 2021 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881B961988
	for <linux-rtc@archiver.kernel.org>; Mon, 28 Jun 2021 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhF1Qy2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 28 Jun 2021 12:54:28 -0400
Received: from [115.28.160.31] ([115.28.160.31]:51240 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S231959AbhF1Qy1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Jun 2021 12:54:27 -0400
Received: from ld50.lan (unknown [101.224.80.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BD11C6010D;
        Tue, 29 Jun 2021 00:46:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1624898780; bh=zPm7kCpHtOvaBn7++/scSf7H0xnEr90q7RKdRXbDbB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWfbabf8EkW4WlaeQU6CKPICNK2BYx2/jppSuam+U5HLTk5yJIu6WVd6E9T+VRECb
         qe75qIMph7V4Wj+gqE0KmjVkvflQ5uN+upxRh0lc6WyeVT3PIDJ2BuddPwvdzHZCNE
         IqQ22PfEtkeW7FtsQm1QihKKh4KTuIjE2N5+Zlek=
From:   WANG Xuerui <git@xen0n.name>
To:     linux-rtc@vger.kernel.org
Cc:     WANG Xuerui <git@xen0n.name>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 3/6] MIPS: Loongson64: DTS: Add RTC support to LS7A
Date:   Tue, 29 Jun 2021 00:45:49 +0800
Message-Id: <20210628164552.1006079-4-git@xen0n.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210628164552.1006079-1-git@xen0n.name>
References: <20210628164552.1006079-1-git@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The LS7A RTC module is now supported, enable it.

Signed-off-by: WANG Xuerui <git@xen0n.name>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@vger.kernel.org
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 2f45fce2cdc4..82035de4774f 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -19,6 +19,11 @@ pic: interrupt-controller@10000000 {
 			#interrupt-cells = <2>;
 		};
 
+		rtc0: rtc@100d0100 {
+			compatible = "loongson,ls2x-rtc";
+			reg = <0 0x100d0100 0 0x78>;
+		};
+
 		ls7a_uart0: serial@10080000 {
 			compatible = "ns16550a";
 			reg = <0 0x10080000 0 0x100>;
-- 
2.30.1

