Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991454;
	b=iw4kOFLWbk8j+R9Fk6T/iPKbrSiWB/Nred6bzlIBAhDhsTyqNaP2wfLDWfq0MV8XAaFG
	 EFJJuvIFeAjL4FYWa67kVAPj7/jDVaqMFDPr7gy4GOrrk9ez6tLv8ayNMfExEKOKNP8fM
	 Ej/pUtzainW/UTcL3m/AsOtqjseKRUxyTTlSwJH52tGPFOHVcrMlOGFFdkazRKMq5Bd4F
	 0SdwKHkwRryK4jZ3eGujIJ93EfsVE+MPAK1BnSzKIb/BCj+SPIEvXaCag63iq3r8mgNoL
	 5ZjS+2CYWXFsAJ886i8ZobCbGT6XToADChZxsGvc1XEfxDKMKmhunhJoay2HmHtk34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991454;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6OuPVMkj73tM0Hn4WHVqIWErfxxFv7XrgC93BkZUp5U=;
	b=frn38lD+p56nJFdUAsLZvxHUewvTj177UyQXYAdRjdSCmeQHTl7qPUfvj4qacaKeL2xz
	 w3rxckprHZrdZibyHGbAy8zyrxHcj59b1Y0eRfbgf+GA3023MWpgL6H91V55eXgOFwk2t
	 Y052Nvut/g7jPKjuKMWgv6o0O9gbswVK6HDrgRXo5hfb8JAIWTGPD7eEVhfoy9XE/QLCF
	 QQWgzI3XcC0NO3EClf8rARpgQBYjMxeeAEZM5AeNl4tLUNHJpolJoxb9fC+HvNSi2F9RN
	 rggCyCLvD4+RWm32bIebflOSkmiNpnfLu0jXjzJ7o1dNpLNZ5NAtHVJBXXKYgpRFPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iCJnBw+P;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357D606A31C;
	Wed, 18 Nov 2026 08:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5357D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iCJnBw+P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794991448; bh=6OuPVMkj73tM0Hn4WHVqIWErfxxFv7XrgC93BkZUp5U=;
	h=From:To:Cc:Subject:Date;
	b=iCJnBw+PIcykmHIrXQMsyS0O2a5fEQxCrjrgvb3K936HRDCpQz9YskO734uiwLTgi
	 pc1fhV/aliJFF/gIaH1ct1d8QLs6u5pgYu/4i+hIpV32LE0gXB/KBoxi/nr9PJRZ1g
	 j6drgCfq2J95Uisj46pMfZ2MiMTDxYElHvG7+nmc=
Received: from pjhArchLinux ([211.64.159.13])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id AFA0B454; Wed, 18 Nov 2026 16:43:58 +0800
X-QQ-mid: xmsmtpt1794991438tggvabeh5
Message-ID: <tencent_9B1CC4BF39DFA325C2B5384EA8B0319BAA07@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtkaD0bdlGTbRIJDkWW9f8a0xn7DVhaqrexT/X7Xkl1zxeRlKK41
	 Vsnks7gWLko/J9YvNkxAOy8lmmBnPn5rr4xXTeo2pBah1394WGN2rFgQUlsWHmiu8yDvy+7lVy25
	 8KEMOws1sp30yjSCX26b3VJu14OiMqE1NcCausy+JRDBya4M3bQceihHOkPL5xGOXOGiYaaLSbd5
	 9ebGB6b2JPCLLcyJzr8NEV/dNA19hVKDSya7TXMSXeAhyfGPXrAzguHLGykDMTRNB615vYiU3FHB
	 0Fw69D9eH7gFsNmexEVoz1+3sE7DXrKPKc+Ln3s7PvzUD2FgkF92AblgyOCNNQElV2OkHBZWrD2W
	 denQHoVjqUy6kLEBiuJbboVxaBmgiJCptAQiQ39Aqut8viWrI1FUOeWYnpZ2UdjcwV+Vjw6lvJKN
	 PVhGq5yf8skbV+qErbjPDjOmCO8aiKIVAxUhGQ9PNh44QVDxWkkhkiOFrOzngNzn8uMh32y8x2JV
	 YdWlJWG9Dx858AS/diDXUUjwOuQDOhv3Cm1GCIkgI8yYo23Wo1VoojopFsk1a3kPABmwdjZ79EC7
	 895kUnildQUfJRF7ZfwXFymKqQoFmCRz3ajr9ARUrdAgaDODSDcRCrajoc4QbbOUBk+p1MPTKHFe
	 OdthdoiD7hOySdKT9v9sd9OANHKDgL0cUMPR6r8CqpoiwU5NNzvll2gQNaszJAj9GZfVDFo4MHlT
	 Pd6+9te3Na6QfuhvC5YRN+9kPh7W0vPIm2ZwpX4fQ/o9OAfj2ToGCOrQibCnjdJ6TP6npBn8Nvky
	 A8gpfiAcnk1J5UpCU7WLCCRr3JIobtnfEV6uUCzvNlndiiTlQFkX/3bgMj3UV1oRwpb9Fffv4Bx/
	 SCAVklbroeIdI8ofmSWpts41X+gRpWXRBXK317qYRaI3vopCIyYnrdVrOeAuxAimUO1wrjTJl0BS
	 v18GQY9t+9sSYcGUAn5LMJqdtuYmexLEHhzbONP4q+56JQ5N6WHCNbKoTUsQMS7jmXk0YVaZwSdX
	 WIOGOkF34hLeVJhMoxI8FC0rKOzh++FW/7qwThE5qbzaBaDEI+KkxtJZX60Uw=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: pjh456 <147148383@qq.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Date: Wed, 18 Nov 2026 16:43:54 +0800
X-OQ-MSGID: <20261118084354.18511-1-147148383@qq.com>
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
v2: rename vcc-supply to vdd-supply, matching the datasheet pin name
    (Sashiko review).

 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
index 0b9f39ef0edc..8c2ab43c72a4 100644
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -29,6 +29,9 @@ properties:
   wakeup-source:
     description: Enables wake up of host system on alarm.
 
+  vdd-supply:
+    description: Main power supply (VDD).
+
 allOf:
   - $ref: rtc.yaml
 

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

