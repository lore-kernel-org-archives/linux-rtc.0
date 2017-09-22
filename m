Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:37941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751898AbdIVDdo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 23:33:44 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 4/4] rtc: mediatek: update MAINTAINERS entry with MediaTek RTC driver
Date: Fri, 22 Sep 2017 11:33:17 +0800
Message-ID: <54b8e1ee92e64b788ace4240640eb4d54b373587.1506049341.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1506049341.git.sean.wang@mediatek.com>
References: <cover.1506049341.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek on maintaining the MediaTek SoC based RTC driver for
the existing SoCs and keep adding support for the following SoCs in the
future.

Cc: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4..5142029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1579,10 +1579,13 @@ F:	drivers/rtc/rtc-armada38x.c
 
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
+M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
 F:	drivers/rtc/rtc-mt6397.c
+F:	drivers/rtc/rtc-mediatek.c
 
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
-- 
2.7.4
