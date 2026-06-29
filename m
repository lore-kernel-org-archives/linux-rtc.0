Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD7406821
	for <linux-rtc@vger.kernel.org>; Mon, 29 Jun 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736953; cv=none; b=LtZrMrSMiaWc1MRm9x2By9j/87Q7NSVuOHXF+cjddrdcIkujaEBRMZvg0qxkqedJu9z/530FfZagLVpSrpQwij4xeJ9i0Tbp84mHJRf9PN5fzRnnjlA6yd4QfTn72KV8ZpNOLu6SSdfjf2cfDIGc4pHuP8PDDDfwAgzZcIZjAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736953; c=relaxed/simple;
	bh=VJAHuue9pm1FiRZUd8IJhSgHvJF2qQrN+3NPC5/4llk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+ji7f7HFVMpRwpmfC9QFvkpM1roS4oraSzEdLnUDVVENWUhWbIKgbHnYu/lZNUdOSm5Hxt3pvZefudc1S1RJOLJHVrmFoYNGOsCkfnshjsdbF4GQIPKqFOtN6NWTaVwZxxtz4mNtiyVvhUODMcb2N1RDX1HkEniKDs5nVLU5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A020oAqG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A020oAqG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493a285ff0cso7767245e9.2
        for <linux-rtc@vger.kernel.org>; Mon, 29 Jun 2026 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782736951; x=1783341751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuY0GYLoz4Pl54AHbNMD46lqQfrjHQuItDMfVO0XptY=;
        b=A020oAqGgegFwxEnN91E7KAUxzYTx9izH8BnPrlKj4CEXNMxHHRQ+lD1G30vflQBos
         HYQOMce+mO5YDeGXhoIvdNKI4GmJbjDlodOlYC1qVw2Fj1j/JzaFv8F4NilgqEkHELiG
         njfT27MHaE4oDE6MNhdz+GkJ21/Qj4WiWQpxxymKvE47rl5m95jcXOmly+v4eQBy1gQw
         qusMkApJUU3C45+m3vXNKXpYbv9mpegj/FvzxxcMREhDfkckbpT5AdyN6cb86f6Hr5rH
         BOu+bqFTMTEIjRZROfIDrr5v+uCKQmM3j3b0g04aqEPEGOs10EwLp2jJDtBH2RISVxwU
         cXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736951; x=1783341751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RuY0GYLoz4Pl54AHbNMD46lqQfrjHQuItDMfVO0XptY=;
        b=S8D/ddV0PfVf3rgj2On4CJs6N6iTl0PzaIv6nyFmnnOzWAEDk3Y+7jZBOZY6hyne7m
         mKl1zbjw2DZxGWPw5xKo6ow6G9v41iUjmBAjvCm8yE1X2BrBl4iFdaVQUO229cRs8I/J
         ARqtfFl6kIjiUD/qktLupME1C9IuGwiBHqT9aaHLyhpcgdNVfjGUrIdc9lXTKM85BrPw
         uDHozAxKYTlvV+J1e755JjlhjfMXZcQ4FR1xbOOjOmJ3eDSSTB2uNwxevYpvsd5C1IWl
         tQ8FnPzPNfr+/9obIEiyjfZn2NHpvOV00AMk4/pcR/duqAquOtBEKolugnsb0Ttfx2eT
         IIaw==
X-Gm-Message-State: AOJu0YzLUmG9awC5kNNHKLETxCDXfvLjaBqi7m+hRRCkiTj6L0mXKeBH
	mO0lMly8aEXspi5ffjlXX9Ht7NJgcc7l1OgxF0CYqXrIT6MsN2DUm2FvtERak+4rTt8=
X-Gm-Gg: AfdE7clNVeh5zoKGgW8KXXY3HsYa5SAily8WOFyRH/DZMg5LJ4/k1LnwDxU+Z1yWNhk
	SKk6/00ZGe7m3yI9UpQmy90OZAgrQxwyMlNB4CUm1kMbX3405+3ay2Oo8Erj8LI6kUlF2dNGJPv
	pbbPcZlwbdTSvm3b3oemXEMHSzFHTjeBFtn95DzKIfh33wsfADss4IGfecQ7gPOUXXTp89j8Gkt
	n0e90SRMxPNpcQD4DesxyhXM3GQ8mjMXnraNXpAxZL6QZaDMYgwUjUV1rU22DyyLyJYhcIo+Wxg
	Kz3yHcqzwUdBIUZ7pqcmfBN2am1+rbVKUFZKK29WiYprx2HU08hJjoNGFjsfCFycz7IJtgoJJdI
	GvYvljCliitZy7T5wuvKDps+JRK/TeNtr9w/83RGPygUbX4jUcjOigexvaIJLtW/AMcvE1maT
X-Received: by 2002:a05:600c:1d86:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-49266885dc4mr249806255e9.27.1782736950484;
        Mon, 29 Jun 2026 05:42:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1d21:f5d5:2d3c:23a7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493adf3d98fsm80822085e9.8.2026.06.29.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:42:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Jun 2026 14:42:05 +0200
Subject: [PATCH v2 1/6] dt-bindings: rtc: sun6i: add sun60i-a733 support
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-a733-rtc-v2-1-7b72112784f8@baylibre.com>
References: <20260629-a733-rtc-v2-0-7b72112784f8@baylibre.com>
In-Reply-To: <20260629-a733-rtc-v2-0-7b72112784f8@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=VJAHuue9pm1FiRZUd8IJhSgHvJF2qQrN+3NPC5/4llk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqQmgtW52pl9ymFcc6wjZ4sTtM/p/LNN9ZtDgRc
 WKlUartlpaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCakJoLQAKCRDm/A8cN/La
 hbtuD/9w9j2Osb71WII1hjlD5NY7YjH4OtroF8D36BpXiVm1yn4a+2So1WGl3c1Ng6kXeswAdqi
 Voc7emUXjLwvfHsTqWpaWdw7nYDMRwFYL0z8vQEVAPFqOWNOnqe2q84vAcN7lXe3H/0MR6Dipw4
 g0g0wS+fNOAkq47suPO8WtnqTcDxTCb1xQB5oXHSoioI2Wuy9HdnQDzKFd6UrvrHxq9CQAOtQJ7
 MMcdfmPkKBjxgCm7o0VOlJQfv4b1A66MTB+YyvJwwfzNM66Wl2iNYAK0UhaDFOakyIAMN4C1d2A
 /P1q/fSXLrE3bnpqILA0uwSphLEnN5RHT2zXBej3qW0ksFQDe+9aCDLB2Lw0Ylnu/nD+NGqZtIh
 XcMVHEJrtK/nEL+wBQwzZZ2ge+MajYiUNiki01R4uTA0degnUSWthT0cZX+Uf72BplztqN+YrzK
 ntskS7l4EhTj0lQ52MUTSv7tOptAZwGgpvuggGeUj1rSkh2OKdVAMNlCsOAC/ow6qrfq5sba6qY
 /70T8N708Ii+ljhUX8CDE49RJPF1KvZn1l1F3yMdmpEM5IZEVMcDEISSUcUNDBMz20QbEp49Ejq
 9xcudU3c6XaQn42dv4yVj9Ff1l3plINHqKVyShMj0fg+2j55Ft7u9mPtoRK3RLkDLruVp8Cl8Vx
 sJZ80FAnPrdMTiQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a new rtc compatible for the sun60i-a733 SoC and new IDs for the
peripheral oscillator clock gates of this SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 1 +
 include/dt-bindings/clock/sun6i-rtc.h                              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index 9df5cdb6f63f..197a6f67b180 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -33,6 +33,7 @@ properties:
           - enum:
               - allwinner,sun20i-d1-rtc
               - allwinner,sun55i-a523-rtc
+              - allwinner,sun60i-a733-rtc
           - const: allwinner,sun50i-r329-rtc
 
   reg:
diff --git a/include/dt-bindings/clock/sun6i-rtc.h b/include/dt-bindings/clock/sun6i-rtc.h
index 3bd3aa3d57ce..5132a393ca4b 100644
--- a/include/dt-bindings/clock/sun6i-rtc.h
+++ b/include/dt-bindings/clock/sun6i-rtc.h
@@ -6,5 +6,9 @@
 #define CLK_OSC32K		0
 #define CLK_OSC32K_FANOUT	1
 #define CLK_IOSC		2
+#define CLK_HOSC_UFS		8
+#define CLK_HOSC_HDMI		9
+#define CLK_HOSC_SERDES0	10
+#define CLK_HOSC_SERDES1	11
 
 #endif /* _DT_BINDINGS_CLK_SUN6I_RTC_H_ */

-- 
2.47.3

