Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500A351C11
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761931; cv=none; b=h3RHAT4Df8liS0F8v/xE8LsIXy5Ywss4mrPmNJ/SKZdrssfmNH3+LIP6by/eEPEyC40zm6uAvJIawZSjjtsoolGaeXefS0F4VkwQEfNfLpQHqgHw6ferAVr9uFKLTBMDUyZ2hgk1K1WF/r8OGkoXayV2k9hiX7budZtjOZJB83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761931; c=relaxed/simple;
	bh=2O1VhIODyouGQSuZPvpbG9DecXTtDHxtiPt3PW1wtkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFQ4kM+dcdJXlojbn+480ZaKAAWhjZTw2Wv6gybpwLMr1Fx1hpFwbwzxvnSaMgyYhGA/ZkzICGXQqZ5nD2eoBaJNN+KBzwK/Gf8kATtOnur6vIAeVfQ+vsAyUV5Gy+wEgmO52GxanFNDUbeawhFJmcWXF4AV0g2gpnuJ7R9SE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHRwhugj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHRwhugj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so47851125e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761926; x=1791366726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwoTkJs7HCyeZUjKiL1dlksDyeA5N9XlMCDu8/M46vU=;
        b=FHRwhugj0L44DpBvSzSqU21sQ1Q9ZyPPIQmedFlEHlxT4fLhor/GUzge2p2WB+0Xpq
         Z9oPKl8mbvLi+SpPRkpIOkKdcyuX6K7LzxjJMqoStX6k69EfqarsKQx47KSp3vQF6zeP
         ix5RAOI/DPpI6iz93GASTTSowH2GPCpr0am/PSL0rGDnSbNCCJQNCWHex1rtRiW53aim
         hwYbU5vJJyG2dBeZMAsdWuJlKHjkXKLwLltZIaMxf11tf+bz+53C7bOMJx3Bv0YPojKj
         oiRrcWGq6aSg36VWycUGLws+mmIEmKFAmQ81RTGFfkLgZpCFjavCu8kvowMNV6dwE7PQ
         IY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761926; x=1791366726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwoTkJs7HCyeZUjKiL1dlksDyeA5N9XlMCDu8/M46vU=;
        b=u8Uhd2qQSDbWxZWY1CIsxlRuW96uXo0Q99mHtkyp7LiEnK9nVi+Qw71/xyI4emE7fL
         RkCWALaK6n3ooL6YV5IA8C3alOuXjW29K1juZ6Tnu4bSHp8+dKpRIAEyK96Ac26MkNwW
         jddPAEg8TtnIFwv2Xh8aHaf66eC7347OT/w+6EyZbvJUG1oGykK25/5xh3ZB1rqtn3xs
         DR0AH+NHHwRLHl14M/lkb0kUUk4+en7WSI5wnXyaT5fVVleBs84Op/n9j5MXnZW/AnSR
         Lcz89qMYydIJsbWNuiN895x/AjTGRz50sKIeOIt2VUdi3Aby3H0SqGnjT+otgRZ9SZPi
         //3A==
X-Forwarded-Encrypted: i=1; AKwUvBwbtav+FepZOyWdge5cMWsBXz/9W0EoIO4e1PZlqy85lhEtt0A1MGEvjIxt02xl6YDVEeRn3/asrh8=@vger.kernel.org
X-Gm-Message-State: AFuF++lVDA4JfOUhSUeFgvDItNzMLiM6ttYCLjAcuCmyxem/Woaax1VT
	xwQK6gj1oCuPvoHuIHZPJmuU01macn08YHeV81E4/5jflFur2aFd7weQ
X-Gm-Gg: AYBFou2SPGjsmk5boiKaoEwMlWB9OHxQeV+0Q3c1z7y5CeFpbC/Jmwu30dmpsxaOawB
	vu6DkhlS6b5bbL4WpMSSN2VKYhqohLnr36mEAFzcEtW9iSyOClS57TcXqbEPmFuxRrCf/jcJRc3
	O4llP4k4awxeREGgNKsstbZkfbgCS3me/fWz9XABusoiswR9++mIXOWcniiJgvxeVs3OqOvSH7Y
	LfxGYNd2L/lCqEqj2GtRxvOcq9Zq2/FBvUwE8oyNUVP2nUwnO7IOmH/EGB+MYg5bLikXC8Rx6bg
	kYTBk8UyH6qALkNcbvy4158AASgtCNxqy/njtdQnG4VWMDrfvOYvhjdOdMUlskACCF3OiWXMVH1
	PNgQQVInnwds35SSzKrkGokyb7MesElfXifbcM6okx2g3B+0K9VfrKnm2Ke4nONA8dw4zdank/b
	VsLDTHiViuVJ/pn7ZGnPDaMjIAsxpsoWIFbqAGSUQ1rqKHJNzcoz9e64+oV30ZSTS6vM1T27Bgk
	u3f63LosnXWIbQr9jKaN+Hs5YR8hxPJb9ilzWwhpZMQiA==
X-Received: by 2002:a05:600c:c166:b0:49f:e3f2:f5a3 with SMTP id 5b1f17b1804b1-4a01ab4d864mr15364625e9.0.1790761925903;
        Wed, 30 Sep 2026 02:52:05 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015abd9ffsm43859655e9.2.2026.09.30.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:52:05 -0700 (PDT)
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
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Wed, 30 Sep 2026 11:52:02 +0200
Message-ID: <20260930095203.492949-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930095203.492949-1-sander.speetjens@gmail.com>
References: <20260930095203.492949-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a built-in RTC that can be battery-backed
via the VBAT pin. When a rechargeable coin cell is used, the
hardware requires a trickle-charge voltage to keep the battery
topped up.

Expose the trickle-voltage-millivolt DT property so the driver can
program the correct charge voltage for board specific configurations with
the attached battery.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V7 -> V8: No changes

V6 -> V7: No changes

V5 -> V6: No changes

V4 -> V5: As discussed with Conor Dooley, the reff to uint32 is removed
and a PR is made on dt-schema adding millivolt to property-units.yaml

V3 -> V4: Add a reff to uint32

V2 -> V3: Fixed the firmware property naming

V1 -> V2: As discussed with Krzysztof Kozlowski, this property is folded into
the existing raspberrypi,bcm2835-firmware properties.

 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec9..dc71fd57834e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -133,6 +133,11 @@ properties:
     required:
       - compatible
 
+  trickle-voltage-millivolt:
+    $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
+    minimum: 1300
+    maximum: 5000
+
 required:
   - compatible
   - mboxes
@@ -144,6 +149,7 @@ examples:
     firmware {
         compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
         mboxes = <&mailbox>;
+        trickle-voltage-millivolt = <3300>;
 
         firmware_clocks: clocks {
             compatible = "raspberrypi,firmware-clocks";
-- 
2.55.0

