Return-Path: <SRS0=Jagb=OI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A53C43610
	for <linux-rtc@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C720868
	for <linux-rtc@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234C720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeK3EJR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:17 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:12977 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729818AbeK3EJR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 29 Nov 2018 23:09:17 -0500
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Nov 2018 02:03:13 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 711BA405EE68;
        Fri, 30 Nov 2018 02:03:10 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] Add NXP pcf85263 real-time clock support
Date:   Thu, 29 Nov 2018 16:54:42 +0000
Message-Id: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This patch set aims to add support for NXP pcf85263 real-time clock. 
pcf85263 rtc is compatible with pcf85363 rtc except that pcf85363 has
64 bytes additional RAM. 

1 byte of nvmem is supported in pcf85263 and is exposed through sysfs.

The details of pcf85363 and pcf85263 can be found in the below data sheets.

https://www.nxp.com/docs/en/data-sheet/PCF85363A.pdf

https://www.nxp.com/docs/en/data-sheet/PCF85263A.pdf

This patch is tested against linux-next.

V1-->V2
   * Incorporated simon's review comment for binding patch.
   * Incorporated Geert and Alexandre's review comments.

Biju Das (4):
  dt-bindings: rtc: pcf85363: Document pcf85263 real-time clock
  rtc: pcf85363: Add support for NXP pcf85263 rtc
  ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
  ARM: dts: iwg23s-sbc: Enable RTC

 Documentation/devicetree/bindings/rtc/pcf85363.txt |  4 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          | 18 ++++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 drivers/rtc/rtc-pcf85363.c                         | 72 +++++++++++++++++-----
 4 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.7.4

