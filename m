Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989122;
	b=DNIXVoarFz9gxBTbD7mhyN7DordbMoulVIXrHRluEDRLeqQmCuTRnVkHLKzOgamGPtKv
	 HCL9bpcn5Isd27FTY4Os0xFILOAfLxV1JvBOvTY7JXQ6vlKjUJjezt8mz6YDUWJQYFNa2
	 ch0/N719PUKRm2x1u4c34VkakEZH0YYT/oNmMpumtipsotAG/6mdWKV5he3++b/m2sKMD
	 LcFsv1cCwtfLrmVPekSGWEXePdaShIskY0IM107Ec5h0RWR+RyC4/QLB9LX9+5aVTfaMc
	 imi3ltCfXZ+gC4x3mt0JLtYcT/g48oc9VbIpJHRnrdtglmtNYwU5LQ3ffOZhVsgsJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989122;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9r24x4AvFep4SRTSxqwwJtX4FnlmcF/WqDIfgX1BsR0=;
	b=N1Vhk5M15qQSqH0JDlRoVTagRF5You7gy+NM5a2YbFsN61/XFY4zjGLLiE7mloHa2BG9
	 d5GkkS3c6ReJX+u+VBqxyL/QeSQ5NbMeuXYjm/q/oyqEwDgyHUpOe3U/4JPFnKW62GW5a
	 t8rn42VeH95nRBVnnqn4I6ZLQ9AxH9ai4ygqjDzUeEpHsMZxgp+GS3NFOlnff0xKdbqa+
	 HwRbdch1J/Xrm3gdmv5JIATgRQD1VMGTo7ON03E7fAIeqAeiRTUboPyCQ38knbdKKL1JV
	 XmJJXctI+Ic8JlZbuoO2Mr5uBJ+oIURTpg5JHNNiZS+ih56E8h6vgQpyhRb0eOpOcvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FOB7Ll2v;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FD606A31C;
	Wed, 18 Nov 2026 08:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FOB7Ll2v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794989109; bh=9r24x4AvFep4SRTSxqwwJtX4FnlmcF/WqDIfgX1BsR0=;
	h=From:To:Cc:Subject:Date;
	b=FOB7Ll2vhOrnRM18YPbbzj2l++aF5+nydYIBsgaxECk+h8oD0Z1DWqx1fNQaxPkJm
	 8qKdGlUaJ7Xo3xWMtyTGP0D34S8E5HHTOOSctN1GzuUxcSJMD8rsVSCOgSX20w2kki
	 PApJ1jnlfSJsWLXHMdZPy6PCvzPVZisiyh9S0b4Y=
Received: from pjhArchLinux ([211.64.159.198])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 14686251; Wed, 18 Nov 2026 16:05:06 +0800
X-QQ-mid: xmsmtpt1794989106tsczewprc
Message-ID: <tencent_B11DE1495C3C54CE186ED508E2CE5CE41106@qq.com>
X-QQ-XMAILINFO: MJ4PQBQ4NCwQCGFB+6Z4DhkxdCyfshmz6pnwnOpq5sPsd1g2TtWB3VMWP0FtLN
	 eAin0HQwBBBvSLthkLFRSAZ+Nqawz+qC+4UFHZsvNF8I78AmcDu5nJL4ZKz0i4GcqNf/qL47EqUu
	 Dz5WQpPGv114SikADnj4ic7jyjMeB5nyG/l0mdpGSibZQldazsONYuxu0vKhH+eWhpCHTSwYwkBI
	 vA+1dHjxZDMTJ7QAvHpg0p1NuIpoOCyGkzStDlIeOwE6qOKmusMHqGtP+2EpLSng3tdXfvLbasP3
	 3MWFPB0nmWufQNfcA/O+l5trepT9tjKBlKK//39/ry16otaQOnU8bQpIz/iKbGl3Wy05hQAGRsYB
	 CId0G1r01vA36gWfUWqPGCiATMXDMY3kH3EAIMtOOhFPn8r8jpO0QpsotEgHsQmoRBZYZ/AoxIia
	 3lcvZ6B6X9GSF2YWzGlhqvl2v3TsB9ZkamCYKOXXgHceTxdNedKWzJA45+PYggIenDlHIxZMa0ed
	 FuV437zVvTw7eIaSqrLdYO51zu5aBZ8JSSwEqHs0MHivJSBVuhGG1rGST5U+nS/0UltpP+hLFwXF
	 uYLna2gokmi11zFc91Y6FG60s3Xv+wdG5WuGroGMy3HCP4wy3ynwrpM+cIds5in24Z0yd5DUKWKh
	 A26TF1Sa4u3yyD8Ht+XzqWcOEDn0ggg7fLryWpNP6nFealvSdNU/N8dZBxyLrb2Ntcm5yTyaJc+p
	 kZYuImBzouSeW/0ROqUrFp6OQcjOJKnlyHXzkyakclQaFow/gXlTxDgBkGx4qmK1KgoxJ0OzB3BR
	 BL3sCc1vQVP6I3oXKw4dHY37/9DFD38wb6WwKChgLHOv5tCj751Ybi+YY4AP5QJYEtY8OK74Gjj2
	 XPPjYd/xSUE9R+oBE4MeL8au2WjjzUImW9zVfifRKsXfP6vXX3bgatRa3zEwOGhkVNxGPM0G1LvN
	 TiXtALts+mW3H8gWQ50nLfdkikUFvHpcDWPfkWb+ASFMsSUoGdh5loP/6/1KnrF9WALpbTOrezMZ
	 GJuDVA4/qMKYcj2j3NCjrJfx3ayVkClsshoaIRWg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: pjh456 <147148383@qq.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] dt-bindings: rtc: haoyu,hym8563: document vcc-supply
Date: Wed, 18 Nov 2026 16:05:02 +0800
X-OQ-MSGID: <20261118080502.525530-1-147148383@qq.com>
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

The HYM8563 has an optional VDD supply.  Document it so boards can
describe the regulator and defer probe until it is available.

Assisted-by: DeepSeek:deepseek-v4.1-flash
Assisted-by: Qwen:Qwen3.8-Flash-Next
Signed-off-by: pjh456 <147148383@qq.com>
---
 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
index 0b9f39ef0edc..b27b250d3c2e 100644
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -29,6 +29,9 @@ properties:
   wakeup-source:
     description: Enables wake up of host system on alarm.
 
+  vcc-supply:
+    description: Main power supply (VDD).
+
 allOf:
   - $ref: rtc.yaml
 

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

