Return-Path: <rtc-linux+bncBDXMLNOH5ANRBY6N3XCQKGQETQM7YKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id s64si1137727pfk.0.2017.03.01.16.27.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 16:27:15 -0800 (PST)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCHv4 1/2] dt-bindings: Add vendor prefix for Motorola
Date: Thu,  2 Mar 2017 01:27:08 +0100
Message-Id: <20170302002709.22276-1-sre@kernel.org>
In-Reply-To: <20170220073535.27393-1-sre@kernel.org>
References: <20170220073535.27393-1-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Motorola was involved in semiconductor and mobile phone business.
The "motorola," prefix is already used by a couple of bindings:

* rtc/rtc-cmos.txt
* mfd/motorola-cpcap.txt
* regulator/cpcap-regulator.txt

Apart from that it is used in the DT file for the Droid 4 mobile
phone.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv3:
 - Fix typo
 - Add Acked-By from Rob Herring
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index bd0ed3cb4994..81b538fbad22 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -190,6 +190,7 @@ minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
+motorola	Motorola, Inc.
 moxa	Moxa
 mpl	MPL AG
 mqmaker	mqmaker Inc.
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
