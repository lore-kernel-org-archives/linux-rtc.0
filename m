Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371C329C48
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991544; cv=none; b=usVU2DE6sacBw4x21DNaQmqTWBAuCLkw1u1wix5HjA4evhK/CtTNgyconOPBVoO1R0BEl6E2vxCTAnLmV60JNDyJ/gJSuXS9KsrOPG5VxshBO8SQW0q6jIPesJ1qw2zpy/j7F+vt7bAFa99JcVUgWZ4y48scQiwm83bqu+ErNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991544; c=relaxed/simple;
	bh=Hjl8YUuwI2RUUAealAZ//gciV6VVdeB7BO6O20R4EvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIjsrOdP3M0ynMAWmEFTGGsoYz3FLIwnptRHrg7ad5Q7uRIa2KObdOn1fGV7FxAA5u6qCwKLoCFaq+zYHyeBR3eYsOALgCnhgCE+HQGAEPIi0MS7MPmK/jPSwDpclWXa25uYY097qw0UlbtzWs4uvcwH3DA/Hipbv7Ok1SeSPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gneozfZS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gneozfZS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so8002185e9.3
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991541; x=1785596341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9mT6kRYYeY4OTXZcaA4jx+EmFfcw5jGtIIdRPmXoAE=;
        b=gneozfZSGR8PuRUgrHYGNEoO7yHN3tH1wIm6hbAkDyN44LX3riKsIZfOdeez5T2b6m
         OQgt9byQ5z/kdn48bGRCXPPFaZHMIIYO/56WW5gtNdP7sjAqwS0yhI2F8qAEUIzkv8Ve
         wBqiOgU6IkflziOJjNF6OJgAzPs0GG648VUE2jBkm703gE2QdGA4CB0/6CjaCGtTyZNJ
         wmjgPX5PI1ivfLh2+xtu4AZNVmPI1cj7apCwqVXHuNm9cNEYW+smMtsYbPIwAvgIL0+v
         IQ3aj6do+uHhplGnWfsfF9ou6jIODFVdpaYFtrTP7mLENKtuhX0Lam8psbjgKeMjf/Z6
         vz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991541; x=1785596341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9mT6kRYYeY4OTXZcaA4jx+EmFfcw5jGtIIdRPmXoAE=;
        b=eJVP0JE9ax9U76fobAyodov9jTdh/lH7+bsXsYHhv7+kkChI+cXe/eOHydQDuxEu7Z
         NkttNFWhbbWnIJOKPMFBHbii/5RWlvJ7eetw3pkD1ID5peH8+TlHi4nf7OTtc/IqiKKC
         uLCdDTaYbuoG7Yewlh28asmUXGCwhpQpTS3e9HWm/8z8B8zRispNvS2cgW7t2fD5AHNI
         po7dJbsWyJvkOm7lcms6CMN1t5ELkxtEexzYCqbx7rkrLnstsmNhT/Wtj2ko7wWmSAxX
         b2irfx8wRuRI2oJMBsFftjTAxzwbuYbYmGYUkXO+tnLT6xa8qYh3aFuLEHT0I/l9Aq2A
         LCbA==
X-Forwarded-Encrypted: i=1; AHgh+RpXXwDx8Bjm/6A2NAJE17tuYaqPzx5OrYqLGo8bK1mQciJA85C/V0ETTriY/Ljwim0WPyln2jmh3Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWKRfhwispjSwjs0PwCPtljoSs6b7em8P0dnK8VuCFs2SRqQ5
	Vp0OVE4JiLXeF6iBCbhl4UKcmTSKQ811vSKuFbtnH53cPmIB/bs9Bk5Y
X-Gm-Gg: AR+sD13lY1Uqez/gaYBQg8Aq02G7pt4hyVv4vCsTXDQAsBHa+Fch9XUrFiTW5Ddi1Db
	X5N3LlWHQk3tINRW/PmvHr0A9yEK6iso8uCJEbmUuC3OuoIIVi4usNw7837epDW+JW+TWOwrDrk
	BcKXFQqZMYiAw7KrjGwiJH+JsSf6nqqcGzf9+rBEE9wgJ3jFHcLzn/2/J3qHNo8gt/u6dGVz7QF
	2Kxfwz6XqgFFfctKsbcON+5VW3HIo0qzrnFH58tK4xjPCegSz9n2rO9Wx/8WGQYpDZJ9EzjXPFw
	bUMRJApNlWJF75f47BKoWXvo7lW/hs+HW63IOokM3NOatjbJWRtC/D1a1CaG5olnGZNds2O434J
	Ifh2xdIUEi0IchV8yycfOY6vr5VWQKG4Hi68N4ueX+VRU/PDbsOIP90dXxppU7RVUcWJI0lwplI
	VS3A==
X-Received: by 2002:a05:600c:1906:b0:495:6b8a:5227 with SMTP id 5b1f17b1804b1-496b56ff17cmr33776335e9.23.1784991540815;
        Sat, 25 Jul 2026 07:59:00 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:00 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 1/8] dt-bindings: rtc: abx80x: document ABX81X RTCs
Date: Sat, 25 Jul 2026 16:57:11 +0200
Message-ID: <20260725145718.14733-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725145718.14733-1-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abracon AB0815 and AB1815 are RTC modules with SPI interface.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../bindings/rtc/abracon,abx80x.yaml           | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
index 355b0598411a..d105570bcd5a 100644
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
+title: Abracon ABX80X (I2C) and ABX81X (SPI) ultra low power RTC/Alarm chips
 
 maintainers:
   - linux-rtc@vger.kernel.org
@@ -21,10 +21,12 @@ properties:
       - abracon,ab0803
       - abracon,ab0804
       - abracon,ab0805
+      - abracon,ab0815
       - abracon,ab1801
       - abracon,ab1803
       - abracon,ab1804
       - abracon,ab1805
+      - abracon,ab1815
       - microcrystal,rv1805
 
   reg:
@@ -61,6 +63,7 @@ required:
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - $ref: rtc.yaml#
   - if:
       properties:
@@ -73,6 +76,8 @@ allOf:
                 - abracon,ab1804
                 - abracon,ab0805
                 - abracon,ab1805
+                - abracon,ab0815
+                - abracon,ab1815
     then:
       properties:
         abracon,tc-diode: false
@@ -96,3 +101,14 @@ examples:
             interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
         };
     };
+
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@0 {
+            compatible = "abracon,ab1815";
+            reg = <0>;
+        };
+    };
-- 
2.55.0

