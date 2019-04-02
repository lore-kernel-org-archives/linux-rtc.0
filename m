Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C3C43381
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940332084C
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O+9DY1Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfDBDnB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:43:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDBDnB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Apr 2019 23:43:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x323gefM112498;
        Mon, 1 Apr 2019 22:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554176561;
        bh=Tph+O+cLTIQxRmULTRZl3ZFK9nJKoXWtLL54Ev+masQ=;
        h=From:To:CC:Subject:Date;
        b=O+9DY1Kv4nnLCL0mAcvQVkAi0q7ROHAI7GPcR7H7991dnuulbC8tBBtsHsFQnfrta
         R6nV67S1mQowoiVev+TV+n0XDaFmzwHetpVQ9LGAo1S20Rv3V/kG/s9mjSw9+dzGoa
         A4zxfO07U2ujY3wusXv2dXJKmesO6qR72SimILqw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x323geEX081901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 22:42:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 22:42:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 22:42:40 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x323gb9E070613;
        Mon, 1 Apr 2019 22:42:37 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH v2 0/5] AM437x: Add rtc-only + DDR mode support
Date:   Tue, 2 Apr 2019 09:12:48 +0530
Message-ID: <20190402034253.4928-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

RTC plus DDR in self-refresh is a power saving mode where in the entire
system including the different voltage rails from PMIC are shutdown except
the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
contents are preserved.

RTC ALARM2 is connected to PMIC_EN line. TPS65218 PMIC has granular voltage rail
control. The voltage rail feeding RTC is kept on while the rest of the PMIC
regulators are powered off.

Once the ALARM2 is triggered we enter the mode with DDR in self-refresh
and RTC Ticking. After a predetermined time an RTC ALARM1 triggers
waking up the system. The control goes to bootloader. The bootloader then checks
RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
a different path, configure bare minimal clocks for ddr and then jumps to
the resume address in another RTC scratchpad registers and transfers the
control to Kernel. Kernel then restores the saved context.

The patch series adds rtc-only + DDR mode support am am437x
Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.

This mode works only with u-boot built with am43xx_evm_rtconly_defconfig

Additional patch is needed for omap-gpio save restore which will
come as fixes later. 

Hardware Description of this mode can be found here:

http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884. 

Keerthy (5):
  rtc: OMAP: Add support for rtc-only mode
  rtc: interface: Add power_off_program to rtc_class_ops
  arm: mach-omap2: pm33xx: Add support for rtc+ddr in self  refresh mode
  soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
  soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support

 arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
 drivers/rtc/interface.c              |  12 ++
 drivers/rtc/rtc-omap.c               |  49 ++++-
 drivers/soc/ti/Kconfig               |   5 +-
 drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
 include/linux/platform_data/pm33xx.h |   5 +
 include/linux/rtc.h                  |   2 +
 7 files changed, 360 insertions(+), 61 deletions(-)

-- 
2.17.1

