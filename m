Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327F4E432B
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647924; cv=none; b=fD4scBsSgJ+b3/KHm+X11oBmqUq4BwCGaVS0HRIb5PPb1ApjP0Bp9dcdgR1ljySE9LSdC8fB6+JmkYD80Va9xgfiWXnhUwDfW9jpG4oykS4Y2oWo6Svini6gaB1ffUGgoXnCIXwqQvUTGaugAZJrpXav/f+kXrEjzJLqFBQ+qjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647924; c=relaxed/simple;
	bh=Uqd5qZEsRqOkUbFbqjWvB0w0LK0SzQ/ZsYEmjy+qwVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENF8iCq28xzyRwBmYnqn6M62AHd1W2NNgQg4bfWuqu025pb6X3jPfAWVCwAW1QFFKobQ2yGIkrX43wmxjpfZFtkhJSIHfB7a+Ij1JB9/qgRqBk6SJ/MLA/1Ir11CaWrPKEDrLRGSarEv3AR2apILyF016OQo3jNyt6nD5M34Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVcwQMml; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVcwQMml"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-482f633cd78so426153f8f.1
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647915; x=1790252715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zh8dnCzgurcfuVXhK01muyhzuo7mZiFtdSNhXSbz6gU=;
        b=qVcwQMml9qh+H7wiHg+MJtZwbUGHHVWZzc8lfYa3pHYaTsTSF+HpL+bg21lSu5QR6o
         iDpqnpoMZ7ANUvwuNTxj5pJuSeiBfalJTBN/56SDOy9sLPrVvFT0Hx5vMOXx6Ayo8iFw
         QFF7ubs3h7ExHfx6TIBab6Z1luyXj1HaYSMoJFj7vQjlAagcqAU6vp4LnNHs8/1/SLYU
         svZHm9BRvAUuF7Hi+ca9mTYkE3/GKY+LMSryvlU6+OVN2XBRbkWBihZIn+nE+yStVjlo
         zhRs5ebNXkNSHYkF89H2rCQdrcpFJfKc14itCuAx78T0gNaOT3w9ENy6fMytKZ/uoH3A
         s7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647915; x=1790252715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zh8dnCzgurcfuVXhK01muyhzuo7mZiFtdSNhXSbz6gU=;
        b=Pqj/ZXVJpMVTpIon0hdWpzzfOgbn83iQVzAjYKcO2UlsIlApZSKCkLrPQ1cA2ZKvzb
         FXawMHluQn9NjtIy7jYjaolQt0XZDvXlVSIPvZoTCPBGmw5M166SeWWuOuD90Bn8U//7
         B7h6lwapxie3N4N5KO8VIRKaSwt1YJSpDZA24CLxIg5iJxy7KmITJy3U1RvaR05WHArp
         3YcG1pkxIoYckw6SsjvrCswUKF3lS9QOxlKr24zJ3V41YfnDZqN8VspY/SkcNidYf4sJ
         emQdkPV9sdo/WQ+yBB9elyC2x+sLMvm2/SzXnJOWgqkTM0CD+6NZP21B39rHT9Bzf7Az
         J+GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRzamigpz9uqKMzPPA3qI9X8Cc2RzvVEHqyAjlOZAXIp56pimEtaMDIZeh8bA9HgbQvf3xDOtppYY=@vger.kernel.org
X-Gm-Message-State: AFuF++ket8ktc/gxM+z+5W4dtq42cqCvpBZFKCw/V9gbks3JCVTcSeZd
	yQryQABSwmJUDV5VTnZ7hjWOQiGX6kIfAGumXEcOFb7kvmr8IFYnVwrJ
X-Gm-Gg: AYBFou3WZH7MDYn3+ydjuEevFBbFfWU0VUb8DsxR+NNBkZu2uGsQYkb6Jy8JTsMO9MC
	kjBlmJ7wDPN4YJ+0xZm5g4+gcH/tS/paO6BJvaFVBF0JZcigDxWIgovBIjFXsvLPtKqK1tyrOVB
	a209xjZL3/NbOKjA71e0KfimiXA0fQI97Rf1LNvoiLoemCgR2ERQTLsx263MMzF+Sfbyi0YLaY1
	H8V/Z56XzyNy2ZWAcc8+0z4LM9rrU2MaCadaxvTHhxa0LYYHm5fBOAj3gMIMyz++OTJpBrdm5UD
	Ctga1LidtXSv6//N++qT8uwgym3ufAMfl/NhG/iD2k5DmJsEiMwktvXgtVm5DgocSdqf9VECa4F
	/lnDhhtrlKw0RFNXeg5xAFb42kyqt85+CObUrl5EtWLfraTrJZcVMqk8JvW2gBErBGr87NVWA1K
	RjCAr6yAO5Bt7/ePtHIg2VpC0Xh35c8Cjp09j/L2b5JdvU0mE49CC3u1XQ9sEuGwYPVItBp2aeB
	r3t2b82vmUj6yACMP0pvDXrWVdeCwKaR7JIopEmP7FxVw==
X-Received: by 2002:a05:6000:40e1:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4870cef0c80mr7996798f8f.15.1789647914967;
        Thu, 17 Sep 2026 05:25:14 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm15276567f8f.20.2026.09.17.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:25:14 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Thu, 17 Sep 2026 14:21:43 +0200
Message-ID: <20260917122144.703221-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917122144.703221-1-sander.speetjens@gmail.com>
References: <20260917122144.703221-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add charging-voltage-millivolt property for the Raspberry Pi 5 RTC.

V1 -> V2: As discussed with Krzysztof Kozlowski, this property is folded into
the existing raspberrypi,bcm2835-firmware properties.

Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec9..1a0432510bee 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -133,6 +133,11 @@ properties:
     required:
       - compatible
 
+  charging-voltage-millivolt:
+    $ref: /schemas/rtc/rtc.yaml#/properties/charging-voltage-millivolt
+    minimum: 1300
+    maximum: 5000
+
 required:
   - compatible
   - mboxes
@@ -171,5 +176,7 @@ examples:
             touchscreen-size-x = <800>;
             touchscreen-size-y = <480>;
         };
+
+        trickle-charge-millivolt = <3300>;
     };
 ...
-- 
2.55.0

