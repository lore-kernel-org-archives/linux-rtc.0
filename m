Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E7440A37
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390808; cv=none; b=YcvK22pQSGoYW+E8dnxLfC4uBuvu6+aQd67iaJprmmuGq9RDnCEidOlRz7JXa2NquE8aMDWZDFdUJ2Jq+UtscBe6A7UrKIH9ed3H9KUxNd/QNi0+oDQkdNWfsC2jy6G1yAfHhxqlHb3hIQ+P00j8nAgSFyGaRrnfJWe0fRfGfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390808; c=relaxed/simple;
	bh=JzPmVao8FK9SYW6EqLoAZ+WBysafs2v13tUyYWLjmGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh2TsnePmSdjaawRqo1PTeQNUUZfgVGorEx9wgoG8k1xVyDwjOgCiuZ45mwccjtXp3PHcKcRzsGd66kL1B8uZpOD48OchCAuWF1mllpiu4ZwEB3ocAK8k9B+B277FCOkfLkJPnc5IhTkn1napXam/HBS7AqmGnN6fM7bB5qm4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRiqn32k; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRiqn32k"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fecbb7000so1128186f8f.2
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390803; x=1786995603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=oRiqn32k6oLtpfvasTlQQ94vOJYKgcPdhfEYrxUlQUEQXwDOUW1CD7dSjEppgzm6AE
         sMrMbymsS7WkWZwNer0MMKpdvW0mOfuoMUXNHL59uBDw8jYB5Aqk7vcuMoVUB01p880f
         GGAJNKu5SkEAxr0QpNOWyWnImU8sWbA8viLdRlGvN5zlPB/hE7wJBNO3qOADh6N0SF54
         ZrHkTnacQ3RgOCABQfthwuDD5qDeNNTupGbxouP537tTYNoiu6p1nSBTs1eyZSCnSmUg
         iMRZ55UJBAjqyofDRVz6/hdiEFWxf6UUNgmcLdjb7Xc9VRB6AD8htbrynT2amj/+SYdL
         yvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390803; x=1786995603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=SdVti510XyY3hPrPEqV0pNt+rAZaRTTKqDRG/EEhk+4TqPVF4pIEbvevrL5jsyJSbV
         a/sEvTBGKUGe9xloTInioG4IWQi4veJHVXw+xSkgWNQTj6A/x2bAe44RSEHgsoYk8RRj
         ws4q1GaP+4CVAXCIqIMIL9Pa3S70vSlL8nckxpxvOsLHlmi71SDn5ZPPyc9W0KNw/f+r
         ly8zkKuQU1PsttyBPI0Y4Y6Xdvm7m+1nITsoW1vL+geS2Aib1cc+Ziweh29cTnIShZGp
         jcsWt897N2yOqDUs1h8+yyItV4CtG9mBnbcUkw33TcrXb+9VdGFCmwHuINdNF68fZRK5
         F12A==
X-Gm-Message-State: AOJu0Yx4a4XusuJ/cr6JH2JVo9v0I9bny22eTes+0Q7r6AZpCFJbqPfp
	oJsdjFN3B/3TcJJYhNuEPDuUUuhZdj96hUAj/2oTiGVCfSOVtnuPyaz0
X-Gm-Gg: AR+sD13IqXT1oZcWaOY6csF5i9i18VKDE8qVKbOvFsK+DvrXKw28Cg3N85PdBY+OCTi
	hAAOgJae14NU+Yt/zm395wpnxE7OSbv30ovhmlaglrSmw/ryajsyGR9pl+ZKY9KLYExkFYgwHXE
	cdPbSgq4T67M1B3MJCkmvicPT1GiDMpJNqwZcORLlYKdmhP9XfMW9BgsHxiwteH0HtZ2ajaI/ff
	B3iT9HEI4AYvc92QBCfx6YTv0O29cIJhcWXSmqhLH4Ixv8XjwN6CigTVhfLHWsDW9PuKt0Jqlgl
	mOlntJHQW8Ro/l9DgNyS42/6tMyD5l3wqyFBVT0+Dr76MJxAB6idhrWumCmANxFZVdv0AJKeJRU
	xQvWlj9rXH9oibJM6dw/jVSPwLrbtQJ2ccjPIINFjbYXDZysVWZZNQO2SX+yDT7QuqFdYy6DphJ
	3kHEPkhleUjgrgvqn9Ixy2H2SFg51IReyTAqbzPbTmMzFP/+bx2xDhUp9T/3MQuQA=
X-Received: by 2002:a5d:5985:0:b0:47f:b452:49f1 with SMTP id ffacd0b85a97d-48130e7e7dbmr33227089f8f.2.1786390803210;
        Mon, 10 Aug 2026 12:40:03 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Date: Mon, 10 Aug 2026 21:38:18 +0200
Message-ID: <20260810193826.210683-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810193826.210683-1-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abracon AB0815 and AB1815 are RTC modules with SPI interface.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

