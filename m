Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173323;
	b=yDcNnSvxbskeqRsB5tNSZrpkss8VAnrs/xsF9P3q0nu+ISVGuhN+CFWzEigJed6yMh8V
	 mmYMhaQeiWICsIBjPsWdRDkN7qPHz5HCuolfwlR5T5A9fO6sNgyvX4UayR9pztiLKBvQz
	 MLeTxTxl33JkAybMrpCapplFXpkokOSejt1/xUeODrDQw9rFDCH76fGiQ4EGORHrjjUO4
	 SwfzmNr3BXFbXSIxI/PPGSwBN7JbC/36CAXclehPnvxhCT68EfOqv1vn385N5StUIEbQc
	 VwpLMo5Q/KTkltNWk41tPzN4O0O2zskEVWEQghF427+IgUTFwhnv3dVBWyy9rGf57lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
	b=Wc37EDMlQn9p7YLQXY3QVh2kVfPa9Xp75/oYmJXcPMNnT8EJ96XQVxYosSNEP0Rh3/OW
	 FNkjgVl64OEXNZFcrFaBszBT3ZOOGh/TqS7EefiZR/TYSDam54CEYoF3EjPwAkQJgnpc5
	 PbR5gXuNb7qNAprB1X0Aafd8lMMg34peaF/iCPogCX67gE3f6xhXD+luE9vHV/1HhRtCj
	 D/G8fPHwd8Da3mbrVzErbYUTFrN3arquX86/PaaszlnQf79K7YQwQ/oA6z5IvPG2ojryA
	 +OLiJOcHfGxlpPXgDIk0ybVRU0BZoCjK5jlutAjq8OqtoFVPt20WdO6AZ9ZLHzWx82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2sdlhZW;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AA606A323
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A98AA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2sdlhZW
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490f38e9688so195689f8f.0
        for <linux-rtc@vger.kernel.org>; Sun, 08 Nov 2026 13:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173321; x=1794778121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
        b=b2sdlhZW8w85oBCsA3i2XSm11Bp7EQX90FfsBM2fFcwD/1m/F3LOE4zVmSG76SJZ39
         BmtZEkdbfgCWZsHGnHUxMGdY9/CY5sluFkQ0lhvas64nB+a5v6+ynPgQFgTdD5MDylUF
         UhMK0m60tdLxo/3eUlYr73b7B8XQnZBPN+9//fnvSVVD+TbMCw1NsG1jyRp1WK4lclKN
         eLQnssbdjUDdKSP5TNp9ZMmlfCdpqDlzYfEfWA6wZqDqs66fZ5jLSqHO8OXynN1t4WLJ
         MQdsYfZka0ayuKbjOLMj6//jra0iW42njmxppjWDFlVQlXjqG4BIfOcW3vjzf7zIpopB
         SdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173321; x=1794778121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
        b=OO5VXivt3AVc5bkBb2O67CYJ2koixgT1a0Cli6RmimnU6AIbHDocRrmtB9X/IflJhh
         SGJu6kRL1dlTXVDrc+hXHQWGCF3PtW9Y1YQrLj2OMqT8BXR/WzHMp4mF4k8Dg+uAf6/c
         U5z/OdSbseeKoPR1XWSq1bR3ZnfXoIuR7PO48oMa+H7wNaxOVvZsM5K7tsJB68wbb/kK
         L3y8dVwDoLy/FSLy4zJW/eiqMfwQKReKR6drW741wP26J7RrIFP+2IbszK6wLHEVGQOQ
         dRhCkoDK70sGoJxJe4q4+eu+rRfhPP++424TUk7x6YdC+f+ZDE1b1oHfOSA00YG+z1WA
         NSwg==
X-Forwarded-Encrypted: i=1; AL+hErHDkey+BY0VFML/VpAanx8HfnMDmVo3ZY+vX6E/KJ/sKM1hurybCkZYWbgwW5LGzaS4nUmR0i+WKM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qq+AZjeTPKtWvBcywLBfbCi7HHhKRmESSXMrOiVLfMQ2yvjmg
	cSGddH2TwqumNrEbL5fJMZam7gfqnK7UwRQHLetm4B+ZXgriUG2OK6zw
X-Gm-Gg: AYBFou1rXPOJ2+PqogPrRyRpwVfNsGm4N8zDMSypEI0ujTKStP9orubMt2RtgcaBqTn
	VSNCe+uY7Ct1exb4LjvvSrRdmMoqCUs1FzEY9YrIj88Q4VgWRaHbrWizdNmnJH46bMHN/TIWZeU
	V/dYml3AteBh3Hr5d/HUlYvb7FKFS4CQJR9Qwmfk+UJYC4VMNnT3936uijGXyCU8WgkSiw1o/wJ
	/ErQVMfPOXCKfS8sLcSNguY3RHrTZqMPvXb8vCA3eIB8wN7lnvrKvPB02IHGx33/AV3c2kC6JcK
	nOWeASupw5tjWNIj6M33VH9r0n41U+j1TRiVYtwmHEuWU6zAQr/rDMm54YWYZ4WFb53b0gnJaGq
	jecL5zUy4F7u5MTGC4qFvIgZaJUzqYWSmL5qUgbW4+kO3JWDrlg8si/QiJ88ChliLhGmFnGFKLW
	tmlSYB4+5Pu00rt3gI3R7wVvBM9hY7IzUOmTfqhXLd28XnPswsgn41uLRQDZ9zxsA0kgn7LEvir
	sxOhrraI9vqTgrGXQPFNt6soUsUz1ADwf6Sf6ty7TyjRtxvP5m/Iiy8Gc7I6yknGOXWupS5KKtP
	rJkYzKLHDMChx3GQxdRqrBW3sPbiiN0wuA==
X-Received: by 2002:a05:6000:4808:b0:491:eb12:e133 with SMTP id ffacd0b85a97d-49589c3e6damr4580107f8f.11.1794173320934;
        Sun, 08 Nov 2026 13:28:40 -0800 (PST)
Received: from hp-z640.fritz.box ([109.76.148.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597091400sm5692050f8f.32.2026.11.08.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:28:39 -0800 (PST)
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
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 4/4] riscv: dts: starfive: jh7110: Add the RTC node
Date: Sun,  8 Nov 2026 21:28:26 +0000
Message-ID: <20261108212826.15890-5-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108212826.15890-1-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
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

Tested on a VisionFive 2 v1.3B.

Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 82ea63f71..14f92b942 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1206,6 +1206,20 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};
 
+		rtc: rtc@17040000 {
+			compatible = "starfive,jh7110-rtc";
+			reg = <0x0 0x17040000 0x0 0x10000>;
+			interrupts = <10>, <11>, <12>;
+			interrupt-names = "ms-pulse", "sec-pulse", "rtc";
+			clocks = <&aoncrg JH7110_AONCLK_RTC_APB>,
+				 <&aoncrg JH7110_AONCLK_RTC_CAL>,
+				 <&aoncrg JH7110_AONCLK_RTC_32K>;
+			clock-names = "apb", "cal", "32k";
+			resets = <&aoncrg JH7110_AONRST_RTC_32K>,
+				 <&aoncrg JH7110_AONRST_RTC_APB>,
+				 <&aoncrg JH7110_AONRST_RTC_CAL>;
+		};
+
 		csi2rx: csi@19800000 {
 			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
 			reg = <0x0 0x19800000 0x0 0x10000>;
-- 
2.43.0

