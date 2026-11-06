Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987768;
	b=U37VHfm3j+sXtlIGnLHmysHG1mmzGak0+RMHRLdPmyRsZ7dbctatmMz8Fnm6fxzU3lMO
	 M9xUbZf4rIIrLkt5kfpju4/82I+AkSfCeiBAxHpYNFyiRq6lpuVwzZKSurZekJ5wwErGo
	 Uwwmw17SoVXmmXoS39ICpnr2rUsHgIao7Wpk1g6vKbuSPYpcZEW8EenDsRCC1K/3z7U4Z
	 90HjNr8SMvwe5pUIygJYobI5GwZj60izv6DMhP4MCn2/ddKNNKB/rfW+hv5UGKan1dOg9
	 +jowqDnothw8WLILuRzP8wBgZGwO7TYdquDxnXRkdfwZStrq9+F+f0FSy+kw9HDPV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RjB3LwZzxEuGJFQm9nKda7FlL6d4DBHlBEZNuNA4128=;
	b=UFRrXkaMdVWZxCU6UkBw7wfo3mLHlxivBditBexuZaomJJkvY1rVrKz+63v23oBJI/bE
	 lHILEYOn/givt2lXqhB3vf+RvzHmBl+tVfi50Oi7n1rNCKoXYzWbvrWkeeD9M/TF8Obph
	 bwDO9sbq4fv/AlX4R5ZE/dGM5A1EE3Y2Pk/DiXevBWHCFvsnZCDTYCaAossomCy1rbOU8
	 hzgSQ4uYpVnc4oDRlHf9QAgySiQOLrCnxDCR7L2q7rTgd12VsLA1HD3aa+EFlMRx09uB2
	 gTrgZOVT5kGvfb7kKhewBh3nAeQk16KeKZ7RGyXF1XXq9eB7irRTZYSImTiR0zcJO9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJ04Jo98;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7ED606A335
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 17:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA7ED606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJ04Jo98
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491846221ffso816998f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 06 Nov 2026 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987766; x=1794592566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjB3LwZzxEuGJFQm9nKda7FlL6d4DBHlBEZNuNA4128=;
        b=JJ04Jo982Z4RDDmlzz+Dje1vhQSA5oqF0L1kZsorXI54ruOpMg4NkVjlSr49EflGuj
         GlR+1KATWJjd+j/Cebv65TWQmQfFY6LyFSqChNdhiitwEAODefziDW5Q9BCVxv/cPend
         AOg0G7VTygcfJzPilB4kJxNDk0+86VXyu//dSGE25pjefslfXz3xTuHClGDSkv1lulG+
         iuDtud1D5yPTikZaIHSyODzc/Dq2uZ/ZWiBnQJN1CnVSZ5dkEcu9Y10LLkhC4PPgI5zj
         XUH8BLHuEyuPS0R2E9X1vhPb5XsLSMpVo+0WF1/xdsPseFoUHvjPl1LmgQrcg2gQM7yS
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987766; x=1794592566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RjB3LwZzxEuGJFQm9nKda7FlL6d4DBHlBEZNuNA4128=;
        b=xiPsZqVi1UbG5XJb2m2+XwMIRdR/JZMd2eeLieLx/inLrfiG/YvKcw9Y9F5zVrILpa
         yc2lhXumeDc9yVjACWQ+BcxoFR3PuKIRfmkciuG/5K1Fv0BLh6L6O2cwwjkwMYC1gPUL
         zFUUi6OunSy1QekjtkTEPJJj2ZEYxqoMD5GvK6TLeYIoalvYtR+vWNV2xKBHxvYs71g0
         Mxq5+13y0SkqfVz6LQRDUt6ACUBo4nJSjTZUSTRXIkZ76j2UvHCwnAfcJifvTIB7tLnq
         Y4a0YYYIlLvpiVpdxbphhRINa13heIr1n+zdcJ0Gm2/6clkM4DVnzjQqvxs6S9WtW/on
         9iVA==
X-Forwarded-Encrypted: i=1; AL+hErHgj1ClZjr8rg51DQIAmqVxLgn8aqWUIBACpMUiUqkDd0DUZBW2opX7cfWi2OXSZpfNM3JK/JBb3iA=@vger.kernel.org
X-Gm-Message-State: APuU4Z86qtEyJGztXKTqNogxXqKRI5Wj05sLnffBwAgjVWCtrhKU6Y/B
	/VtKijbQ5sV745TDpevnZ9aoKoC53JdGEJWWKCNf7vilLemjoHVBoVAi
X-Gm-Gg: AYBFou1DcbTmgiv3t3DJjs2jUTXYnfUsAsg/uKX3aA07nsbFI2YfKjGEjlMMZm2foZ+
	HiEIgMlfbTIg2ZvbaGNetrEdjpUuNh5jmjM8tsujPhmX9yKX3dQVvRm3ZWwi1tL3CjRW27zhGps
	OcoPuDFO10UEtWLzW2zU1hfhYFZ4+zSuIksLdXt2CjTlpVpbqLTdHFM0YRquNYy9Otlt3NPEf8s
	y7/jq3u8+9ph7QAJthCf3LnAcSCcZnKZfZ6PPfkwuDXa0Ol43PEUV08emG6eJqNOyyAcIucZK5m
	cZ6DCbfKrDdRIt1BZbd+I5IHN3AWcrR/uMAJIoRn0ZBWatgKGhP8k3bnhdcI0W4zvJIJo7aJpOX
	ilwSzJXQKgJdtuRKKU1l7ioi68b8PtC5ZLlFTLAu1PxIf1fRXZ9X6IJeRemYEOXs1r+Ta0kCr7d
	6Fx0T71G+K1UzEc68JhQmMuWkJgUxPO0Gj+SwWsYEHIG1vfLloPh4h8P3A/LypNmFluHjNTClnA
	g5pfDHavJsP/j9ewce1mKWh1RHPG0mGw3KwLRuZqyW31kh+QmONmMQzYPzfJrXrs7BSw0I36ctk
	1jN4zuGn1gzHPnthLqBVQXJAQE4Jkm8=
X-Received: by 2002:a05:6000:144c:b0:490:88e5:92d6 with SMTP id ffacd0b85a97d-49277f881e8mr7918178f8f.49.1793987766143;
        Fri, 06 Nov 2026 09:56:06 -0800 (PST)
Received: from hp-z640.fritz.box ([64.43.161.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723283dsm4649612f8f.23.2026.11.06.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:56:05 -0800 (PST)
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
	Conor Dooley <conor@kernel.org>
Subject: [PATCH 1/3] dt-bindings: rtc: Add StarFive JH7110 RTC
Date: Fri,  6 Nov 2026 17:55:58 +0000
Message-ID: <20261106175600.3877614-2-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106175600.3877614-1-oo.hehir@gmail.com>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
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
index 000000000..95edddea1
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
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
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

