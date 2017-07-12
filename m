Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35592 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdGLFXl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:23:41 -0400
Received: by mail-wr0-f177.google.com with SMTP id k67so17241806wrc.2
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:23:40 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/9] rtc: ds1307: series with refactorings / improvements
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Message-ID: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Date: Wed, 12 Jul 2017 07:23:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This series includes smaller refactorings and improvements.

Heiner Kallweit (9):
  rtc: ds1307: remove member irq from struct ds1307
  rtc: ds1307: factor out bbsqi bit to struct chip_desc
  rtc: ds1307: improve trickle charger initialization
  rtc: ds1307: constify struct chip_desc variables
  rtc: ds1307: improve irq setup
  rtc: ds1307: factor out irq_handler to struct chip_desc
  rtc: ds1307: factor out rtc_ops to struct chip_desc
  rtc: ds1307: factor out offset to struct chip_desc
  rtc: ds1307: remove member nvram_offset from struct ds1307

 drivers/rtc/rtc-ds1307.c | 165 ++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 89 deletions(-)

-- 
2.13.2
