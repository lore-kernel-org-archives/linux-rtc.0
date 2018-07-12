Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49946 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFQc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Jul 2018 01:16:32 -0400
From: Keerthy <j-keerthy@ti.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC: <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v4 0/4] rtc: OMAP: Add support for rtc-only mode
Date: Thu, 12 Jul 2018 10:37:36 +0530
Message-ID: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
The patch series is based on top of Johan Hovald's series:

https://lkml.kernel.org/r/20180704090558.16647-1-johan@kernel.org

Tested for suspend/resume and poweroff on am437x-gp-evm. 

Keerthy (4):
  rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
  rtc: OMAP: Add support for rtc-only mode
  rtc: omap: use of_device_is_system_power_controller function
  rtc: interface: Add power_off_program to rtc_class_ops

 drivers/rtc/interface.c | 12 +++++++++
 drivers/rtc/rtc-omap.c  | 70 +++++++++++++++++++++++++++++++++++--------------
 include/linux/rtc.h     |  2 ++
 3 files changed, 65 insertions(+), 19 deletions(-)

-- 
1.9.1
