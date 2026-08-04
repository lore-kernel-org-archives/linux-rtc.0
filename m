Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760593B14C4
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863200; cv=none; b=iQjiAjDhuiLqwgsc5nrzkPx0AQvRvuul7FIKfb/burpWa1g/39Cx6YR6veRdh9ve3LhGeO/rTqC3pc0d8f2Z3Ysdw+tZF5rqg3IkpDRmDsEwA2yMPtTYr/88IvGgUXvSmVpXnvSRORIGhyeCNP+QO90Kbjw/QFXrUW2IQSkuCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863200; c=relaxed/simple;
	bh=rlYXKYm7bxRlc5nv82AOtjM/efwnX96ZRyu8nzXNm1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvrQMKCdaoAoalHzR4G7mThQB6JGNiDlFu7f1o2MNcY/GJU+qhNBq83fpJorzfR8AxhaVnjqGBRlJ2UFcGEcNxI+iGcDdXPfdiGWbmQo1ocIQIJ0ZagGB7ZeP9Q4XBIQpnzUvk/+wfF6mjSvHtVYINOG5DjbjtWICbigVhcEY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKMxun8Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKMxun8Y"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9d290216d0so213503a12.3
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863178; x=1786467978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCa01TPtHivagUzVUSgUMDIazwCfZxCbMPkVHrUWfAA=;
        b=SKMxun8YCSIwBYepjKfc73k5bQ4TGAGk0+rL/0I2W3mRgR6jEoNciW49c3r/ARL3HZ
         xqCQRH+Ia5s1YFxRYHiDVfnl69O09mYehEUCflSmePeJkSA+n23O6ECn6sEaVKsrEdlZ
         FBRQgrmnre4crpxeMKtdAY5uznFk/vvGbuA/rDtXJXDjl9BSRmDZGHFHRNzYhnU5v2nQ
         JaxwQhYYGcEkyVc3OfpWUIILG8K9Bcyxrf3PskcGXbEBd6EednN8t8MD4Yvw0vkCyhC3
         KehR+2O7YmpvYiqZKaW4ZrFHGO4doHchbl32RPVHdCWxbiAxRevs3+lcTx1JoWJS3RTj
         BaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863178; x=1786467978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCa01TPtHivagUzVUSgUMDIazwCfZxCbMPkVHrUWfAA=;
        b=RZea8+yI2u4NaxwReBiRoetBteyFeYuYOCA4p9VweXPO5F12+E2jd0Po8TIueTdbIc
         kn57oEkN4sqiDk9W5yoY+f8pwHXtQhtN/i9bvZs0bZET/UZ5x0SIVVsqb13htJ0W2hpH
         hFT08RLHo66vPqGx8FjWaXoKH1GZeRrCtl1QHSs4Aztee5k4HOievrlazX2SrEFwNbg1
         MA8g6sVVq2Y/0L6MOh5qfRoPf0Bubj8PbNzFurCjRFW0uxAhK/fmNU0P6xM9D6fC4RsS
         Y2lhedlojWskigId9wMCrm5MSLoHr1VXWI+tNaIDb2YzvnfIS3roqqfFCimjS4YWgKcW
         bS9A==
X-Forwarded-Encrypted: i=1; AHgh+Rp62okPTWGFl+RqksIZAJwHpLHwB+s3++YnqhwDk6HIBe/w0xIJrvecCkmVKPvA2n2YCVY/wJvy274=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4UnSi4ipRAtvzqO5Y/Ptp6H9Fkrz6GwwS5BOGrPIoRshecrf
	u1tbjilumcDCuWJQ1yFPCPLbSAqZRcKclEz447opQqES/Wt3B+OcvKjq
X-Gm-Gg: AR+sD10IlUZ3BR42NSpIYfQnKeBlGafdXPU3ihTZh5VTbKYW8G/0xV5Nq0/q9b3rVFS
	ObRot12JuL/DWKyxiOkqNYEOUKf4ab2C+E+0959zy2gBKwTjLeZRdfeJ60Nk/T78T2+1zxIscnZ
	D3saSrQwcUo+G/60tM9hhTGNhpfdRuAYXCgUEXo82cD8W4HDT0WbhKbBNoEW60DusSPtN31K6eT
	biAO4Nz8nBSxzzEZTwWObP9eyLx9PEUhzMeFrJXkMU6OfZ/M1zvLDjf/JiIl/9UVmqCLNzHJ766
	dWQOO0YMRjlv6Vm84c2gxi1mzOVAsXD+YOJiCygitgtLEU6C6oSZ17e1C8NSvOEtzQsEWxRss3T
	/hU7W0VG23oSoBNdp6N3WBsFdE17xtPheD9CD594QBm+R3zxAaUTJEtbN+YSowStP8LkWRtnUnG
	zD6l9y5b7zOAlPIeVRgZDhVgy5yG4kw8KVIN/PmJc5vxCZAzvkmaSZtybOKf3BcpBt96EWwOw=
X-Received: by 2002:a17:90b:264c:b0:38d:90c1:2400 with SMTP id 98e67ed59e1d1-3903c6d434dmr472337a91.2.1785863177983;
        Tue, 04 Aug 2026 10:06:17 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:17 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:07 +0530
Subject: [PATCH v3 3/4] ARM: dts: omap: dra7: add da830 fallback to am3352
 rtc compatible string
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-3-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=939;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=rlYXKYm7bxRlc5nv82AOtjM/efwnX96ZRyu8nzXNm1w=;
 b=jRaD22MIYUlWYtJnE09LRZECtM9x23ueO9p7GAh/xAN4sHi7zwJ8+VFGp8hdOvWk7/EHjCRK9
 1vYWS0vz4qBACdUS0ueiRmyY0HGdOW06i1cXXM0Jz34WVwuJjLnUEV9
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The AM3352 RTC is compatible with the DA830 RTC. Update the compatible
string to include the ti,da830-rtc fallback to align with the device
tree bindings and other board files.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index c8d325b0f57b..9e9609cf3188 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -3556,7 +3556,7 @@ rtctarget: target-module@38000 {			/* 0x48838000, ap 29 12.0 */
 			ranges = <0x0 0x38000 0x1000>;
 
 			rtc: rtc@0 {
-				compatible = "ti,am3352-rtc";
+				compatible = "ti,am3352-rtc", "ti,da830-rtc";
 				reg = <0x0 0x100>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.55.0

