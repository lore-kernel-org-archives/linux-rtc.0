Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:39759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752516AbdI0KoU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 06:44:20 -0400
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
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH v5 2/6] dt-bindings: input: Add common keyboard document bindings
Date: Wed, 27 Sep 2017 18:44:04 +0800
Message-ID: <1506509048-19032-3-git-send-email-chen.zhong@mediatek.com>
In-Reply-To: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch adds the device tree binding documentation for common
keyboard.

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
