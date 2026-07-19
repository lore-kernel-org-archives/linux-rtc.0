Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA22391501
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470239; cv=none; b=qQm6TtE68VHercGhxHzSaez03Fit0yWVfz+lRfIaQRqmXhU4C5sM0M5St6o4Oj1Wp4C6YDI3ECuG57ueH5QMebWNgCUNbRx7IfghUt71BuPOtAihrSR92pi0W+eWRJNs+xpY2bBR7q2SzhRbnJAw+hufNULV9gRBGMxPsq8XtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470239; c=relaxed/simple;
	bh=zxFukmIgWBNdHIDZiQeYhHajmRjhjZV82VhWCev2U4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6TY04OLYqH4liMgYswgx3CZWKbQlVkMy40tmCJGJsmxFvRDGb2pHbB3sJfhVlT9khjHhZOIpxICKqWhyzinS5ASRQmzwqW7AkI7zho2AITDGMq5d67V+/LLYgD0lLc+V14Rwl04CsG9qr40x1EsiRBcvfY8X65AsQEu/urZCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxUn6cFv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxUn6cFv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1580340f8f.1
        for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470236; x=1785075036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Irw3JPEYfUlh5ovIGw0d+Mqx7jOMov1pg0gxS9k0L4Q=;
        b=sxUn6cFv6VJtLi6+RWz5KWnq5RBv1MokrUG5c9vbgnA1cRpTJTmjwlsLNeKDd25nZp
         kn2BwAwSjoGjzaT+9lc4+wXepyojuzA/gZu26Iv8b4cIsLfKRg1pJNYKga1C8quFzzPa
         Co7gGAeE2h9BbWErPZ5tLrDkMGbCeKHyOJ6yvH1gwArVngf/P2H5MgMPXbVewTK8vsFT
         1DVzMqangLkSj3vv+ez1n0trDSw3fIzrGAR+JR86hPvRH651hrgxKuNCVKNuDEkXvXn2
         xC0Q5ED5h2rftGpsiYbDuf3GYD/n8VXbSE4oJYZ396sp3s1kf2fqnmHwCDq6ayy12e1B
         Deag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470236; x=1785075036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Irw3JPEYfUlh5ovIGw0d+Mqx7jOMov1pg0gxS9k0L4Q=;
        b=RB00gcJ70HgWJ1FtXUNP7rn23Rf65VBbPDfEylcBt+eskV/y5VgePbPAP+idrHHWUe
         pssVj6qX4d5SzzOogHT0kM7SbltPHXHy77FUKiWx5Dz8blBTQFC2JcodAqNlRiAgKNV0
         0/GYoL6lAfV6JAEQdoRf3JSpzFd6uhZg71XF9U3hTmD1CNjEBvsMFYY8nc7BFmjuzM9t
         QgBV3KXC5WwgkNqPToRWpFCTFIPdkx3zFGXNp55NemdN0B+G5QZ6E2dsJtI+JRU8Oxzn
         GrlngH87hD+o95fkC7g+igg2sw4rPKExfYJ88viJ5KHvzbl87BTKhS5vgMnAGZ6ropHs
         51CQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrv16kPIIVU6JkGK0YvC5XfZVVZ0Y8oU6cszdAXkyIAplbaT4T//ybz2JmeHFlEH1Ck8ykQlUNFHd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6nNNgk0cqXHPqmAmK0Syeki7rTGv/J8xZ2zzZVBqdH/5xDWq
	kIAQC4xPtbMFkgUw7QbeHZ7tbW3NXtefbkLxQMojXXVgTKBALXYBQniu
X-Gm-Gg: AfdE7clTTfRse17HzF4t8QW9qIbsfqmJtes7ZcJQM8OnCPRbq931JsM1UC8h6Z65nYj
	+k//oaWq1xxGokkSqgtjot+/xFafv/YrmdWRavdTmQ3x2cjzxj0SDlO0DAVbc7HA4y3EDbMwKMp
	rotE0RL9o+ICCzaixwFzGZGp5bTK8CrZ054TBj90rGW87RtLndKf5xgewbzMTlyPlSf0/6VRjG4
	+ZgQSUFSFx7m8oIN0TGtrbbC/N0njk9kP3YVFVvoZ3aItaLS/yEArp6uE8Y+SHwLyRICu7hih3Y
	xNMTznqmDNuKxSj+YNTGE37LQLURJ9s4eRw74oPFfw4ioXnEnqrl69okRoJ3I17p3OhO98F9Xz4
	cureTmbUr/+708jou0zwT3vjpFmfUidfpStPIqi730egoE84VXZXHxE5xkZruB2dKBnpJ9uLV6d
	mnXrpSJwyTnoqixdP2PIioFA9m+E4qWw7q9XGw8sb3CHsj9kHhl6MhfIw=
X-Received: by 2002:a05:6000:40c5:b0:475:a771:e839 with SMTP id ffacd0b85a97d-47f5a419737mr18506383f8f.3.1784470235957;
        Sun, 19 Jul 2026 07:10:35 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm21264859f8f.29.2026.07.19.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:10:35 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 2/2] ARM: dts: ti: omap: Fix Palmas RTC node names
Date: Sun, 19 Jul 2026 14:10:08 +0000
Message-ID: <20260719141008.3562347-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719141008.3562347-1-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core RTC Device Tree schema expects RTC nodes to be named generically
('rtc' or 'rtc@...').

Update the tps659038_rtc nodes across the AM57xx device trees to use
the generic 'rtc' node name to resolve dtbs_check warnings.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts       | 2 +-
 arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi | 2 +-
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb364777e..46270ed87377 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -386,7 +386,7 @@ regen2: regen2 {
 			};
 		};
 
-		tps659038_rtc: tps659038_rtc {
+		tps659038_rtc: rtc {
 			compatible = "ti,palmas-rtc";
 			interrupt-parent = <&tps659038>;
 			interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi
index 87b61a98d5e9..e7c186941c23 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi
@@ -360,7 +360,7 @@ regen1: regen1 {
 			};
 		};
 
-		tps659038_rtc: tps659038_rtc {
+		tps659038_rtc: rtc {
 			compatible = "ti,palmas-rtc";
 			interrupt-parent = <&tps659038>;
 			interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 5eccff3bb4b6..a2a654ef4ef9 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -405,7 +405,7 @@ regen2: regen2 {
 			};
 		};
 
-		tps659038_rtc: tps659038_rtc {
+		tps659038_rtc: rtc {
 			compatible = "ti,palmas-rtc";
 			interrupt-parent = <&tps659038>;
 			interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
-- 
2.43.0

