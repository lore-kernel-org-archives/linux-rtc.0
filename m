Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37379 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGDJG3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Jul 2018 05:06:29 -0400
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] rtc: omap: fixes and clean ups
Date: Wed,  4 Jul 2018 11:05:54 +0200
Message-Id: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Here are a couple of fixes for issues discovered through inspection
along with some clean ups.

Johan


Johan Hovold (4):
  rtc: omap: fix potential crash on power off
  rtc: omap: fix resource leak in registration error path
  rtc: omap: add missing register lock in error path
  rtc: omap: drop unnecessary register unlock around reads

 drivers/rtc/rtc-omap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.18.0
