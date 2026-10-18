Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62522397935
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334275; cv=none; b=AV99KyEqK452rlqzy41knfyRfzu7Oh/bmk/msC31FBBPLZedXPzE92we+uo03sYLndgSG9Feit/N+hSTPooaDuflJFJz1xFAb0o1B05C4nSN/YdhI+BLmLHjz2Dsbamtwe2TUei8SPOGQ6yKx+EqYrv3/Bj2iccQMgwi/GJVQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334275; c=relaxed/simple;
	bh=UYFoFX0tGdhtBbyo/PtF8ivZOPxks5UDgHk9noFc/r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwSPX1coNrDqU1ezoZMrjNqxQT70YMNv1HTBl8kPBcgnH1pS2KgWArNJZCLm9FEztXKgVQk5eKWjBjo6Z8qCP8CYie8kt5sfU1rwwt+92ElDYN8j2k5QXQulZG5uDWyUu/h9RtTY9LjoarCBxKraFNmYgV4FtJbZo4LeYeWP2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBnUNqhJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBnUNqhJ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso714244f8f.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792334273; x=1792939073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iL6GDYV/Gzptn6Y+1zackEOFhZyQVLBTkqU0BFO4s1I=;
        b=SBnUNqhJlsNQ058UhjSIABvVOLMW8MMRmSn1dibFENROTSAch6CU6O3jfd7GI4h13/
         rUFLXzxi2RTCzkXsjhqHUQ9wa9aCM7eDe/68Nw1OBit+0zQdUdhlJSW9fFCyBzlm2HbB
         UNGXjSPgeYduAPF/hTyfZFcR7LzpWCUIKsVsuSPcgdAjgzzuZuhBw5xnAlSgwuHbi3Me
         MWeguJ4dHVzkLWocX6/uiqR9IyXmp+S3zAHGro9ODJSC+tB3wExdovZWR6vCqBZt07u+
         TAxJq4Cjindm4pWXxfmbA+fl2Iv0fjte9yypBO3RW1TWV/N7QW2mz/nB6kLLKG7rD3b6
         0beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334273; x=1792939073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iL6GDYV/Gzptn6Y+1zackEOFhZyQVLBTkqU0BFO4s1I=;
        b=o/de+uYvbVnjj2QR5gWSAKy04bF7qPv3kBvoR71JgNN/PwN7TQRcrwcRIPnim5niFX
         TAdmhkVIlPYkIUDmNlkx1O7UZMGGq9xyQRU4U9E8+oHKAZINTxsUHZg6Av9snSMVhsTe
         BBvCDiloaLQPW27kd730c85Dy4Sx/GibD7fRZVM13Wg7Gof6NbDo873Xc5t0Im3HBabL
         /I95ACFgZabwRh6OGEHP/fDnZJkM759sa3corga3E/B2YDUir49afO60ekEdXczOes+z
         LQ/SK4Luu5HI1zFFiJ+O9KS/o0xq86ayssvJf4hsanOI1o/9KcbHfnB5wZ7T7ub1UJdP
         EniA==
X-Forwarded-Encrypted: i=1; AKwUvBye5IsQBp7vuppr/V2hu2/UcHvZzSY1f6P/0iDZg7oaOXTbnBKYmMMi/GAso8iK9kXkyassgB8rzuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJV8FPGWgQA9qvjRLJ8eUMf2AAFqsgnVi28znR9tGjQWixwoU74
	wPnTB+1UqUYk4d98jEmfOUcrjbf5eT2uDVgWmeHGxajHkwS2J8xHbRGL
X-Gm-Gg: AYBFou3OcCZ6MR05rJEkL17UpmFOl/JKxoQUj1P33kxCAh1eSGfHpnvWImTlKmCYuss
	nFDzwQi8WqZTcRoLimT3Dvi/Tz8v4ORXDHz1ZlmbUXgv5Uj1ne2sKFl3amvn39b/Znl0B3XpDdv
	zKSy+Lumxh58AMBsv8L0/9ITuydukUT46p3VQtAdHyrAOd5lwVbcY/dXVjP3bVYTVH/iKK9i09Q
	MbdELiTSpjxx+eBDeMX7oA6OJQ56dy1RK9S2kYp2ENggtkc9s3tScWGKS1B+BGM/q5yT3nbRxJh
	Xv/mIAdOYeS1NtWDSuVxOiV/Gp0TH2D9NINnNj6pAncfsS5HFPc3mzQKpOcwZDWgMbn3H6AVI/A
	rmUI7KW69ex5bObJ1xEGP2OThGHVCNijyIuIidCDzBtzq94Y/E0yFWThi34GEIXoWz/b3O/jtSW
	3aKfGCQ1pmHhkNjdYVxP0UDgzxURMx5AlP6mNtPqM0cSQ1pogV3KWaUARfMeLiQi5iDcJ+44BuY
	8iLDcTndnJyR5LUfWzuFi4aPA0QmFDmkwiYlHXs1Ma7aA==
X-Received: by 2002:a05:6000:605:b0:488:89c7:31aa with SMTP id ffacd0b85a97d-48e07fa5687mr11225648f8f.39.1792334272541;
        Sun, 18 Oct 2026 07:37:52 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510d60sm16559652f8f.58.2026.10.18.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:37:52 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v12 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Sun, 18 Oct 2026 16:37:11 +0200
Message-ID: <20261018143712.1040152-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143712.1040152-1-sander.speetjens@gmail.com>
References: <20261018143712.1040152-1-sander.speetjens@gmail.com>
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

The property is added to the existing raspberrypi,bcm2835-firmware
binding (rather than creating a new RTC node) because the RTC is
accessed exclusively through the firmware mailbox interface.
We only $ref the individual property from rtc.yaml and do not
reference the full schema, because the firmware node name does not
match the $nodename pattern required by rtc.yaml.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V11 -> V12: No changes

V11: https://lore.kernel.org/linux-rtc/20261014083016.332338-1-sander.speetjens@gmail.com

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
2.56.0

