Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA0C43381
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666421900
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FXDCmpUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCVRRm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:17:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39174 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVRRm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 13:17:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MHGLdM103606;
        Fri, 22 Mar 2019 12:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553274981;
        bh=nD95xkxwGktT/JItqZqTTIGuWus08WVAC8nlLCp6fCA=;
        h=From:To:CC:Subject:Date;
        b=FXDCmpUPZzb0Z6yh/k0HhbdWAmfDfjNs5eLOSbl4biCmQZ+Yj0d4YDO7JZisHPH1I
         48faxnIRIK7DPcHe0PW9E3Vv2ELf6fwYPVj83yOTQlyUxq1fOD6Y1A7+uHWk4wo48z
         1sX+bLKlGilmzqInnvz3Y3sXiew/l7nqQfsHFsiQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MHGLCc082270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 12:16:21 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 12:16:20 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 12:16:20 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MHGHYJ006487;
        Fri, 22 Mar 2019 12:16:18 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH 0/5]  AM437x: Add rtc-only + DDR mode support
Date:   Fri, 22 Mar 2019 22:46:14 +0530
Message-ID: <20190322171619.4180-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

RTC plus DDR in self-refresh is power a saving mode where in the entire
system including the different voltage rails from PMIC are shutdown except
the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
we the ALARM2 is triggered we enter the mode with DDR in self-refresh
and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
up the system. The control goes to bootloader. The bootloader then checks
RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
a different path, configure bare minimal clocks for ddr and then jumps to
the resume address in another RTC scratchpad registers and transfers the
control to Kernel. Kernel then restores the saved context.

The patch series adds rtc-only + DDR mode support am am437x
Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.

This mode works only with u-boot built with am43xx_evm_rtconly_defconfig

Additional patch is needed for omap-gpio save restore which will
come as fixes later.

Keerthy (5):
  rtc: OMAP: Add support for rtc-only mode
  rtc: interface: Add power_off_program to rtc_class_ops
  arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
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

