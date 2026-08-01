Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7C3BE652
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609791; cv=none; b=Wc2Mav4AhjAFGvNwfWCsfD9G7zVcjdGpVPqiSOSGg3ZqWLFePq7M5FeqIC95YaKF3xIbv8RnlGZNdhKC2v8uKC6RyiHyy+sLL0Yav74dRi/3t3IbouDmk58BuXHsalbm8DMUd/aCgranD6bVdQ9ZVTqOx297OwYC1/stCfDmA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609791; c=relaxed/simple;
	bh=QV/D+X9L6iHtWxf2FTb2FsPSMVe+HAIVh5ovcaU9Yq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Shizdic97SghZQqgiAFNhkqmE9r6iGJcuHCLJxhKtZUSOlLQHBHvbu/NhA8TX6n+prvTZnQ0wBbk1py4lE1s8WLYYjvZm6lsBHur2ftBPakkz9jo1T0io3ERpSxn0+ULch0JZRhhrx9hhXXAar+BLr98y0JvRaQeAgqdxlZXoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=CgqkfNSE; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CgqkfNSE"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2E7A2240101
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 20:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785609782;
	bh=RGGhD71B+UtcIgYaLVJcbUJD2ZD+NnVvBK4/H22TbeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=CgqkfNSETg/qQ6f3/j38HASmAG9mWFBN/st+xcliEoxWaLOdkR+SjM3xuDnWDKEBf
	 O3+j3W0rsBkL6W0i7W6Xa714Nob4jlzfjdEW+Z5YRyhJw2PnAQJ/MOWiLSbwX+rv3h
	 Jt7KHirb/rovR9lwya62yOQ5EA4NqUSYbpo9/7UFWzz/aP4dj+00GDA1OL+2g4d9IU
	 eH5H14Ie+SzcqGyxL2HOSpplA0JqYs6nl9NrL360pVrzxWdAKM1Vb747ZnSNRM2d/8
	 z3UmNlUOLTDpj9bOFauAb80X/EK5YHf0pvHfVvLwSGjzHCAvn1Sm8Z8IM2r+hL2GvK
	 x/mdvoC45o9zg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hCBdc2VrQz9rxB;
	Sat,  1 Aug 2026 20:43:00 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 01 Aug 2026 18:43:01 +0000
Subject: [PATCH v2 2/5] rtc: s35390a: Add missing newline to dev_err
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-rtc_s35390a_int1-v2-2-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
In-Reply-To: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=QV/D+X9L6iHtWxf2FTb2FsPSMVe+HAIVh5ovcaU9Yq0=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqbj4wpWGU7YlFLQpD3mpVlkJwXuhTfRyDWkAPZ
 7gBJQVO1tOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCam4+MBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LRXQ/+NeqiE91eztegFpxmBn4+GqmSP4ehMRk
 b/nYl+Mlq2bmePwtF296I/vnLidBW+JzjR9L1F+mIeSB39IxxH8qYYj69K8kKXUXmfG/PTOhiAw
 a9ZLnWCta+qG2nWlZwL0YbXRjWMJ/VTzG3YbQVnW0j7uZTlZrWJbO9KbIcX6FxHQwefK0LjsKhb
 VvsRhPJOjRQAb8yN8vQ8brRRfB1/eD6YXbx7QFcSOWRbVgODV9zgFF+GqsfQbPKgidGs4Qgpuf8
 1uAJZU6IH2GMkL9OrIcZXIALCnnJ3gJX9wUcDXaQfTs+TFDxUyfXgcIvVEufDHXKJL3XbQS4yiE
 2rUZRVNvWhkwn/FerqmAGVE1bOqFkW/boGp3vEmWUfyzH0Ab19yIqywYi/6mIbX4MSWdpjsetHn
 HQyZgY+4FqAD0vgUwWYyp0IW0J+6y6pU1fxvEv0CLMe8UqsWDb/dy+BFTfTUu4mS9lPSqwjTy8I
 wBBlGELqaJPRZRy47tFwgMJqoBxDNTZ03pgXnT0j7DsgT2zVLa6ydazWGPhgDNcPXmXdUhu5J8Y
 ldxntIrE+HP/6pY1+K8iRa2Qg3y9I3ZhTh4T3mmeISi+MqMurHf19rlptGvIJhH61wjuNunnTb5
 7sol/sExBPxNJRMm8xz2O8MlCYCbfq8n10l0PW8amOXS5v0U7IV8=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index b72eef4fb099..4cfe7034c516 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -494,7 +494,7 @@ static int s35390a_probe(struct i2c_client *client)
 		buf = 0;
 		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
 		if (err < 0) {
-			dev_err(dev, "error disabling alarm");
+			dev_err(dev, "error disabling alarm\n");
 			return err;
 		}
 	} else {

-- 
2.54.0

