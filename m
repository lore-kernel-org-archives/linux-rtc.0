Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36834 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeAARaK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Jan 2018 12:30:10 -0500
Date: Mon, 1 Jan 2018 23:00:02 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-rtc@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, gregkh@linuxfoundation.org
Subject: [PATCH 0/2] Documentation: rtc: move ioctl to ABI
Message-ID: <cover.1514827586.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Two documentation changes in rtc:
1) Minor change to add file permissions to sysfs interface
2) Move ioctl interface to Documentation/ABI

Aishwarya Pant (2):
  Documentation: rtc: add sysfs file permissions
  Documentation: rtc: move iotcl interface documentation to ABI

 Documentation/ABI/testing/rtc-cdev        | 42 ++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-class-rtc | 44 ++++++++++++++-------------
 Documentation/rtc.txt                     | 49 ++-----------------------------
 3 files changed, 67 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/ABI/testing/rtc-cdev

-- 
2.15.1
