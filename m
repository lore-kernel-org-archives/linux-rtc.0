Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467784;
	b=ZteovfFcqp2LddL+GZivfDVYX0beA2/W4rkRbHmXr4NmXuMG7A3g0ef7BgS+S56dXJi5
	 QoQ0QgQTw6fQ6tt1Nxs6brR3eVhc0NIzTe5/RKvnyapW1MifdxH9x9lgKBu26AtPPiGPK
	 vHpQR3NVp+5Bcz0SZT7g37r4LDpThZ3OD6AsRvzOEe7mgmmaVnfY6y/cLI5jX9anGcKYD
	 9yOmOUR+slYGQqLUah29v7bG8hpVqCCgoxHreRvbTgE1CyVMiv/jJJ3UME9/FdgdgD8xU
	 M/w53knTK/K1kugfKpfG85ZswnlcDM0/2n14ohDA8ARg0TlOllGmDQad8/qWSkHGo1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467784;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PdkmRjPwAg1KzHHgw7x21crSWqWQ4G458TrqdvmwyfM=;
	b=V8W9cd2MK/cmhRTgm52Ujt1Nz2kgOeg2UfWULeTluHM2rqbfGqMGgRVG/xTysX0lmImI
	 hBI3BfFT6Sv31vxoGsFPa7oFQf/dwzNrNMd14dP2Awt3UAcNSbNLMvrzvlDqXMRqoqcaY
	 GYGUJDzcE+uomQRu2fqzeoRe2PsdM+akfUjiffAEWnNthfXBB+48X6c+TY1fjGOQk8iDU
	 Q9QbhS46+Kz27zDT0ZcLoDt8XzUjCmbxGPTU1Vvo9qEVbxOgyKZDPmJTOaXJmLO0yNAj1
	 uVA53Qt7xa1rdHCm2K27j6RWm7PxI2PpZfJ8WjLrKAOc0MWVPODWdYiwof9RBLLPWGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PCppY+Gq;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613DD606A89D;
	Thu, 12 Nov 2026 07:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613DD606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PCppY+Gq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PCppY+Gqo+NufPRHYj1b9Xk/SLm/JaZYjSCs4E8haD//ZwVaLPJ0ITBgVFUq0xJiDszQWy0iP2+Sa
	 MDxqVfcotNAdj8Y2UWrhVTnexRYVSJToTR3dHPVQhNeiRo0vJUPxlxtSlmMhO2Th7aNbrTpxjwuZvp
	 +GwIfZPgaXVoMDco=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af567c53b8-dfe29;
	Thu, 12 Nov 2026 15:16:21 +0800 (CST)
X-RM-TRANSID:2ee76af567c53b8-dfe29
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af567c4a2b-f6dbf;
	Thu, 12 Nov 2026 15:16:20 +0800 (CST)
X-RM-TRANSID:2ee46af567c4a2b-f6dbf
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] rtc: ac100: Program clock divider encodings without subtracting one
Date: Thu, 12 Nov 2026 15:16:19 +0800
Message-ID: <20261112071620.154398-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

divider_get_val() already returns the hardware encoding for the
power-of-two divider, and ac100_clkout_prediv[].val is also a register
encoding. Subtracting one from either value programs the previous
divider setting and turns encoding zero into all ones.

For example, selecting a 32768 Hz output from the 32768 Hz parent
programs divider seven and produces 256 Hz. Write both encodings
directly so the programmed rate agrees with the requested rate.

Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/rtc/rtc-ac100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index be57a33ecf53..a94248346bf3 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -243,8 +243,8 @@ static int ac100_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
 	regmap_update_bits(clk->regmap, clk->offset,
 			   ((1 << AC100_CLKOUT_DIV_WIDTH) - 1) << AC100_CLKOUT_DIV_SHIFT |
 			   ((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1) << AC100_CLKOUT_PRE_DIV_SHIFT,
-			   (div - 1) << AC100_CLKOUT_DIV_SHIFT |
-			   (pre_div - 1) << AC100_CLKOUT_PRE_DIV_SHIFT);
+			   div << AC100_CLKOUT_DIV_SHIFT |
+			   pre_div << AC100_CLKOUT_PRE_DIV_SHIFT);
 
 	return 0;
 }
-- 
2.51.0



