Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeAWMSR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Jan 2018 07:18:17 -0500
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        kernel@pengutronix.de, Denis.Osterland@diehl.com
Subject: [PATCH 0/4] rtc: isl1208: fixes, documentation and isl1219 support
Date: Tue, 23 Jan 2018 13:17:57 +0100
Message-Id: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This series includes fixes regarding the time setup and interrupt
preparation. It also adds devicetree binding documentation.

It also adds support for the isl1219 device that comes with tamper
detection support. For this we also add devicetree binding documentation
and instantiate the function via hwmon including the new
intrusion[0-*]_timestamp interface.


Denis Osterland (2):
  rtc: isl1208: Fix unintended clear of SR bits
  rtc: isl1208: Add device tree binding documentation

Michael Grzeschik (2):
  rtc: isl1208: enable interrupt after context preparation
  rtc: isl1208: add support for isl1219 with hwmon for tamper detection

 .../devicetree/bindings/rtc/isil,isl1208.txt       |  51 +++++
 Documentation/hwmon/sysfs-interface                |   7 +
 drivers/rtc/rtc-isl1208.c                          | 227 ++++++++++++++++++---
 3 files changed, 256 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt

-- 
2.11.0
