Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239115;
	b=aOuKxnZ5OEYgb4DlQccDDpuq/x3+ZV9cIA8++wUG55PgbjgqhG9bztFrflgBtXZTscP9
	 KIb5n4O+ep1C0YPw4iEOoPdvv9/rQS4QZh/fjZ0Dp7ogEL+GO29IdDZvRU8EjRLy54+Aq
	 dcojaRRVjgEjsKKTv7JDS3/gAWsOn8yzEWExpszYnA7E6ks6S8cWvh+UpNehkpP/CMpYA
	 jql676olj34hp5fZdZ5aKHtpwdBpCo9u6X8zA+aTY+GNBcXUuVlO7t8al+WUfjnJ5RNW3
	 Y5fbCPlf70e9ICne2iLi+WRQRKQuzqyVPSI4VXQo+gj17wYftyM/DnctyeeU9lTJ29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rh4heiROTn2BTclkUIfVJAc7WlFd4Gu+0wgV3dS1bGw=;
	b=15oFQRTZEImhFw+l9PgjI6fHcDwXKBtR6VCNM8TljUUT0SO3z6kvLYzsIeCp3xrmOhk2
	 3Phr6Ars9q0tMRGNkepm+DX0RSUXWn5KrGV8MMquxqnF+IavpdW43tgYEvvYebfdV0WPi
	 jk92HX9+mQCflHbuhxpELw+uPchZaBEVsUc2X6gD+WM1mVXaId1FxQLXMe2SFfSHz7Zyv
	 wnL0OzoJu7/fzv7tLtltf/A/xV5ENFG6YjCg5W+6wj1K0RsiN6C1BuniytWPq3P64O6ZJ
	 ay2TDy3IJh1/5z+3aJLAyCz4VEeaXWnB5RamXFhzqhGBvhr7E0NY0bMRWAI08WMrwuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSpB7hl6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE2606A33C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EE2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSpB7hl6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso8461105e9.3
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239106; x=1794843906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rh4heiROTn2BTclkUIfVJAc7WlFd4Gu+0wgV3dS1bGw=;
        b=hSpB7hl6GglOFC9dYLzfjOBwjg4JCNsk8RMTZ8kM0fRTiy8v1TqKNld6fKK000xvpR
         FjjkWf952OWkh1CA3KW8y9zklJlPMaq8OOHSN45xHkqgbLYU1MD51r07ihcFCr3bGFB3
         Ufx0KCej+O2b4hS4QXhcbfqmawsmwrXOkbxpdZ9SrafrEE5ljpA/vNbtxqhrYUUInaxj
         XWRkXCZf1r+BbeMXQ6y1xlzWlyhHiwv1kM0VT6+Fhi9pVNr38I3ZkwytekdxryBVt1Ka
         VaUyzqS+8P7yHo2eTvh8jc5qN0bwWMCe/f2h5GleUbzX8FvvpRWYKcyQ8CbRMmFLGcwo
         gA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239106; x=1794843906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh4heiROTn2BTclkUIfVJAc7WlFd4Gu+0wgV3dS1bGw=;
        b=xfIwkVgr2aeykag1orr2C9bgPx7qLoKF7YYqy37BuiXJKaR8F66Id/gbik96yYL67l
         RxYxOijO/rjyf9rEoQsVs4MDDBESGeVeSuFi7+/n6xAslXTjeUFQBiJxQZ6s0hmXFCBH
         3Y0FlIqWoLyBYo4RlgMyCeXSmDV3K05UKMXYeG6b6EAcC9gvP+nqaNZFqu1YlNLn4CeY
         vrEWW6+fEyzxGXIJbkgmYAbjO4E4Nqo4bOck8QNcjXuTUNbeIyL6vwMW85BvMqCU2/q2
         CplWcF7mNfk3+sdqe8eHUAmDl2Mb5CX5PcThNHNlfZ778/orwqgTV/QJnCQ6AHgyhfSR
         zXnQ==
X-Forwarded-Encrypted: i=1; AL+hErHCYLgjdGHIz2ROzGkmlN0l/JBAz0mk5ja/NFTypxAV2FNbis8VwJG8TIWq3G7S6RBA4e8wjUYg1Q8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h6BskQrahHEnCauHQxHgYZgvT1lKQaIQnkr3wmdHCMYUCKuPk
	m4IXF82Pa0jNGOZ47/DxGaYN1tu2DMIA+kMWTgG4dov2/fxhdpytNWbk
X-Gm-Gg: AYBFou1kItGyIDycHhEPfjFO3NVPHr1B/N3MTCDUWjMWobMtLWoX+w2DA8/USBJeqJN
	JmWFNCcfg9hS/SSK9My0LWS07r0za7NI6sZ6ev/1EO4Ev1ZIiMB+9siu15/g0RmPNYL7CfSaG97
	I7kO1PJ7dCxgO4yUbTwoncnG1CZc//X/OMmt8SUq6W6BNbKLK1coC28/kw7HEgc3blKIf80TQbA
	W20bgTBgb/AM3/KDkNAh6n5F+0B3h26HXRGOwozfeLcOAI+Ysg8g6PLpmMwm9kYHvQgTwKKXfUk
	yhNADkVmC1HAsIGdmYQZQAppbyWmKtUtUkorsSxFGxQc02jUeBPQ7fb6rDqV97GQdKc4uh0AjOJ
	3tWZpCtZvet+wqJv3kCQnpm871fK08zSxSNuLFiu7N74kltvBtbsr+touRXvPVEtULDef8PoPEO
	VSOwxdbzB3+CnLeFn+DCPdOvQsPlhXlqt3sNSmrK/gEua30A0utX/oz2/VkbL5+doxpsf/lkqIV
	j8lzgNbamttk5+rL/b2cEBEfvo635ZkqOgcKYIfGwN3wO1xoZ/xgmIpMKcfPEMx/7qXc4R/kfM5
	aH0s484LjzF22vogF9hKFv9xfqKUq5U0wQ==
X-Received: by 2002:a05:600c:811a:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4b963c82e21mr76267775e9.29.1794239105633;
        Mon, 09 Nov 2026 07:45:05 -0800 (PST)
Received: from hp-z640.fritz.box ([51.37.204.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm257163645e9.5.2026.11.09.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:04 -0800 (PST)
From: Owen O'Hehir <oo.hehir@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 1/4] dt-bindings: rtc: Add StarFive JH7110 RTC
Date: Mon,  9 Nov 2026 15:44:58 +0000
Message-ID: <20261109154501.63762-2-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109154501.63762-1-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the RTC in the always-on domain of the StarFive JH7110 SoC.

Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/rtc/starfive,jh7110-rtc.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml b/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
new file mode 100644
index 000000000..a88ab91ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/starfive,jh7110-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Real Time Clock
+
+maintainers:
+  - Owen O'Hehir <oo.hehir@gmail.com>
+
+description:
+  The RTC in the always-on domain of the StarFive JH7110 SoC. It counts BCD
+  time and date from a 32.768 kHz clock and has an alarm, a frequency offset
+  adjustment and millisecond and one-second pulse outputs.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Millisecond pulse
+      - description: One-second pulse
+      - description: Alarm and calibration events
+
+  interrupt-names:
+    items:
+      - const: ms-pulse
+      - const: sec-pulse
+      - const: rtc
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: Calibration reference clock
+      - description: 32.768 kHz counter clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: cal
+      - const: 32k
+
+  resets:
+    items:
+      - description: 32.768 kHz counter domain reset
+      - description: APB bus reset
+      - description: Calibration reset
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    rtc@17040000 {
+        compatible = "starfive,jh7110-rtc";
+        reg = <0x17040000 0x10000>;
+        interrupts = <10>, <11>, <12>;
+        interrupt-names = "ms-pulse", "sec-pulse", "rtc";
+        clocks = <&aoncrg JH7110_AONCLK_RTC_APB>,
+                 <&aoncrg JH7110_AONCLK_RTC_CAL>,
+                 <&aoncrg JH7110_AONCLK_RTC_32K>;
+        clock-names = "apb", "cal", "32k";
+        resets = <&aoncrg JH7110_AONRST_RTC_32K>,
+                 <&aoncrg JH7110_AONRST_RTC_APB>,
+                 <&aoncrg JH7110_AONRST_RTC_CAL>;
+    };
-- 
2.43.0

