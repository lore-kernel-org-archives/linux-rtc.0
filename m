Return-Path: <SRS0=ssRk=Q4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F5C43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ECA20880
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfBUJqW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:46:22 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:47347 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfBUJqW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Feb 2019 04:46:22 -0500
X-IronPort-AV: E=Sophos;i="5.58,394,1544454000"; 
   d="scan'208";a="8478507"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2019 18:46:20 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 02F88431ECF1;
        Thu, 21 Feb 2019 18:46:16 +0900 (JST)
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
Subject: [PATCH 0/5] Add EPSON RX-8571 RTC support
Date:   Thu, 21 Feb 2019 09:40:43 +0000
Message-Id: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This patch set aims to add support for EPSON RX-8571 real-time clock.
EPSON RX-8571 rtc is compatible with EPSON RX-8581 rtc except that
former has 16 bytes additional RAM.

1 byte of nvmem is supported on both RX-8581 and RX-8571. It is
exposed through sysfs along with  support for 16 bytes additional RAM
present only on EPSON RX-8571.

This patch series is tested against renesas-dev and linux-next.

Biju Das (5):
  rtc: rx8581: Add rx8571 compatible
  rtc: rx8581: Add support for rx8571 RTC
  rtc: rx8581: Add support for Epson rx8571 RTC
  arm64: defconfig: enable RX-8581 config option
  arm64: dts: renesas: r8a774c0-cat874: add RTC support

 Documentation/devicetree/bindings/rtc/rtc.txt   |   1 +
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |  18 ++++
 arch/arm64/configs/defconfig                    |   1 +
 drivers/rtc/Kconfig                             |   5 +-
 drivers/rtc/rtc-rx8581.c                        | 114 ++++++++++++++++++++++--
 5 files changed, 128 insertions(+), 11 deletions(-)

-- 
2.7.4

