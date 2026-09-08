Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F755A0ADB
	for <linux-rtc@vger.kernel.org>; Tue,  8 Sep 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894053; cv=none; b=kZemgzq2Neyv1umHPfAw86bKtveKYC/ITqRHkDyGKJGk0n2Hhspz3SGv04SwOmZb+mWi8ntuJPPqK59EQt3QW1y4ZWH197rxVbrXlmiKWWX/bD1TfqsQb032XV+V4rlDS+a3SlrlVVJqQO46kEv5B2ToVpW9DNO2Dx8vMmxV/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894053; c=relaxed/simple;
	bh=ESLv5L+E1+ggTkF51IFY+k17qh7UMpZrmc1b1Q4Bu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5wuNT5fE5ji2lQl5GVEUH5n68Kw/46qGvS4PGMjqHMRBn3YYk6sbA9Zq4d2xeqGjkp0SMwHjQ1N3Axe4TuSt47PHIL9CQxRS0YJtP0/nxLSuRX7U1uHHTk5qJPJtMz9ZijTI5MfuoJWsiSitXZK0dkwdUwmueeV/PyXRFfdsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJVwXV0L; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJVwXV0L"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1976117a91.0
        for <linux-rtc@vger.kernel.org>; Tue, 08 Sep 2026 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788894031; x=1789498831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/3+KCQzTKA9dA4hix+BprsbxqkXn39e4T080FI7K0o=;
        b=GJVwXV0Lr2HnAFeEGbYWgg+kN0NpJEWcxJ0wjVuzd9tZP2XxfnTg5KmPPxCnkjX3Ca
         9pzEYuXfrp78dPzSKI/Y3iI6tKNjzqtK+vs6OWXYuzi8DbEH0uRqCdnGt2VhHW4RmPaH
         3KH1+349GoxyT9OSivAlDZ2yWgkuhVnBRWwj/QjaqfaAFvcOCv5teCqCPxAwayOF3ik4
         /yjH9OhX4HD/36EkddsJgijx3qARYKPY8Ib9ewH0Sti0YsI5qOfyURkCbYfLs/DXUwy+
         5XRN8V3uPfpZ36WvOLifmoWeybvwiJufI/qOoovW6YqVHkME6i/Ie2TdR0+FCC/ZJzzH
         JNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894031; x=1789498831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/3+KCQzTKA9dA4hix+BprsbxqkXn39e4T080FI7K0o=;
        b=r7/XazGtto10BcNIPoHc1y9p+ZmWsHnK4hYXwuvRIlpTZAzit6gt29AKXb8mwBQTXE
         x5cWGGVYG5GS465z8W3BbPWM/4TST0cSpSGq4PS7oABX8DXVyyV6PEI7dvNwOZyg5z1/
         HmJxyXKtwCM1rqeAmFQ3TwRu5TUSnsV3ScWq8rCkF0YMykc73Ag0pgXHMVEZEXcTAsFD
         bteTOHxRn+HHy+xlhW9AcrDv8A94gOL026dw5uUeFpDzQ9Npe0RMqVrkZyjODeinlIbD
         vtBOaw0T4zl7mlIjijMkemRAohWIEpg9xkEzDPaDUOvw0v+J3MqhZ0cRpDNuBN+qWPzs
         dG4g==
X-Forwarded-Encrypted: i=1; AKwUvBwpU/hm3XOiiHzcwWNPZnDD7pOywgRQXwnVpDllfORLpLC8muVBboU+p/bUDQ79ZACytbjlCI3J+UU=@vger.kernel.org
X-Gm-Message-State: AFuF++k5eX5s24egWIR8hBRvvsZ2223KI1ITFW/pkBc1Qqv7aPspILVt
	Fgvh/sKZFrNpKgvDIY9R/DXj9kR0PlRkYpbXc3qyQICSV6fn+Q4MxGH3E6zMMoN4ULo=
X-Gm-Gg: AYBFou0CbppIbh4goTI1rfdUQsGAr38djnrGD70jRUAJ2JJPqbIZm+rll5ovxn7Jwwo
	A9kiQXHseWnjctR5zT2LPJaRodnjIssP8LoRe6ihEl4A3E3YGRIjFHM4fKjeta1zyYR3p2RaY3q
	p98dTSwr3VYDRrWseKXgTM3Xuz1uV+b3xYzP3H+xfUOY6t8bbBdliJrDmdV/DTw1/+T5dZPMOoQ
	hu9N9AimNBq8YGeJ+CSIzyN+lawDt2lOIf45PXScm6yov4Pl9V4muC7bIy07yUbveT9NYqjieox
	HMr7/39bvUr5qO8E8QPF2fwqVJuzCrjP1MS9DfR/nW4d7M0OXQqGvJ3jOwIpZSVZDZo0oP7QXMt
	JtfC2YEQP6XaY8W85YA5nMIUp2mVZbTNpSkoGUFSlKQ3R2RqdtS+zP8t89BSLrUNl2klNRVdoBT
	R3I7drCByKQIdyFZS6lWjZwCDobahhmU/wcJgBm7VHwihl8ILy7MWjO+I/QxsY9HtAsTr9qgMvv
	pMoRE8RwcVuaVSxdBneS8p8HJ51Z0otEsU6kmVs0Z/FwxS5tmS8XVP5HGGL2HTaNqOlhSIo+Q==
X-Received: by 2002:a17:90b:3804:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39b25f4397emr46524869a91.0.1788894030484;
        Tue, 08 Sep 2026 12:00:30 -0700 (PDT)
Received: from samlap.tailb86931.ts.net (c-24-5-101-44.hsd1.ca.comcast.net. [24.5.101.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19730135eec.20.2026.09.08.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:00:30 -0700 (PDT)
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: alexandre.belloni@bootlin.com,
	ynvich@gmail.com
Cc: devicetree@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: [PATCH v2 - dt-bindings: maxim-ds1302: Convert to dt schema v2]  dt-bindings: maxim-ds1302: Convert to dt schema
Date: Tue,  8 Sep 2026 12:01:37 -0700
Message-ID: <20260908190137.1168904-1-giveback4fun@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Maxim DS1302 real-time clock binding to DT schema.
Changes based on code review comments.

Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
---
 .../devicetree/bindings/rtc/maxim-ds1302.txt  | 46 -----------------
 .../devicetree/bindings/rtc/maxim-ds1302.yaml | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml

diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
deleted file mode 100644
index ba470c56cdec..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* Maxim/Dallas Semiconductor DS-1302 RTC
-
-Simple device which could be used to store date/time between reboots.
-
-The device uses the standard MicroWire half-duplex transfer timing.
-Master output is set on low clock and sensed by the RTC on the rising
-edge. Master input is set by the RTC on the trailing edge and is sensed
-by the master on low clock.
-
-Required properties:
-
-- compatible : Should be "maxim,ds1302"
-
-Required SPI properties:
-
-- reg : Should be address of the device chip select within
-  the controller.
-
-- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
-  and 2MHz if powered at 5V.
-
-- spi-3wire : The device has a shared signal IN/OUT line.
-
-- spi-lsb-first : DS-1302 requires least significant bit first
-  transfers.
-
-- spi-cs-high: DS-1302 has active high chip select line. This is
-  required unless inverted in hardware.
-
-Example:
-
-spi@901c {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "icpdas,lp8841-spi-rtc";
-	reg = <0x901c 0x1>;
-
-	rtc@0 {
-		compatible = "maxim,ds1302";
-		reg = <0>;
-		spi-max-frequency = <500000>;
-		spi-3wire;
-		spi-lsb-first;
-		spi-cs-high;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
new file mode 100644
index 000000000000..54a2fcf7f8e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim-ds1302.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim/Dallas Semiconductor DS-1302 RTC
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Sergey Yanovich <ynvich@gmail.com>
+
+description: |
+  Simple device which could be used to store date/time between reboots.
+
+  The device uses the standard MicroWire half-duplex transfer timing.
+  Master output is set on low clock and sensed by the RTC on the rising
+  edge. Master input is set by the RTC on the trailing edge and is sensed
+  by the master on low clock.
+
+properties:
+  compatible:
+    items:
+      - const: maxim,ds1302
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: DS-1302 has 500 kHz if powered at 2.2V, and 2MHz if powered at 5V
+    enum:
+      - 500000
+      - 2000000
+
+  spi-3wire: true
+
+  spi-lsb-first: true
+
+  spi-cs-high: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-3wire
+  - spi-lsb-first
+  - spi-cs-high
+
+additionalProperties: false
-- 
2.47.3

