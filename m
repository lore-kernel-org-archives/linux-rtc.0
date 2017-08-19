Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34071 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHSTIJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Aug 2017 15:08:09 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/4] constify rtc i2c_device_id
Date: Sun, 20 Aug 2017 00:37:54 +0530
Message-Id: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Arvind Yadav (4):
  [PATCH 1/4] rtc: ds1672: constify i2c_device_id
  [PATCH 2/4] rtc: em3027: constify i2c_device_id
  [PATCH 3/4] rtc: max6900: constify i2c_device_id
  [PATCH 4/4] rtc: rv3029c2: constify i2c_device_id

 drivers/rtc/rtc-ds1672.c   | 2 +-
 drivers/rtc/rtc-em3027.c   | 2 +-
 drivers/rtc/rtc-max6900.c  | 2 +-
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
