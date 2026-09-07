Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356E52B1D7
	for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813248; cv=none; b=tHrZHzrPT8gbao7v1cVQHwcDtEGLJDtvOnP3tmI3lQ/HNs8r343f9PveqDByadC245dFBa2eW4LMZ7aBShdt2IorzVjTEB0PiBANLH9G7TWn9GrZbnAZLipnr1v+cFZEwbl1QD+qFPrbDcDDDA6QYo4n4edpVMskgwri2zeQ3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813248; c=relaxed/simple;
	bh=JzPmVao8FK9SYW6EqLoAZ+WBysafs2v13tUyYWLjmGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLYMYq6mZ3bl2nPPJg9QNyLSZcmXvcDbsmgQkeK3g3Ij74CibpLZ7+j/zG8aqgTUZVi67V18AGzheAptN2aaGf/y//fgyTilVbd0ehQ/Uf+JwT2n+7GlH7pzHyn6Gw0BR4CWNSvpgi33VMv/y3CPE7589XjsCObAFckt0L6iw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oH1tnbS0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH1tnbS0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48589798dbbso3264353f8f.3
        for <linux-rtc@vger.kernel.org>; Mon, 07 Sep 2026 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813243; x=1789418043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=oH1tnbS0pmS7TygoqeIXnZgTb7nDPjYUTq7b0zBF7vKcgwlJVh/Sgq2SuFp3hBMleb
         wqEm5jAiwqr0vwoCNBy7bgDZYt+GhCMakf+2BCwY37Y2XBxrA28339RYnFqkO8rU70+j
         odYakp8JvFE8/azT5VYvlghlXF5n5++1ZBKvnI0bN3axtzYf8XuXWfvHyDgAaYwGVeH/
         38sR24sdrkCIdji3VZkvCpSK4f1gFyD4SVoGZuf/HEUJOYN9wDWc6HbjeGy7R2Ma3aJi
         hUfFU6at1r+eUWoROa6LwPqsqb99BD/QWYQqrK6JRbi2JHM/NNo9gCXUIT6EKI9me2tq
         pc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813243; x=1789418043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWcBC68WNKLZwVwv+eWu33G6o/TkwBMc1Uo2TtiwMQM=;
        b=gGWkAOB6tzcTlhJq0g7fIEUPkz1V5vq+6jxapyKSfmRF+BJqFHSBnTt67/c9ZYW/OG
         qgo4vUtlCkU+JpCKwQApqv1uBz+lN6wLP2/b0i+a3PfqYbhpIDRjJH5twRHChOcJNhnu
         eZnDn8uJCEb3O9brY8CofpiYSds6gkhXPnBSg9pQ6IDZJth8ZzPaB/0wZMjZ1XOcrmVp
         L05H0VgQEisKdI8vox/cznKHQhbQpV5lWEYYkt5BMmN5WW2zR322mzxx3rWyxueNgIhp
         MT7tSO/jkD7FjpJQ7CJrL/M0KmOJF73+kxOsfrPOtIh9VjcoFp32iHqkZoST4SHOuaWL
         tMJw==
X-Gm-Message-State: AFuF++niWaBLlJcpsdA+163l/9iZsuYgc7VAVpOtjqkinZLjJFsEcJ+q
	htiRBYvUbXr27zmCXYBw2eC1DI1hBZN5/ElDILaU2WAkw2vBEhsMInty
X-Gm-Gg: AYBFou1TH7ia1gcKlrFVF3GzAA1s5Oovk6kwqW9BM6eqPr58MAbz/IWCcoH8hITzhwi
	V803toJpCpAkHKoAxBJxXLF1JlGQTXPrl/Y49PHreh7lz8WNM315RFL35whDd4kzlcEEjTuA2kN
	ks9P8iMtlHxhyV1bCulh9d8A/qvTuGzcPkg0qZPaSv01TbIki2BTCJkOLJIigq0Y9qvaPi6GdX9
	NU06l5ygan08EAZbKHgZlHOqfQclGwxlKDn6GtpBuRTmlang9z5cTgmPj9FXrDutJ3/8mqr5RcW
	zW80m6+u6C4VEXStonxHEFpOso+YblqPVt/N8MaX8YQxyKY5PO+Aj2jgXOe5g8BfQsvYIV07K6d
	86I5CxVFFppwPD58MUsLnBDXnbUozy//QBt1aKzAkug+KAnBwNlwySg34KSLtkRpIoeBIZ6sJln
	X+CANsoi11vJf4DaY4hYknuZbJ+LZZ23Im3Unp8dy39riRXJ23+Q+ZKZfWwEzUVA==
X-Received: by 2002:a05:6000:18a9:b0:485:9249:6a10 with SMTP id ffacd0b85a97d-48592496b7cmr18450345f8f.7.1788813243394;
        Mon, 07 Sep 2026 13:34:03 -0700 (PDT)
Received: from antoniarch ([78.212.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm25959116f8f.9.2026.09.07.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:02 -0700 (PDT)
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
Subject: [PATCH v6 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Date: Mon,  7 Sep 2026 22:32:08 +0200
Message-ID: <20260907203216.53192-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203216.53192-1-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
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

