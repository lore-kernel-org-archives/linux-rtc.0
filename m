Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3224AB3B6
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574451; cv=none; b=Nfr7BWokszOfWzNS56QXANnF1umfVmhlwHBdPjIT/nm8icAHZiqaiyHbtQz2EP93Sf+lJ8xszWFgB0vGjeQivfqZ+3JOm567qXw8dEy3sFfNbeG0z7oaHoezIBpcepBSA0qxfhANBWbAbrF4RNUH3rqhcM2PvobtRtg99hsCuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574451; c=relaxed/simple;
	bh=njz0LoIjBX+iLSp+6dhCTZ9IUn801irSwkTWARXUa2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0+BoULzokpnMuC3htN6T/aeIyFGpWFrvxlbu3kJp3ION1+BR1JsaaEX0SI/uB7bwCdy6e+mk4wz4tsS5tFf3UMaRdHeEMlfyfUevoikzqolO55LB6JdeMGQJe0zvjQzV0/x19c621yCx8yklxJ/zRTL9B8ygWzzQUKfFqkUBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=IWVIVCT/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IWVIVCT/"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0272B240109
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 18:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789574439;
	bh=Brzq1+lLBNFr+bk2j3Rb+JV/YKNAySvoirb0/4mGr2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=IWVIVCT/+1wEwmyqsAoakWORV68PR7NRnUaAZrSaEadK7vU2kRdraOW2f+dgHUsWR
	 Tlib8ojXXaZLkSwZrLqIgTVxNZx28kX1kjKrLgd989NIiERUlacZlRY0ikuO/v1cXQ
	 7f9x4ocJvPg3bLTV4ZAX5RzHoh5A+cmI4X56GNroUlJgVG/r5Mn4gfJAjxucShoJu/
	 W7VpYyIbKMLeHKdrOyvs/PKr7C2GGrGvMDQkC3oJ3hABSgqjI8gGKBGfVrU6W2DBBx
	 U77fKOKylumN82LYBXXPgphC55N0/9QH9ktaQkg+6DJ2wl/u4kCVzEw1YxjxTB6mQY
	 4LvGbSTEQBNww==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hlNs053Ydz9rxG;
	Wed, 16 Sep 2026 18:00:36 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 16 Sep 2026 16:00:38 +0000
Subject: [PATCH v9 2/6] rtc: s35390a: Add missing newline to dev_err
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-rtc_s35390a_int1-v9-2-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
In-Reply-To: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=njz0LoIjBX+iLSp+6dhCTZ9IUn801irSwkTWARXUa2I=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqqr0fsHfMQ5xhmA6UlFvDLVBV0NCrCpGAHC1X1
 XYwSpNUL4yJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaqq9HxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IJhA//Rr531OEKae/8VjFnfeqfbMD4VUagf/K
 RA3sn5m++OJ7H5gF2xTyRC77AvOxeLQG3v7TRWKSNofCUb9Q/e5sJfYVRMuWyfWUon8NWLTRycB
 Pn39Vvd7Rbh+ar31qxGKELB3KklUMFG5NWpTFPNrzjE+bd79tHFrSBO8Pa2c/ArhTFbbcWmdCRu
 YE7OEGX5RM8YWTlFKnZZIajyajVR7CpDo6PtIzjC450ukL3SeyvZOB//SYAdKwBd7boId8ohMH8
 KeJrdZPp8hyGkHULXVm4jvRNhuhIab7u7WhgJsfB8e0vyXHNPbTcC8h7q+XlFKEAWPpA9Dge1TX
 URHUNqXGm82W6C5iIBnnbUBF3eKNQMwm+NhyzzkjS0dphf0+TCVQvqU33qcGd2C1LLGgxTQPsgN
 /57h4jT2IIUKPO2hgrX8Dk2ttCoeE7r30WbUN0Dfn2kb5ZKnxdtMtT7hqaSHRdd2YtV4NWeiKhs
 BylP/Yf1whP3pcI3D7utjEmqc31nIEkzFEuA7HTNqp8zaRsyDb7A0sOoZVbfJ4TTlTLw6beSzEw
 PrrcRJyKZxkRAEnigclLyL87FmPKnqeS1zz6OfeZBmvKzXryrOvGxvEA9BpBC7zjBlqXrdhokDt
 viGHuasH1tcuE+y9MfIWDHGaPCSa6yxYG8iYINKYLXhLbfGxf9j8=
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
2.55.0

