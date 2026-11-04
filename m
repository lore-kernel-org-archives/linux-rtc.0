Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775942;
	b=RijNPByjzTohPCCIYuadiPSeGuCLuC/6fXQKg2r8MkpEIdro3CsJN9GblUbS8w5hOGlK
	 dPfunZa8J8S9yvh6eoyVmY+XGxcoEt7GVdL2wGSuWsjX9QkpnhNCBVzkM3T8a2yKXZDbN
	 /ecjvPpswjIW715Ier43uTIir2NCixNnXAQCUWIjUY1BTSXFb5P3izDvqpw4ywtyAGxhb
	 7x0YIVFCAU9Vu8lO6jBaqM7N2+XPtCLfo8xyvplURowM7/ekSEr/aZ+jcrI8GM9nwNaZm
	 2ZsHVw1mldv5hwgqAnAAmm+gXn0y+Iq/p6YAQOAE1eVAtitJk01WtoyPy7+hZVdyyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775942;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TSHjcxig4GCJ+eyUpX3mG1pllJqSeO5g9EMqXYGm8kg=;
	b=1KTRmdwX3sd1j0V6ppU83IjBxS4nDf0OxSFGFqr2NQSZSGOn7Co5j4p+fPjpntq0yIHf
	 gkofadDrVCCq0AoTBq3JicKR0cG0/Vf6HO8Ptw3Uv4xfiL8qgjgCLkkOWR89k2mdith/X
	 izeNEyjTOLwTeu5YnDZddAPwk2Rzm0Xn7WxeKCN2PjjZjWF0O8IJ7loGFZFVnZY8w/JtK
	 lwEKIOo0uyuXQSK6WIpvLX4G80gM10+p0OUdH4t6lfjMhY1gwekHBGWOAU+kcZx8vbu7D
	 Ch0QGOmEb31EudDwvRJg/xpOk9K1FCccRFjEiqcp+gfpjGt3C5z4NBrXW8zhNEPVNHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=RKF+Nqtd;
	arc=none smtp.remote-ip=95.215.58.73
Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A41606A32F
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A41606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=RKF+Nqtd
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IgT4JYBbhdbw6rEV18MXTfEHZdeSfvl8xMkh2kFPu5Y=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775939; v=1; x=1794380739;
 b=RKF+Nqtd996VmRSJydke/grq8zlI2r3pydttmfRHHtJ+oTAmYISKd/OZAiJN5ohFt98VJa54
 LYMoXwgkTrLh721dFzPkLsPWxzaqvdvddR4jJVZWoNIa7ryGCJ2ruFoftEvYYrbdp9FVXY0YJSK
 vEBdfLAZUn2JNzZ5WwBwkoLoy93K45w0OCOa/dB0eocYwGVZIJxHqNyXysqSydlF2NNn2tn0v+9
 LQJ+UDjh16STdMnLWcGVut+7qh4n7K48tRPP0Zw75HmaA+9h+3Ze/hsYBZsskLtJKBjP00Ok/IC
 InHfVBPqHfJtBLjrBQ1InKQEaSFSedoe1A93kB1tJ1rPA==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e9035ecd79925aa1;
	Wed, 04 Nov 2026 07:05:24 +0000
X-Mizu-Trace-ID: e9035ecd79925aa1
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface Pro X
Date: Wed,  4 Nov 2026 04:04:32 -0300
Message-ID: <20261104070441.74127-2-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104070441.74127-1-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
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

The Surface Pro X tablet was listed as a single generic compatible in
dt-bindings, but a device tree using it has not landed upstream.

Replace it with three model-specific compatibles:
* microsoft,cambria for the orginal SQ1 model (with cellular)
* microsoft,carina for the Wi-Fi-only (SQ1) model
* microsoft,carina for the SQ2 refresh

Signed-off-by: Val Packett <val@packett.cool>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..74f46697a363 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -925,7 +925,9 @@ properties:
       - items:
           - enum:
               - lenovo,flex-5g
-              - microsoft,surface-prox
+              - microsoft,cambria
+              - microsoft,carina
+              - microsoft,caspar
               - qcom,sc8180x-primus
           - const: qcom,sc8180x
 
-- 
2.56.0

