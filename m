Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C43C10BA
	for <linux-rtc@vger.kernel.org>; Fri,  3 Jul 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076694; cv=none; b=aM78ZDWRahbFetjf7gFDEi0a3BcMTAhESfVIFE5dOyVg8CfWENRDkvtr+PVtmh1lJbn5vLjIG5Z/pEuvc7YS1vkTmmiQN+uj2SuAKC7Fg2nYmmsE5H4TM+CaUiaqQwt2z4faOyydDWexdNlZRIglIBpb+I1Rnt00UP8S5LmmNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076694; c=relaxed/simple;
	bh=2bwIeurjrwcJ7Zm3CalIaF4vxwIad5ELnF8kDfq5LLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EfXRR2Wc3/2zWFtuwNXLpEoK5cNQKpyuaVbb5QpgSmh3SF6Nj+qnvkMlHTj7aLnHmbkcD1W+F7QhZfHOV39b2exAOIB1ZVQLy+tXCgsCG/ibMBx03FB0tS6fb65BApGoDXRDiEG8i2EFGP9p55wMpxr5ApjGrSY7lh6sgOUwc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsBQMecf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsBQMecf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ca70925c25so4798835ad.1
        for <linux-rtc@vger.kernel.org>; Fri, 03 Jul 2026 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076692; x=1783681492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpsnXMJdrQZ8qB1ySVBl+GeO+mABbCy+9MxVxzg46jE=;
        b=IsBQMecfnBvhccLxP1hg6/H1lU2qOcAefy/70/QF166C4FKPWzQg8WJlYTq0WJoDu3
         6jSMKO6+WEYmzEf6rztaZW4WQpmcz4ke7hcCx4YVYcGzWJpWyhQGIlwsGAU+q7ou455o
         jMxlNuzsIJlEzAXBm8xMb1Tav7BmGVv37Z/2LhjR1IsQvxP5Fgg4QgIHi0HV9maBBI/r
         faaUruVsr7JMKZs7MGvHuewalrzOxVO0fXMONu/lMo9VHUvd5urUBgMxPq6oGxT77qhf
         p/S9eLHHknvOGbOT3D8/aUK7wuwOan8nVvgc5iiRCCsyFNQDwBjLFOsm7qsb4mrwgaYI
         TlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076692; x=1783681492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpsnXMJdrQZ8qB1ySVBl+GeO+mABbCy+9MxVxzg46jE=;
        b=Lgoct6z697IS0dRMZ0qgXoyP2SjtVDAz6oPoKdck4nwyIdI5TVwxNHPCLF3SyoTUCe
         QmxLQv/y9NMd72UUJnnb+ybPwODOeSBC4m6P3GYl/foHPyRXJCRnv/lDGreQpEy+6V+P
         +t0EUi68NPooygDYD5ZqSbNvqGLOHFrWl/bGAcfXHXI8JxHfnioQGIVCVr3GKx9/foEI
         0YItw0kOHm3ZVm66FY5SbInez80yZAolji35V0M4rJSfiaXIJVgTokCUi3nx80w7w+ja
         vt1Smh9ixego14Vlp8QnyE5r8QNZ/4HS3Vtp/UXrT4iJG63LPp/S2k7SOwbv07WtErKs
         G6wA==
X-Forwarded-Encrypted: i=1; AHgh+RrKTCRFODZCcTDahTL9NE05r+sQv52pkTpzyY3ztBXMIV2QrN0fF7fPTM1wnZgYfQrLBDi7KyLA73A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ePlnaNHceObqQ63mAVPSXMaiOEYlrXyg4EC0FzNzbiMw6Z5F
	Qs0LmEB1tAzl8909GcXmG1ZtTz/BRlNqcPWUTDS2Mt7F1yWi/tueCIWu
X-Gm-Gg: AfdE7cklbwnRjl6L/rboDaUWjUCaidT1AtBMmENMdEs57LNqYCM9if+5ZZArgAtDhya
	tlEfEZPWzSW9CgFrItNyQyg3C7YZxy98pJSd4zfkM4HXJPMmhit9wgelHXOgv+XoN9sArqucfyq
	y2ODodepVk2gwhwVOSp0hOhAX7gPKZQm9hKxaDNvbXyAL8c4ne3hEoW+wawQk4az3iuSpFckRwz
	eHFr2mrHzvmJuTjJ1mxSTx0nGy+FazlVc0cn5Lf39MxXSNVJBXgqBzDUGrg24/pOsxJRcocBZsx
	9nLsPiS2CsBa7bMtLHVFPsc+Ua93vJC5tzNlO2ivjBdrDvSpgP8FdGnjUF5tTO8yS6y8jSCQMRQ
	Dnx9PdL27QYkGY+1eOkXrXCqwA7g1CU4SxGJS0Y0auFAGT1OzbjQOTm7udYYws9+H2BtjOaUwzo
	Ho11PPwVf8118RYkJ9a9w9PghEH4WcCTs/fZP9O4ul0Q==
X-Received: by 2002:a17:902:b40d:b0:2c9:c95e:5836 with SMTP id d9443c01a7336-2ca911121c4mr63685395ad.5.1783076692114;
        Fri, 03 Jul 2026 04:04:52 -0700 (PDT)
Received: from inhnjlux1020.ls.ege.ds ([49.204.164.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789bf65sm7765165ad.79.2026.07.03.04.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:51 -0700 (PDT)
From: Udaya Kiran Challa <challauday369@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>
Subject: [PATCH] dt-bindings: rtc: microchip,pic32mzda-rtc: Convert to DT schema
Date: Fri,  3 Jul 2026 16:34:42 +0530
Message-Id: <20260703110442.205026-1-challauday369@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Microchip PIC32 Real Time Clock and Calendar devicetree binding
from legacy text format to DT schema.

Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
---
 .../bindings/rtc/microchip,pic32-rtc.txt      | 21 --------
 .../bindings/rtc/microchip,pic32mzda-rtc.yaml | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32mzda-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt b/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
deleted file mode 100644
index 180b7144bfcc..000000000000
--- a/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Microchip PIC32 Real Time Clock and Calendar
-
-The RTCC keeps time in hours, minutes, and seconds, and one half second. It
-provides a calendar in weekday, date, month, and year. It also provides a
-configurable alarm.
-
-Required properties:
-- compatible: should be: "microchip,pic32mzda-rtc"
-- reg: physical base address of the controller and length of memory mapped
-    region.
-- interrupts: RTC alarm/event interrupt
-- clocks: clock phandle
-
-Example:
-
-	rtc: rtc@1f8c0000 {
-		compatible = "microchip,pic32mzda-rtc";
-		reg = <0x1f8c0000 0x60>;
-		interrupts = <166 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&PBCLK6>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/microchip,pic32mzda-rtc.yaml b/Documentation/devicetree/bindings/rtc/microchip,pic32mzda-rtc.yaml
new file mode 100644
index 000000000000..481ee28c06e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microchip,pic32mzda-rtc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/microchip,pic32mzda-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32 Real Time Clock and Calendar
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description: |
+  The Microchip PIC32 Real Time Clock and Calendar (RTCC) keeps time in hours,
+  minutes, seconds, and one half second. It also provides a calendar with
+  weekday, date, month, and year, along with a configurable alarm.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: microchip,pic32mzda-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@1f8c0000 {
+        compatible = "microchip,pic32mzda-rtc";
+        reg = <0x1f8c0000 0x60>;
+        interrupts = <166 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&PBCLK6>;
+    };
-- 
2.34.1

