Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775959;
	b=h4y5RwhZjrDlUUa0UGcf7ldyp7tuNODFUS2JlasGqnvXPIUrR2aXQE+cyk0bjx8egdK1
	 URTrnEkinUj8fmBHE5GZxFf5l8Uy8LZwmn6nOIMaoZpbgqftRKS6Dm3y+jq4N06kNahxy
	 RBB7HbDwKEpb0JA5/cqAotBkgDp6zRdoZk85DuamtT8uxnARnxmeJpz1nH2zym8c9JS0T
	 Gf1Gu4/y8zrCaODl6d9sjrG7sL3zn6D1lL5vqOm0P57bAb4V+mu5HdjbxnkpMMReI1OTx
	 ddmCy437YJ0/xQbhu5CYTeHnTJF8lSwd/qQI0JE95fRQe7NqeGgEQw2sVPALih+o+UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775959;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OO+30Yb50y7T4yD0ARhMkPyAC4J2soG34s1bvx9hl5E=;
	b=k5w9rRWVsB+EiIuScEQw8TAF0A2JFUVCZjrZruO1dMA1Hj9uKCrdbBX+v6Vd3KAQ+g5y
	 /jY8VfWEdzs1rKbZBKUWI2E/rBEdIB9zR09/6YFhrBGDAfrlNU5CWR0LFtkvSqB6Y7FXa
	 i7Xy3nYuGc/gZoydjqJ9CIbnX3jAjIUGFbL99/qaoK0dzCTgDnQ7zzRRWJvlB8D0LApb/
	 qEWgGYoAsSlAwNjgZaVix0xdsZZSKzKEEb7c2r4gSUL1dSVJfITPtqeW6EO4G8GBV7kVr
	 OLCqYDhq2lhP1Im1n2EGcCOSbbKNy/ddyB6feoJtY1uj1gbw33uw99TPWpvoTi4KkzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=TjwnSOzV;
	arc=none smtp.remote-ip=91.218.175.137
Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED8606D805
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3ED8606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=TjwnSOzV
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wILIEGKN2ENtD6K54RLjFDYGlLPSYApDXSSZjkkU1wk=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775955; v=1; x=1794380755;
 b=TjwnSOzVoG3owQasyuwOy+4P58IFGc0ny7rpOCZxKfSRR0gmEqVhrZ2ClThYETqdjmENmuy9
 sOIhwYDAPDth3YP63l3FZolc5pGsA7+DNrcvj7cZRLXGDOy3SO1/v6B24IJsQP5n3UGAzy2ULee
 RN2EOt0mjGmExhfG3zOdIb3bkI7g7/8BXqCZgGvhesBLDEaNUgM+YA4StK5mcnmfVLLraWUkdPC
 nGPphf3GFltyoreQVZVJoMOBtaQfw2uxtYjGAmgvsIfAcd84z1RFnZfV+DkATPsRSDxvMoJTz+y
 WoeEr8FT1be3485GG3hTXEGhhcy9G37T87t2+xVme1AgQ==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id efed8c1f91980a51;
	Wed, 04 Nov 2026 07:05:55 +0000
X-Mizu-Trace-ID: efed8c1f91980a51
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 3/5] firmware: qcom: scm: Allow QSEECOM on the Surface Pro X
Date: Wed,  4 Nov 2026 04:04:34 -0300
Message-ID: <20261104070441.74127-4-val@packett.cool>
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

Add the Surface Pro X tablet (all 3 variants) to the QSEECOM allowlist
for enabling access to efivars.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/firmware/qcom/qcom_scm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 60949b71a3c5..7c82596907e1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2287,6 +2287,9 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,arcata", },
 	{ .compatible = "microsoft,surface-pro-12in", },
 	{ .compatible = "microsoft,blackrock" },
+	{ .compatible = "microsoft,cambria" },
+	{ .compatible = "microsoft,carina" },
+	{ .compatible = "microsoft,caspar" },
 	{ .compatible = "microsoft,denali", },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
-- 
2.56.0

