Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B044C4EF
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136021; cv=none; b=JbfyC7T36VJYIU7QJbBRbnkEQBswDOZHegaqYx5gP1eP6M962/gUwoRbyG9+RfZnYBSVzTP9JigzIAzuJOhdkfBoNkjU25QwuOlZ+Wp3p+PL1UAJOmlUjQoxIbolIW0BoZd4HKpaWgvcMbHL0hJhssJ7OaMe4ZVnf4LtDJVqmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136021; c=relaxed/simple;
	bh=DY0q0xPx63XcLnbKsfqeJS12HVZomAtI+ZEXuXm8Sio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppKTHLRnziBLQoQrddcRvrUnuZKj/TAenxxpZQ98ilJiPNfOxQP4D1U/f6G+NUH1ag1a/OyXjd8JLhb8YXQznwcaUUNX8kaIOaRmQkDJ0n2Qw8DCCRS1C8X2gZmOT31OPKQU37pVaK7OAyxsk6pX8sWdHB2smEODQi+3gqRIBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=razxKpvY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="razxKpvY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1338262a91.2
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136019; x=1787740819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGtbsIyEK58caKUAI4NkFCHbnbaFbCN/BWCCBxCs0Ek=;
        b=razxKpvYAHmvBivGgHX66raEsksttSnRdC9Ad9+jMaVAIWjWuz65YKSOm2CIDtObt6
         soIuehqYCU8gHleCpUj+Av75cyteLBpSRoZBeRAtwoS5sy12OCcrl+y6G7bTbzPRngLM
         34rW8iaf6TNlfk4zfdlwKK8ncBOc01XCFEbCOaDcrMNCV4GsZ4wVAuvbkKdXVxaF4ANr
         ntxiw8nhhSRkARqLInp+xdu0NCp/WeVoa03miBXSijEaF3RhkaYcr6mgI4/zfpR1hr+z
         KSC2BsfEqz79LMxeE6S+JtgEXgidyEJ2cuGXNr5pthzgPem5tTDaVRQgQETbww6zRcZn
         E3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136019; x=1787740819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uGtbsIyEK58caKUAI4NkFCHbnbaFbCN/BWCCBxCs0Ek=;
        b=oBgh1QlP8avrkwyeiXmACyDD8/yugBLUtJvlWQcAZR7U6y3NPmddyMBM/v1zsiWfsf
         UviBktRm8ua0BlpDUJCtAjL60XhghOtXar6R4d3nhejQZUO06vfTBgZ1jJVdyyjZyyX4
         q9L9O9A8JIZgRCSUiWjm56GekhCHAwDeR5DZTQDfg28P0AmCEclmv3C0NTZljtxMUaOb
         r2UpDCP+JKvoB/yqfYSjXSDtFDro4ltR+FU8WdRZtSmo3hvkVE4U/XC7/7rSonKG1G3X
         b4tHaEDO93X5jXJa2zYOX8JEVad0hoGXlqQDCWIgIpvGSRzBsTKERpDVAeNZvpOIhnj9
         9RVQ==
X-Gm-Message-State: AFuF++kbxFhuP/5yLW92Pz1lsxDIi6Wkf1VHClxG4UdMJe4h8NjhVc8V
	2hLx5mua44qwfGmPhdG7ZwtR9Q+76GozaE9DgWwvUMKHwTk91AbUvEVp
X-Gm-Gg: AR+sD11VnQRFD6Tn6d4rzGe4X7GmamBoanwCpGk0v4+PvJmleeFttY/ZFVNk4lTCoTU
	o/9TLGp29JiO7CciZaPt4CLbKIWpiDhM2osBUcpXzwfhTUpJywAvl5r1TFEdQGGqqyrEw5iQ1X8
	qk2POa+gbNG0pXZ4/1ZGxPubC5TQVSGZ2zzDCBKzNBL+ys2W2n2rZbvC5UBgleRchTcNol9GeI7
	i2UWPNTCBiKspFAguR13TI+9GJYYwjQK/Jy22hXkzIEhxTWYsX1aIROw/PSy/p9q1GLGvhKkG7f
	u/MsCYBKiiC5inf+fyYQ8Ia1p/viXymdIy0sfhqrL7YiskIhDQqP3uAI6/OUIVPLCfJzafsiyPW
	AwrSsX/el2Ye8z3NlS9EzVwHrCigLDrPSuflkawMyWNft65aq1bQAy/nEzf9OT0vJvkhYLU1jFB
	fftxOJAOY448670n5tZVVGMY7GLl7GNu10QiayqhCyer0wXW0Z6d9FrGCaGOatL1QnAsjA0Bykb
	g+zP90RxDzRiX+sqDc5/C2wxjKqaR/9lnHaKrBx4CXncNcY/e+uUoo4i/zSiUuZN3ZrVcotb7sx
	yS1Zz+Si98d52vLjVmQp
X-Received: by 2002:a17:90a:fc45:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-39580f6d136mr7421193a91.12.1787136019196;
        Wed, 19 Aug 2026 03:40:19 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:40:18 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 05/15] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
Date: Wed, 19 Aug 2026 11:39:16 +0100
Message-ID: <20260819103926.2136712-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
config option to make the driver available across both ARM32 and ARM64
Renesas architectures.

The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
and expand the Kconfig help text to allow this driver to be selected for
these additional platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v3->v4:
- Added Reviewed-by tag from Wolfram.

v2->v3:
- No changes.

v1->v2:
- Updated help text to keep it generic and not specific to RZ/N1 SoCs.
---
 drivers/rtc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..d23a0fbe8d89 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1635,10 +1635,11 @@ config RTC_DRV_RS5C313
 
 config RTC_DRV_RZN1
 	tristate "Renesas RZ/N1 RTC"
-	depends on ARCH_RZN1 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	help
-	  If you say yes here you get support for the Renesas RZ/N1 RTC.
+	  If you say yes here you get support for the RTC initially found on
+	  Renesas RZ/N1 SoCs.
 
 config RTC_DRV_GENERIC
 	tristate "Generic RTC support"
-- 
2.43.0

