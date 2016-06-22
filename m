Return-Path: <rtc-linux+bncBDCMXBNSKAINHZVIXMCRUBABWICEC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id a186si204233wma.1.2016.06.21.23.42.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 23:42:27 -0700 (PDT)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id DB26D1580227
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 64DFDA405B3
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [rtc-linux] [PATCH v2 1/4] devicetree: Add Micro Crystal AG vendor id
Date: Wed, 22 Jun 2016 08:42:19 +0200
Message-ID: <1466577742-18824-2-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
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

From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c2500d..7a1d5ea 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -158,6 +158,7 @@ melexis	Melexis N.V.
 merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
+microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
 minix	MINIX Technology Ltd.
 mitsubishi	Mitsubishi Electric Corporation
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
