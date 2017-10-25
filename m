Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:44419 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751702AbdJYOC3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 10:02:29 -0400
From: Chen Zhong <chen.zhong@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH v6 2/6] dt-bindings: input: Add common keyboard document bindings
Date: Wed, 25 Oct 2017 21:16:00 +0800
Message-ID: <1508937364-30054-3-git-send-email-chen.zhong@mediatek.com>
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch adds the device tree binding documentation for common
keyboard.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/input/keys.txt |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt

diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
new file mode 100644
index 0000000..a0ea7eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/keys.txt
@@ -0,0 +1,8 @@
+General Keys Properties:
+
+Optional properties for Keys:
+- power-off-time-sec: Duration in seconds which the key should be kept
+ 	pressed for device to power off automatically. Device with key pressed
+ 	shutdown feature can specify this property.
+- linux,keycodes: Specifies the numeric keycode values to be used for
+	reporting key presses.
\ No newline at end of file
-- 
1.7.9.5
