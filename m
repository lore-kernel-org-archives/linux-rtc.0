Return-Path: <rtc-linux+bncBDCMXBNSKAINFZVIXMCRUBGYPJ7U4@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id c135si233795wme.2.2016.06.21.23.42.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 23:42:26 -0700 (PDT)
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 4E41FD80240
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 075632380300
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] [PATCH v2 0/4] add device tree support for rtc-rv8803
Date: Wed, 22 Jun 2016 08:42:18 +0200
Message-ID: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
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

Knut Wohlrab (1):
  rtc: rv8803: add device tree compatible names

Oleksij Rempel (3):
  devicetree: Add Micro Crystal AG vendor id
  dt/bindings: Add bindings for Micro Crystal rv8803
  rtc: rv8803: Be able to set VDETOFF and SWOFF via devcie tree

 .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/rtc/rtc-rv8803.c                           | 50 ++++++++++++++++++++++
 3 files changed, 73 insertions(+)
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
