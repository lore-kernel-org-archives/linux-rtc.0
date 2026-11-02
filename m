Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638231;
	b=i8zGcYk1GRe48pcnsmiwP9WVl/yvQ9FnHPDjMD4cbj4JCekTcaZ0K2T/JK9ibpUf7Eh+
	 ZSDpA9pfh+9hFKOdejy57F6Lq0xCnGDB9HD2SKcy2Xnk64anraaKyldgeuIqegtVFmDUM
	 OI1xRHCoAyfEEbRL/Sne16+RvvLP0Te9rbJdx2c4Ne/ww9yX5w+LuN+UiZKPGHg4GEj2c
	 oiANvlvn4HveVVFAg/6BFDEUEUgoXfdmBkuXXqOSWUSUS26XiBE+nmcVBYv67ke5JOmvb
	 xxmxrWR/pq3q1U1WbF8tczJcRcIx9S+L7xVnJMT5L7rGXG1sDc3i+RUmlf5AqSwUQvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
	b=tcHzi7VrXTXOel2JDcT8l45+QzpSU+m+cvN5Ag5Wl/quiX1bmfbmYdav0ZLJfOiyJcW9
	 uJ3IhPZzXXM71/o0W9XjS0ZEEbPtx7lwC/cfIP7DYRDz2w/gFyBAKEvEoibJJYCuuHPe8
	 7PZ0Dr0amHVOIQxD/X6qqV6lQzR+mbKtuMW/rv8DTzuQWdTl2rsMgV9FJUAQY2NgHOMBg
	 JAcKcAutrG2aUtRZSzdAxcCK05rseZQ3U36T2JRhWbbXVJgfZ+iK4ZVgE34cr+djL9oZx
	 FvAPxWEVVsu5BMjzdfCDLyF2npT1wnjFXZCZk3CUdo5rxPATksGWSBcEUgJ7CwRE6eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0v6Qu6l;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4D6074645
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 16:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE4D6074645
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0v6Qu6l
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-84abe8ecec8so1367023a34.1
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638229; x=1794243029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
        b=c0v6Qu6lGqB/NueLXwCJ0MbujVdcNa7sv9DyU6myuKFeILKR0PllAb1Sq8tx/QGgA+
         NfzxVnnoiyT5gmxc7CfnMxcRZR2u99gOm4l2mYFJFeqYNSQGiWexUrEDEz8OGEdkpXEq
         ZoKErvxvBrvSxkn7YsEsokpzcg+042WJRx5YAGJQrWn6bV+KvOgC4EVVfOPUiNUYc6Bn
         LukM0cKT66JMYkHQAqA9257BWRnPtp7rbFFfCjFLYmLDVNf/OvNV+iWIk1yUEbFUzQ6G
         DWK0oYFpNaRxMasT0Sevyqmmos593gnGO/7WPzOq44iH4+Mu/XlUFqRryRkhIdQ70iQo
         R1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638229; x=1794243029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
        b=azNM08+XWN02A8gMaWGDEAFaebTSFf7jvJAUzXTCSr1vshrlIqY8lAWrqKo9Rmfof3
         a/r/03VWq783YsoZYvXUNu5IRFfZmSqixHTzpdzlOOZ+lgogF3iSrJkhBZ9MKNoc4hp4
         TRUfFimQOgdgvbiXTRVsrtnDDz1Y/1/wGaR7qAxSfavjzE4Hh7PNPP8r21iRcTeRrNFk
         bTyw5ovdlEjQ9YC0RjIGScppWEk84tdR2voDlwtLyHjq7yDgyrBdkH/f5dhccP4aKeNy
         ZxfZij6ja4Y1fovDRFUZqIR8Uy+Yhyy1FiEiH6URPVqwClRO00ZdvEmM0xsFiBWsD2Ov
         FV3w==
X-Forwarded-Encrypted: i=1; AKwUvByrr1nIfZhVknTnlTj1QDLx2H09AucVyOzIMr5Sydte+WWCUxdWmXpCyVxA1hWLBc5nllFZdZFZNK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHsdum8d8O0euI6mjs829QWaeRNsleM2N/rXLB/3lwKjp89IfC
	d1S+rKfU+LE76T5kDZk/Zyu8m5StYKxfItUTqp+Lyr9+0T2ciw5+/XkY
X-Gm-Gg: AYBFou0JtERerptQtNMwa0yKPj1vKrkK2qgfG70AX+1u+KYPh3X+o77VXN50e9iV3rZ
	xX1tpwlkFEDdG0lU3lyqkTJiur3iZ4lgiwESK38piodavN6n/rTTdbh+pN1pX16fJx0CvedkKLa
	Cn5hJwJMDPCBYFeLMqDCdv8+JwyK84C3SoY9PswjlmCfPVlrY881WkyxunkApghc5nklzFQQPri
	wBcWbsEBQhjTg81TjpPnlKx9HDeUkkeik7rF7dIEOdgtQ6mU/++BBvRkeKF9zx3uyZjbzph+od/
	z6b2QQCtzAUbUPtajHQqDATVm42hlZjXamsXS2jEfTGBNkmGXiTN2Hw8nm9pJp2uBq0jXYZlCwQ
	BtZc4dHk+wgNqbyPPHC8N/4bN3oeQar4rjM51pjTZJHFsM97AJxnZRaXtwcKHXvcQk0Bag5Xw+T
	LO5oMtfYaYaxCdl+H4ny6lpxzajs0qXvZuhoGFz6MpG5w3t80P/LIgG+rg+r80hhY6+kQ76pmy6
	2xPpNhyUvGmyyKz3EYjz03mXd6hHuft9U2+looMX5G81HZAzDv0TzDC+u81RTfGDEy5DERirhTF
	HCTwPpYwqAnWew5xY6skBz9aH+6K/f6bGWv7yausakhPKLJmE40KtjnpGHe31Us6FJ3/xn+dM6j
	765OQUah/9BHTA6r+3S4=
X-Received: by 2002:a05:6830:4487:b0:843:b6f8:de3f with SMTP id 46e09a7af769-85d365529d5mr7247305a34.18.1793638229426;
        Mon, 02 Nov 2026 08:50:29 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm9936779a34.10.2026.11.02.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:50:28 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 02 Nov 2026 10:50:21 -0600
Subject: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's 32 kHz output
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-1-19ca72815374@gmail.com>
References: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
In-Reply-To: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793638226; l=1237;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=3CyHV7hxEQyK84ACcArH+5qoJrY2fIpfuKy4fIAGdtU=;
 b=0Wf1b+8NmB4OEOpczcJRUHMeGyBxsbhLHqpUCilWHGZgwVqtkqscNpMc02ashPTcWUbtr4lgH
 WpE9hQMgNpfD6tqblyH80VYcqOYLALDE/Fh5XCg6akXUTVKecaowEVt
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
is off unless something turns it on.

Let the RTC node provide it as a clock.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 055625362951..3bfe1ad60d2d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -84,6 +84,11 @@ properties:
 
       start-year: true
 
+      "#clock-cells":
+        description:
+          The 32 kHz clock the RTC drives out to other chips.
+        const: 0
+
       nvmem-layout:
         $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
         description:
@@ -694,5 +699,6 @@ examples:
 
         rtc {
             compatible = "mediatek,mt6397-rtc";
+            #clock-cells = <0>;
         };
     };

-- 
2.55.0

