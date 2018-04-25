Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:62845 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbeDYJdN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Apr 2018 05:33:13 -0400
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 16/17] MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
Date: Wed, 25 Apr 2018 17:32:42 +0800
Message-ID: <39a73c162a637e1558e8c00a971db5db569397ff.1524646231.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add new files for new dt-bindings and a globally visible header file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d..a7ef37f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1607,9 +1607,11 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 F:	Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
 F:	drivers/rtc/rtc-mt6397.c
 F:	drivers/rtc/rtc-mt7622.c
+F:	include/linux/mfd/mt6397/rtc.h
 
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
-- 
2.7.4
