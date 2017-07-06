Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49149 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFJmT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:19 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 00/11] RTC: rework registration
Date: Thu,  6 Jul 2017 11:41:57 +0200
Message-Id: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are multiple race condition issues in the RTC drivers. It is
especially apparent in the IRQ handling and additionnal sysfs attributes
registration.

To solve most of those and allow to extend the framework more easily,
introduce a new registration method that allows to first allocate an
rtc_device and then register it.

Also, introduce a generic way to register nvmem devices so RTCs can
export their non volatile storage.

One of the goal will be to get rid of the IS_ERR_OR_NULL(rtc) check in
rtc_update_irq which makes people assume everything is properly handled
in the core.

Alexandre Belloni (11):
  rtc: class separate device allocation from registration
  rtc: class separate id allocation from registration
  rtc: introduce new registration method
  rtc: at91rm9200: remove race condition
  rtc: add generic nvmem support
  rtc: rv8803: switch to rtc_register_device
  rtc: rv8803: use generic nvmem support
  rtc: rv8803: remove rv8803_remove
  rtc: ds1307: switch to rtc_register_device
  rtc: ds1307: use generic nvmem
  rtc: ds1307: remove ds1307_remove

 Documentation/rtc.txt        |   2 +
 drivers/rtc/Kconfig          |   8 ++
 drivers/rtc/Makefile         |   1 +
 drivers/rtc/class.c          | 195 +++++++++++++++++++++++++++++++++----------
 drivers/rtc/nvmem.c          | 113 +++++++++++++++++++++++++
 drivers/rtc/rtc-at91rm9200.c |  14 ++--
 drivers/rtc/rtc-core.h       |   8 ++
 drivers/rtc/rtc-ds1307.c     | 103 +++++++----------------
 drivers/rtc/rtc-rv8803.c     |  72 +++++++---------
 include/linux/rtc.h          |  14 ++++
 10 files changed, 362 insertions(+), 168 deletions(-)
 create mode 100644 drivers/rtc/nvmem.c

-- 
2.11.0
