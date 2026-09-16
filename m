Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34440EB9E
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592020; cv=none; b=cpbdL1uP8/4+/iEvHfVFYuxXI13oKRnrrTSs3AsC35zeFqSbqxidCqUh/Zj0AQbnpyjAQ5tytmE0RxNsKqYpTRipgVfLLdNFDBSu4WqNllCz0WsZqmvX1ZDtbjWy6PRAuYxDuMx5nXy9Z0QZlZ2XXxqPZlxX42IXqOMOuur4pkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592020; c=relaxed/simple;
	bh=JzPmVao8FK9SYW6EqLoAZ+WBysafs2v13tUyYWLjmGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7XJZ+i5uX1qhJfrLHp8Pk0DBS4u+KRBJ8AxdUcXPc69ZiWSJB2+QQIhS8h4x5I12NDHDZKiYM9TlHe7uKGuUyX75fBPjNIKpezFHOl9gArLSEEuY9REsgDFyuipt0wi1/LH8bEaZs4bcNfzgZvftfAQ2vOp7uf2AvJ0G7J8R2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McOHYnrV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McOHYnrV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48586861639so28915f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592009; x=1790196809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=McOHYnrVZSHoRbI7jUEh4KuKYRzELH6uFkRR1CmiXqeV22lEWGnqxopJNtidgjNW54
         iku27ARGI+xcXGJqXjzz/T0s/0+7wi/p5z73zHuwU2d+Vu1aNSagm/oKYmLiby2dRaMW
         aHDTKIDwk8Htt2G6bfq4VHElO5SRHcdDqz2ADTHjSzfNdoAEyi3iQ1GNG32EwSF9YxcU
         25W9Ecv2CnEPqK36upzazTX5hn0xi95EDKpWfYuEZGoBkY9A/PpnjoRrp1jJDAJ2WhP7
         eM1qXd8seIbjrBw5Kee/cp4EO2Fc0B9feju3L1bqiAEqvnEiwvN/oehQL6gGyr/NqZzS
         9yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592009; x=1790196809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=X3d+Z80/A94Hvr0qtbWSwgmMcrjE55Ec3J5u7koJC5IRT0L8eWPk76+kh0P0vkWkwJ
         G36JBduWllTfysKctbNHeAYjptbDc2BaXu5I40JnnN0AH6UuzCcsqdFi6xvBQpJfCuCE
         1WHA5PBmQak3BtJDmlXgJJf1/vmnX6dgytVYvXQw/afT7Chwf4dDqZKN4lpr05pXhV4B
         8iRcchx6BVHELreuWNJicfOMnGVsYBK+VdErKSn+8S3Sf42kYd3Lndrhytb1oxIPbsC5
         uZvNifKtRsuyhRUtjvH3GR9TVjnY4CvBWvvqhMSbCicphbisaUF3mKvoOhePqngC5OIs
         Pt6g==
X-Gm-Message-State: AFuF++kdNGJFL/qtxI2Rq/10FupQ0cnQ3+Cq3HAjUsOYWL+9OrnhEtuw
	r28uXSnN8Xc1TZADwShQ1s2rY+FJc6P9nru5ZiomcoUmTbf2TKlRjAwodqd9Wrnp
X-Gm-Gg: AYBFou0/msYfr1dBQ81N02pydjvpfvQ7bSDELrnbGe35PHZ6FkRNbrNqy2TmAdFpS3Q
	f+ZGDmilHeJ1j6UX9FKAmbG3kuIZpw6P1hYw4jkjmD4beQW86gj1XJ97OiImVk1ICfkpJJfm+Xi
	3rDvdVsCP0u0kkvV0n++HKso1NUMjzUEs5tysXWKpcZ/25UQhYQ2xYl77INaK5oTR6kXIO6Xui7
	GK8mj1A0Pws1ACOD3XOsp9Ydbs2XvYsbcAeJVG+n0pd2o/9WfNiKdQ26IwL+ehE9MHNp35wGrsn
	Os+3CWZCT8jWhFSok73CWRdpMKqF5TaG4hl9Z/uO71h+oIpTnpVYQpGfgks4mX/YS9clLGHSqQm
	iXzRQDx5wVCJvDGyeJ62RV6A6Wzj4tzLjeMED35wcztWIYmFgnD9hmykqHAZf9a3dn6kltZE4T/
	hRrK/LKEyoEQgeYwr2GamM3qQnoXAPD8KO/MRnxW8cfWUcsWu6iZ2F4R1vhXND6fuQuYDBPw==
X-Received: by 2002:a05:6000:2612:b0:485:8226:c696 with SMTP id ffacd0b85a97d-48713c59e2bmr1379935f8f.21.1789592008945;
        Wed, 16 Sep 2026 13:53:28 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:28 -0700 (PDT)
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
Subject: [PATCH v7 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Date: Wed, 16 Sep 2026 22:51:30 +0200
Message-ID: <20260916205138.16771-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916205138.16771-1-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
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

