Return-Path: <rtc-linux+bncBDCMXBNSKAIMLO6PXMCRUBCHKDM76@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id r10si347722wmf.0.2016.06.29.07.40.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 07:40:04 -0700 (PDT)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 7DBB6D800EA
	for <rtc-linux@googlegroups.com>; Wed, 29 Jun 2016 16:40:04 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 34CEAA40484
	for <rtc-linux@googlegroups.com>; Wed, 29 Jun 2016 16:40:04 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] [PATCH v3 0/3] add device tree support for rtc-rv8803
Date: Wed, 29 Jun 2016 16:39:58 +0200
Message-ID: <1467211201-17252-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Oleksij Rempel <linux@rempel-privat.de>

Changes v2:
- rename mc to microcrystal
- rename vdetoff to vdet-disable

Changes v3:
- remove of_device_id patch
- use device type instead of of_device_is_compatible

Oleksij Rempel (3):
  devicetree: Add Micro Crystal AG vendor id
  dt/bindings: Add bindings for Micro Crystal rv8803
  rtc: rv8803: Be able to set VDETOFF and SWOFF via devcie tree

 .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/rtc/rtc-rv8803.c                           | 50 +++++++++++++++++++++-
 3 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
