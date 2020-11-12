Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52552C388F7
	for <linux-rtc@archiver.kernel.org>; Thu, 12 Nov 2020 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036F021D7F
	for <linux-rtc@archiver.kernel.org>; Thu, 12 Nov 2020 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgKLNIH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:08:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46453 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLNIH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Nov 2020 08:08:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CX22s26Y6z1qt4q;
        Thu, 12 Nov 2020 14:08:05 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CX22s0R30z1sQ3W;
        Thu, 12 Nov 2020 14:08:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id q1H9Z6E-Iebn; Thu, 12 Nov 2020 14:08:04 +0100 (CET)
X-Auth-Info: vsr9gRo0OSAbhlQrz/KAe+9xwgVeVZ42X9I8kHgyFVM=
Received: from localhost (dslb-094-220-156-233.094.220.pools.vodafone-ip.de [94.220.156.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 12 Nov 2020 14:08:04 +0100 (CET)
From:   Claudius Heine <ch@denx.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>,
        Johannes Hahn <johannes-hahn@siemens.com>,
        Claudius Heine <ch@denx.de>
Subject: [PATCH v2 0/3] Adding I2C support to RX6110 RTC
Date:   Thu, 12 Nov 2020 14:07:31 +0100
Message-Id: <20201112130734.331094-1-ch@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

here is the 2nd version of the patchset that adds I2C support to the RX6110 RTC.

Changes from v1:
- moved common probing code into its own function `rx6110_probe`
- added a small patch to fix a type in the Kconfig


Claudius Heine (2):
  rtc: rx6110: add i2c support
  rtc: Kconfig: Fix typo in help message of rx 6110

Johannes Hahn (1):
  rtc: rx6110: add ACPI bindings to I2C

 drivers/rtc/Kconfig      |  20 +++--
 drivers/rtc/rtc-rx6110.c | 177 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 166 insertions(+), 31 deletions(-)

-- 
2.20.1

