Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbeGZO6Q (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:16 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/8] rtc: cleanup task handling
Date: Thu, 26 Jul 2018 15:40:48 +0200
Message-Id: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

This series drops the now unused periodic task handling. It has been
used in total by 3 drivers that were dropped and mainly replaced by
kernel timers.

This allows to also remove a few rtc_device struct members and struct
rtc_task.

Tested using rtcpie and rtctest.

Alexandre Belloni (8):
  rtc: sa1100: don't set PIE frequency
  rtc: sh: remove dead code
  rtc: remove rtc_irq_register/rtc_irq_unregister
  rtc: remove irq_task and irq_task_lock
  rtc: simplify rtc_irq_set_state/rtc_irq_set_freq
  rtc: unexport rtc_irq_set_*
  char: rtc: remove task handling
  rtc: remove struct rtc_task

 drivers/char/rtc.c       | 13 ------
 drivers/rtc/class.c      |  1 -
 drivers/rtc/interface.c  | 97 +++++++---------------------------------
 drivers/rtc/rtc-dev.c    |  8 ++--
 drivers/rtc/rtc-sa1100.c |  1 -
 drivers/rtc/rtc-sh.c     | 89 +-----------------------------------
 include/linux/rtc.h      | 21 ++-------
 7 files changed, 25 insertions(+), 205 deletions(-)

-- 
2.18.0
