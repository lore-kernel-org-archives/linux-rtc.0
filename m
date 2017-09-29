Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43498 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdI2KXe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 29 Sep 2017 06:23:34 -0400
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: clarify the RTC offset correction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
Date: Fri, 29 Sep 2017 11:23:25 +0100
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC offset correction documentation is not very clear about the
exact relationship between "offset" and the effect it has on the RTC.
Supplement the documentation with an equation giving the relationship.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 8cec9a02c0b8..045e0a72d14b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1004,6 +1004,10 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
  * to compensate for differences in the actual clock rate due to temperature,
  * the crystal, capacitor, etc.
  *
+ * The adjustment applied is as follows:
+ *   t = t0 * (1 + offset * 1e-9)
+ * where t0 is the measured length of 1 RTC second with offset = 0
+ *
  * Kernel interface to adjust an rtc clock offset.
  * Return 0 on success, or a negative number on error.
  * If the rtc offset is not setable (or not implemented), return -EINVAL
-- 
2.7.4
