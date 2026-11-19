Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092714;
	b=IaOxCDLkw8QKfyDZIwCtub3n53cuqlUq8kjjrdkIBoieKs1o4QcME2zMMdib9WCgJ8PM
	 zZBOAmVkeElWaKvinbltOLMmNAnDjUDrZPmMOKIYP4HX305r59Bp8dhpsxPa9JO4IRBEk
	 mcLc0twSucZpl9itQOH8RWcL8XImMxD26qkSYUaLh8rky/guK0VDn1QZAYYU3tEjBm5jW
	 BktBgJyP077XGYWSR6jwx21o68rtB++tSX0APWzhXPj5fGKZSFCorE4wsNK8HDMtmb9/G
	 axvs8LG7V0+n9nrJNKLjuF6SaBh1sNQsBMDHuYpTB70C8n92pL+XqLsJPrAChVG/hBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ir+OchFzfMqNIfCQ3ME+6TTBvwXiIliHswVgA6zvQjE=;
	b=lxaizsct5EITsdTyvKpFeKkRrcJks6+hBg8NXVsQ+QOtuTtMoY4jumoMU3wrXHg1V2bv
	 u4D69+zW8AWj4VQThEoG9bm0S2h37Vtnj5BwZUV/i9gc/4OBiLt9l1Two7a2K2A5q210k
	 rFUCpiNnPAlxbO3VCRTfy1sebMAtuSsTcv8cOSdtEnt6/tXIPiOmBrqWOhQEB2HhVQ+bb
	 mjoKa1P9zpspgVRwdyn9wKvmwqbN02/YmrchBzsYWvMSmAztj2mhGWL7wmlZDAvWy+DNB
	 VtzQBuLydGOH2kZz0IRJzNFEtjEDqiGZrh4LZbpy6uedv7RfiUEPe+XodkHqdsaoD9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4J8mgHo;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48521606A320
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 12:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48521606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4J8mgHo
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3831d564bcfso543484eec.1
        for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795092712; x=1795697512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ir+OchFzfMqNIfCQ3ME+6TTBvwXiIliHswVgA6zvQjE=;
        b=W4J8mgHoN+j6jmioVoKW8qWUvqzzp9q3cpZAVKb2w3gTYd/zsdukxlUxsBjWvgmUo4
         ADJdOSKGTNCDEbb/nF+d2FA4TBZ41XNsQZvvEjHnNJj+jKByCpv8My8NIKqMvAN1g71G
         cjbUrTRxhxCCgZzrLsdKTU+7at6nNZH2z+XkIUm9vAVrFnMhILmzlpK02utycRdu/QW1
         uGqCXdWrmgMM5feOUClg1+Dstab8FHY53Izm5DaReea/siAvuXD2BdA8bNsfNg6XvIv6
         voUglqhhjtg5/x/sv1779GhNjmzVzbZ+wsKFtI4R3QhBLNlfRx7ymPaKmFHGJijy3OBX
         O6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092712; x=1795697512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ir+OchFzfMqNIfCQ3ME+6TTBvwXiIliHswVgA6zvQjE=;
        b=c1h+ro1Kplt7GRXle7yZdiYnICNnJ7vyYwFcaNWtlOXq2x/Py2AY3X/6KURK8DeBIb
         wfaP6jJTwOiHxwvVJCk5/0dOxzgvDTYtplMH3mFjXvRIG0zNaX4fH1TOAc456NHDYNUV
         fjPpGoXRWbVcbxuons06163ejegMroO/NYxZYj/jq1vrKjdLNK2/kfgIeWZb3l7d4wSY
         qsQq/sKO5xcLb8eUJz+/ysQmdoih9ey9HI4+U06MR0UDh/DK2XvperCKbiGa8F0kwHHZ
         wj1mtvVM05uOLN0LgdPBZJV/ygBo/rTYXn1iiO7hKV9xKtK8PkGeCMpqsZLJTOXAwGXO
         wNMg==
X-Gm-Message-State: APuU4Z9dp9CahBpp3U3P6n+8sHWHXZ0QRxvDij+fOuz0MwY2PoHdNPNq
	LhculB+pCBnCQtv0JieM+B2UhZj0sSmbszkph0t9MR8yXTJNwl8nNuZD
X-Gm-Gg: AZFdTZdb8qontCWTMq+eJ993ofvk9pssPoX64Yhj0Ir3R8M7ODySjSslx612guWa7ji
	Wdswt5J51Y35EuB5RS8Lq4EVO9r9CmBINhkni4vOde+yM1bu43QNcTKoAEZzy+bxG7278TKm0Gj
	pI9rORaw0jjMjvCN3Jw1rJqTQDn9/ZP1l0yr/XZcSJVDoqILcqu+r1Ac2IOFMVTJhWLwGUQH4wH
	7Wp9gKsfZo6DBLNEhJE5RFHNZPqlEPXoaO3i/DX7ypXmvD/tWw2Rwi89Il8p3bVabjXn52XzhDk
	fgTzjTKuZ//D5V3nc8yZx8e/yCAnNOb7QL63m5thsoTYgiK299qOhBvxISVyqZVHRcUi4vjUzCe
	OcKKpr51dN/Q4adH1q1ykj0I4ZKiP/KYhOFwoTCPae1YoxXBmMEDpt0MLMccHbxlfQz7lntc/PT
	F366+rruldWwvITLjfzTnSWP9bi2Di3xvixvRuGZq3xg+4Ej/Myur4jNYyuirratfk3oBfgCYtD
	qSrFnbdL1uCP1c/wunDTd/12UXmO0ocFXc9b4hPgs9mpsxlyttkgM5kTrJ6Ch5Sbvluxer9vbCB
	uawhW50w71nB3m8GGwHVkDuW4clSYylVIg8=
X-Received: by 2002:a05:7301:dd8e:b0:379:730d:db52 with SMTP id 5a478bee46e88-382825babbfmr5042232eec.32.1795092712297;
        Thu, 19 Nov 2026 04:51:52 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6800338sm17979371eec.11.2026.11.19.04.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:51:51 -0800 (PST)
From: pjh456 <pengjunhao409@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Date: Thu, 19 Nov 2026 20:51:24 +0800
Message-ID: <20261119125125.75912-1-pengjunhao409@gmail.com>
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

VDD is the HYM8563's main supply pin.  Describe it so boards can
express the regulator feeding the RTC; the property is optional
because many boards hardwire VDD to an always-on rail.  A side effect
of describing it is that fw_devlink orders the RTC probe after its
supply.  The Purple Pi OH board DTS (posted separately) relies on
that ordering.

AI assistance: the supply description was cross-checked against the
vendor schematic with Gemini 4 Hydrogen (Google AI Studio); the binding
change and this changelog were drafted with assistance from the
Qwen3.8 Flash Next and DeepSeek V4.1 Flash language models, driven
through the OpenCode coding agent, using the HYM8563 datasheet as
input; the submitter reviewed every line, validated the result with
dt_binding_check and on the affected board, and takes full
responsibility for it.

Link: https://lore.kernel.org/all/tencent_B11DE1495C3C54CE186ED508E2CE5CE41106@qq.com/
Link: https://lore.kernel.org/all/tencent_9B1CC4BF39DFA325C2B5384EA8B0319BAA07@qq.com/
Signed-off-by: pjh456 <pengjunhao409@gmail.com>
---
v3: use the generic "vdd-supply: true" form and show the supply in the
    example; reword the rationale around the hardware instead of the
    fw_devlink ordering; replace the non-standard "Assisted-by:"
    trailers with a disclosure paragraph in the commit message.
v2: rename vcc-supply to vdd-supply, matching the datasheet pin name
    (Sashiko review).

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

