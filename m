Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A640B11D
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750449; cv=none; b=s4rGiYBh1rH4vPcwHGMd0+2TcLnwDrZk+oWCEBqozL1XUluUW4cz2Oze+eu/bKwaBKnFHC/w4Kb8iudzSDunuVlRTkjhFaBBFxeYce+T9YiBEghktKEwbawkP41iVHL0aILi2bSVH3JvNM6z/El0ZSS6COqFgQlYaWbn6Uf5y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750449; c=relaxed/simple;
	bh=2duyGJfYn/GaJJaQhdZ+Iv5JO7zcXIu5UtXyuenKfAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txJoY9KfpOlr/MgtgcK0PFhkApDZs5os6wY2G1//4sRQf1HKqcYLa7dYJsoaJrcO+eFCYuvIvruPoapnClF3FfI9utDM1QW6SQLYR7sjLjxyHBR8OOYUWVisV0/UjzDC5rcN73L9yplzwRx6JX2ny5HWYYFyYRVFzw/VofD4PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaN57uyV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaN57uyV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso29122875e9.1
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784750443; x=1785355243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DshTRZZ/m+S2rWQf/vGQq88KvnVaF2XUCiONGMXKAu8=;
        b=kaN57uyVRDIPuS1Zw9xAj7lU9v8cSu6MbmzKkiqYGV6cwPq/RZnM3BO69djElQQJtI
         g3iKic7wuLOg/rCw+YUWWy8yZncEeczaXtmY+f7lxF2YsCqF0C33s4QpHMKyYmVWsYP8
         vBQurNv32Sh4GyYWx+WkWw55gIBVgRCt85gMV8TJVn6xy+6wtRWhTsj5P1gZO669mINm
         ET/VuYYxX9KBKRvks2o5+OU67iNuQZ4zU/8mwlH/Tk5l2VXqmVP3UggdCKAtgAIGJkWD
         k205eXDQWrLkuFRL2awPt3SEO7BNa0dZvahnRAOSfcnj5Lg3zVLMZab0FDZlBPcAojDi
         wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750443; x=1785355243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DshTRZZ/m+S2rWQf/vGQq88KvnVaF2XUCiONGMXKAu8=;
        b=ZNV45VOtehbE3mwIenp1sb3CbNelT5NYyiLy1hg/kXSh6S7JebhcgcxvonkItSV4+A
         FKkWaXIuuDOB+0/1tkEbhUvMxR99X8GiVbuIUm/g64Vrkm84UYULiqvFPROTFdcGEooC
         +VVHCEZMnj1Z5pudio6L7cLDexos6PKU2+Z8P3cY3gQyaXbHECzEm0WuJFpX2TchcUpa
         +Aeg9HFCzUoiv9sQ+1EBO9bZrU86HMrGNOMffywKXcoxXaNbm/ej4lbeXtG200l4PV1j
         Cdq2hwYVIvPtaD126vHEsNsCw+MXaSzf4MwlxnXnELjRgBZQAVI89Z4JZ/+trw4caJni
         GScA==
X-Gm-Message-State: AOJu0YzCx1rX2nNlqicVGAyieRf9wFYcfu/Ua71oy53ljxxl+iFD90K1
	0XaS3Uep87sQhlMNWPCIM2iCyCeGCzS0aIeSE3qm648iPf24z7rUqydS
X-Gm-Gg: AR+sD12Hv3v6a2kprzMvchmKe1ieayMkMM8t/iwCgnFyPk5YZkrpDYaiFUhvDPcKT4Z
	8O3XMd338nrjzABU3W6XJnU/QKICTHzpyi92Gb9nFLk78/LRjj23Re5OeB/keYY8yec5h4JQYKz
	P+9i/uK0RAdk9Dqw7EM/eLIsG2o2vlISByWRh7qKaQtvbDTp6i8NsNoDNuCOPd+j3ObmFLqDz3B
	lumi6OVV7qZzbrphqaYecC6cjF8WlDFd6rS8ct0I4dmctMqXEoRfqMjj4Ar4RhTQy446Eei3Abj
	w7G80W9lbZGhJOBFmhRxLAeWD0fUSCVxJyLdKAq+lOLrA2qIp0CpD0XaC+N+hn9oudu0vj9frdn
	ppdMxqC9QqWOnDKz46L4WVtymdTnW1mFklyPoRpyDpJ9CH+0PnMFY4GVzWC/eYSMW3OQOjiYOe1
	KCnwkeng==
X-Received: by 2002:a5d:5d0f:0:b0:47f:85d6:9e7f with SMTP id ffacd0b85a97d-47f8da5c8f5mr314708f8f.3.1784750442895;
        Wed, 22 Jul 2026 13:00:42 -0700 (PDT)
Received: from antoniarch ([78.210.252.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm9532851f8f.20.2026.07.22.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:00:42 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Date: Wed, 22 Jul 2026 21:58:09 +0200
Message-ID: <20260722195814.298552-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722195814.298552-1-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
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
 .../devicetree/bindings/rtc/abracon,abx80x.yaml   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
index 355b0598411a..234a103724b5 100644
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
@@ -96,3 +98,14 @@ examples:
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

