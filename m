Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173314;
	b=sSfOrBsUsFvnqOYYbNsE36PbUhdAiwDiSsZNYAR2VuZSHjpqy0wu3eKV7kxSskXBZ2L8
	 KalqPrJOE+5/AE66Wx602fbnenBsvF0sEcr5MaEam/l3TE2Vzou6LrDcYGaY150q70N1L
	 wTg85K/QK+ggl5DKJ1faOU81QxzmovfKK96bIwbmbIdjB+7/cUq4FallEl/RX2WMNVU9W
	 cK01R78xTSnpuAWnciUAQ+kdrb9aPncMJ3KJwudRyd2526QxEKkWZeDHy2LJaSvDHDO2z
	 hbrPan9La2x+k65f/WhYix+COgFmT+kk7btgesEq51xxOODsbfBASivm42E7dBmWUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QXRVCJ6p53mhv78a1V9znscskgidqnRubCEiNV0CGUQ=;
	b=iWoYOJ5nAX5ZDSvHcsrSRg9PY0Pdox5i2dOfZ2cA9H+UeJDYmJHR5kqJWu5vUHWSTDY6
	 vGHp55JLZ7FzMvLw38fdrxk/pCw9j3EDs8zhOIAQRWR6gey2weGmIJJvlHkkwEVHSP6v/
	 nUPWqaLhlH4uTqAnlPEtmReTh84pDKP5aWQnwo3jZ/zs9mmBFlyfFChk2iKb6tYa1e9YD
	 TxAeqncE6s7ep7Vvx/g3QyxE1eqT3ZKpjRMknHr2fRPMnxcBH50iLVgW/UyfHgwGNaq8y
	 mySO4z7nJQZ3Y53FNEaCJ9k0OWuj8kQ1AQazfuhd721RlWKsvz4tclhircyZil/fQlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XL57eWKD;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B1606A326
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XL57eWKD
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491971ac844so258577f8f.2
        for <linux-rtc@vger.kernel.org>; Sun, 08 Nov 2026 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173313; x=1794778113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXRVCJ6p53mhv78a1V9znscskgidqnRubCEiNV0CGUQ=;
        b=XL57eWKD2uSIcrWKMYH6JeAdiayS1nITNSJ6dRBeiD5M1VHBITmr+3boaUCWUOXPfS
         fuhPT0Cm+8KFc9DJY+p6tgTcg8cgRE/GLbzcbZkJJWbJCEw/g90pwPxX5GOKeAZLEjAn
         WkP7dbiM7+YTF4PoAZCpF6KznK4QsxdADNm8cN5YrAr0Ae8FzEh9IgeIKCeWTLcfcBs+
         Cajlw3AAq9MoU4zlV9JI6ne05Tn9tMTd8KoP8OPLVRQMGj5lI09Xpt0kx96GE0QvCvjJ
         sb7J211O3xzW632+9Q6m2vjahMDfgUYE2mLdSzb1ErY//CWCF4glgBju2qPMgXhJNiRO
         31TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173313; x=1794778113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXRVCJ6p53mhv78a1V9znscskgidqnRubCEiNV0CGUQ=;
        b=Bmd9wFFP9qMBD9XwlJyjx86nY4pRiJ0H9xe50FOKvuFLPaJqD9LrUdGqjLotXAhSon
         1+9QgEsBiYnLSE0OVP/IOeT3Hejg4BuEdqQTIjSeaQUL3UV415ZCwGZ9GK5N8RvceMZJ
         6Qi1kBXX78ZHqJoJ8Tw4zr8sg+i1qEiXLpnVI9G2fai1DvZTSDa9G+kTzSYWyoA5OOfk
         KgnE/x/oWbwBi8Lr3cfNEA/cOXtusAOsLC1LVNX9tBy2EIEKqbnbRCOrdzC7bY3rbCab
         xgFNAM+Dcjbva/OUF4+s+i0Ucwwh7aIu46DRGdFPKnGUdStLRdNwY+gtQnUZNjzULTZ/
         KfZA==
X-Forwarded-Encrypted: i=1; AL+hErH7x5gllzPuCjUvNKDg8RqG3qhWlFEghsg1LREof6OiJ7Xnqq8IcGLDEpJtRR5PWWs74KMj/nr1Sso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qDFMhlopcR9NgrzPfzCsRhoRmeyk3p3GEMXqBNqhnk9kgiDYW
	772vL3o2wuuk0ErDxhD0M/lk9ySqzb17njak2Y9GO4egfzP6Pa8IJ3r0
X-Gm-Gg: AYBFou2ZHgbA6dRqN9UHTIQoB5zyz5JVYsd85jA/mkjEyGRMBfQClKdkn3QYKGZqVpi
	b3VBIvyZzRSBH79aSuZ4alKbPF9HihRmpmCN6JS6fXf9EsXBe3pcOEmdRleQguTe7/FvGD19dRk
	fKeQePR7htQJ7v7u04oP2+E+YpYwK6Sqmcow1DcK+LsM8d64IMbc5qQQHJqlsNU4ONT6nRTZO7W
	Ffg9d5jdFjJK3qiUhUs53lB0jr73u/kCFXVVCOoGybl21W2YctGKBlklcBF+6NmRxHJcfH5YDt2
	AkyVIJsAcsM4O4wpb2/0FRsCJbj7k6vVkgHKbu+NySQTzZD/4BxubF2T2Xi2x2wSTAmwbjOTRej
	nJ3LNheOMfwSys6aSBP5CH5zfraeTaCoQcZ84+UiIOrUzlOh2eHmyJ+yKOFTVLHiamgWJ7JM965
	W1VYtDLMw7055m/PlJ38gVYXa2pMqxXulnoZFmrbBSOn0yhiEZxybrWxranzeW2RqrL6I43t5BV
	ff9ZkWKP4ZGawKIJgFXCGd94daQT3OQW53yQy6FJEJSRijHV0//osI6MFZNvBsocQ3mH7qYNDO1
	6rlGgOfuR5oBR3dieADZ04XnX+BJ0pMNYA==
X-Received: by 2002:a05:6000:260b:b0:48b:108:48cf with SMTP id ffacd0b85a97d-495844a312emr4255528f8f.25.1794173312645;
        Sun, 08 Nov 2026 13:28:32 -0800 (PST)
Received: from hp-z640.fritz.box ([109.76.148.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597091400sm5692050f8f.32.2026.11.08.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:28:30 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: rtc: Add StarFive JH7110 RTC
Date: Sun,  8 Nov 2026 21:28:23 +0000
Message-ID: <20261108212826.15890-2-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108212826.15890-1-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
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

