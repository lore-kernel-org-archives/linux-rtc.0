Return-Path: <SRS0=P+fM=N6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F9C43441
	for <linux-rtc@archiver.kernel.org>; Mon, 19 Nov 2018 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7982B206BA
	for <linux-rtc@archiver.kernel.org>; Mon, 19 Nov 2018 11:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKSVvr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:51:47 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:61809 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbeKSVvr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 19 Nov 2018 16:51:47 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 16:51:46 EST
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Nov 2018 20:23:22 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3024040083C3;
        Mon, 19 Nov 2018 20:23:19 +0900 (JST)
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
Subject: [PATCH  0/4] Add NXP pcf85263 real-time clock support
Date:   Mon, 19 Nov 2018 11:15:04 +0000
Message-Id: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This patch set aims to add support for NXP pcf85263 real-time clock. 
pcf85263 rtc is compatible with pcf85363 rtc except that pcf85363 has
64 bytes additional RAM. 

1 byte of nvmem is supported in pcf85263 and is exposed through sysfs.

The details of pcf85363 and pcf85263 can be found in the below
data sheets.

https://www.nxp.com/docs/en/data-sheet/PCF85363A.pdf

https://www.nxp.com/docs/en/data-sheet/PCF85263A.pdf


This patch is tested against linux-next and renesas-dev.

Biju Das (4):
  dt-bindings: rtc: pcf85363: Document pcf85263 real-time clock
  rtc: pcf85363: Add support for NXP pcf85263 rtc
  ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
  ARM: dts: iwg23s-sbc: Enable RTC

 Documentation/devicetree/bindings/rtc/pcf85363.txt |  4 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          | 18 +++++++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 drivers/rtc/rtc-pcf85363.c                         | 44 +++++++++++++++++++---
 4 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.7.4

