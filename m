Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174548;
	b=vp1eCVOmCjEKzJ87py29QF28RlV42F9gaOykjQh3SF3f2YM6h2Z72PPqiiUI6X/vQV7S
	 l7X9mufW/LysZv1iKYz9Edkv/TTGbop64C0dSlYvrXI0cgEjEX6b9kdmsa8g1Jg/Omo7q
	 e3GYvmj4djT9Ev5/ZwV8fPORivPlllpdmz0JIJ7MXKdn9FCIwspfZ3hWdiSuZA6TEgtkN
	 DLbpne5hykQ5rvUgWouDi8hhKnv+uA9b2XSa+0Mo+BrG7aLeZChbB5B5k5s+ffyHimlDG
	 nYh+LiNVLfVmASqJUyjaBYkho8MFUMkGdehZc57HNGw+2ICFRtnBzZtEWfbDZcpoyyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HvhrYvkQJ5ZpS127ix42A5EcPEqRi5eUCbysMzVh1pA=;
	b=ztUfIy1s5rHwENDcIIvMUy7G/u92ar7a6a76cXP75HSvLtDCm0EoirlgsKakAuT2Hv90
	 EWKhGq7ziNyJFjfeqfPL1dUSWQkFbp7ljSYIznr0uwy/Q1ucxLSivgXbwrQpxghy88C2L
	 XgE98ydHBsGzRq8vW+zirUOCBBD3c+2NFQ7eCKJIJWGLMQZsb3ohSMUUfKF5cTTMgGcoL
	 5t3TB/aKKO15pYWFPQnDqm/eTEEIEjQmmkfkDmp15YvdK8OoLNx5y46tbOsM/P4uI3BLW
	 YcIVADTDUv4XiNCDXkir1t2KnGGmozZbryvbsJ+rbIo5C5xEP53qbrLHlUsoq2lBNag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8804Fsh;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854A606A325
	for <linux-rtc@vger.kernel.org>; Fri, 20 Nov 2026 11:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0854A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8804Fsh
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3831d564bcfso270976eec.1
        for <linux-rtc@vger.kernel.org>; Fri, 20 Nov 2026 03:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795174547; x=1795779347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HvhrYvkQJ5ZpS127ix42A5EcPEqRi5eUCbysMzVh1pA=;
        b=F8804FshacBXUMg/wH4Wtr/0VP2vIO3Dm4XpXThTdTquux0tCMMcJdodOwqqYYLeut
         S+MXrTtXtCRvItpFAva9SlwOYDjY74QZ8AhJIv/9LZEOPqXRSvxNprxxPo4cnQdxxwuS
         ytmVyXPxChg1iabq3Iwd1F1vHJvuNgfYp473HvgpMKlzbvZDVuRqZaSP+n1r/kAHUh63
         3f7E4sH6Cyfh4VDqd7+k9spmogKiOLKHTrcZ5jxA8lGylgvNNr9zRYFOQ0o1ejpA361z
         d2wACCl1tPsoQ9IBb+DX23jOmvaIQShaxhykkpCutMA3INrku01gF2BLqjrdXH0wNZ+1
         NdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174547; x=1795779347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvhrYvkQJ5ZpS127ix42A5EcPEqRi5eUCbysMzVh1pA=;
        b=zhs5Yq+ND8GWnFfNf5mB6nnospbShAqYAwaL9KQ7QxC0+6yXHDWW6mmTcIhzPf1o9G
         zP5HSPf7ESIp2OYFLbsvg6Ji4cz5KQQPZ1v1qoZD256KVWedpUUMpy41z7npzs5nGuKd
         HJb8urxf+6EgDWQbqqVO911qWoQu11+5TNK9tx9LPiyNty2tv3yUlrO6r9pMmwFrXXAd
         yS1HR80tiTwLgw/E4E4L9jvlApwdV82byDjYifrF5B4x5YeMlpvSw/2FbVx7UmovUZBs
         i+JiDh55wKSCrqNkYC1X5X0G14iicM+uhe7m+e/u9rYij3HSfdze0MqSL7ugPI/nZx5F
         jEYA==
X-Gm-Message-State: APuU4Z/bSeJpi9IIh8nF4maKMV2dGSrjuofCon2CpFGfZz1ZgEY8+bIb
	Q3rRN/GSOI4W4+rEZGds8atZe5v4nV3muSsv2wSRE4dhHLyGSDI+m2c8
X-Gm-Gg: AYBFou1YVVvKvgPYWf1z1AZj+sHzHzh7G+SeyxkMPUCKgJPEOuva1C0LnOIMRvF9PuZ
	93KzIuSbtng50m/tjY/PVB2wRyyHpdaD+oCQ+W8PJ7LZUlQbQcVXPd0cF2VbNCXCNXipWNCz7Vc
	L9pxgqZuvDM1ogfbbYA8hw8q0yIqoeB8T/l0JoNAYHDIzboRGP6Wq7oqhqVNRfssFu+XDNLnM61
	0VRqczRImIeNtMpyq3BqyVdmOSKOEOjgjimWx/hpfrLURYVIkQKLWgqYT8/pHXxGH6sjUsofjT2
	s+Pjkw9XXOdoMlzP1FjtvScXFGpmGrVmL/SxUBWwrvuFUNVxaB5h+GYhqyi5PjOLzgDX/iUZl1T
	FhHtvjx7a9VddK8t9YhrJV3KHrTcyeUacL4Ga6S5VLaMSgH0jK5FUGk7gbvgkmkYfQZvl2rB8ub
	OHVVwEnL3imuMItm03WiTc7RMG9OuA/qvd4c/ZDVS9gZWOjtnJviBSjauaIKKfrlA/WPKl3Anlr
	1XV6s7ZF8WqtyXaA05qVXs776wNGJYI5tphyoGp9tFVTwvALVunKQR0wStUiQsCIr66PEs+yLj7
	qHuObgTEZh6MnvArtcUP4xtXHtqRDII+8rU=
X-Received: by 2002:a05:701a:cc88:10b0:151:6e80:ba7e with SMTP id a92af1059eb24-1b5567dcec1mr2519969c88.4.1795174547112;
        Fri, 20 Nov 2026 03:35:47 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm6274610c88.10.2026.11.20.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:35:46 -0800 (PST)
From: pjh456 <pengjunhao409@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Date: Fri, 20 Nov 2026 19:35:01 +0800
Message-ID: <20261120113502.563894-1-pengjunhao409@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The HYM8563 is supplied through its VDD pin.  Add an optional
vdd-supply property so a board can describe the regulator connected
to it.

The property is optional because some boards connect VDD to an
always-on rail.  Describing the supply also lets fw_devlink order the
RTC probe after its regulator.

Signed-off-by: pjh456 <pengjunhao409@gmail.com>
---
v4: rewrite the commit message, move the AI disclosure below --- and
    drop the version links.  No code changes.
v3: use the generic "vdd-supply: true" form and show the supply in the
    example; reword the rationale around the hardware instead of the
    fw_devlink ordering; replace the non-standard "Assisted-by:"
    trailers with a disclosure paragraph in the commit message.
v2: rename vcc-supply to vdd-supply, matching the datasheet pin name.

The patch was tested on the Purple Pi OH: cold boot, same kernel Image,
only the DTB changed.  With vdd-supply, 3/3 boots registered hym8563
as rtc0 at ~0.6 s.  Without it, 2/2 boots failed with -110 at ~1.37 s
because the RTC probed before the i2c3 pull-up rail (vccio_acodec)
reached 3.3 V at ~1.60 s.

AI assistance: I used the HYM8563 datasheet and the board schematic as
inputs, and drafted this change with help from Qwen3.8 Flash Next and
DeepSeek V4.1 Flash through the OpenCode coding agent; Gemini 4
Hydrogen was used to cross-check the schematic in Google AI Studio.
I reviewed the result, ran dt_binding_check, and tested it on the board.

 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
index 0b9f39ef0edc..ce9712e2c406 100644
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -29,6 +29,8 @@ properties:
   wakeup-source:
     description: Enables wake up of host system on alarm.
 
+  vdd-supply: true
+
 allOf:
   - $ref: rtc.yaml
 
@@ -52,5 +54,6 @@ examples:
             reg = <0x51>;
             interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
             #clock-cells = <0>;
+            vdd-supply = <&rtc_vdd>;
         };
     };

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

