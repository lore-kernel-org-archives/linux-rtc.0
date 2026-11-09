Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263974;
	b=BNoPgGbBFvRxbGPxcJ87pocOlUkj2PUUqwnnTRdnMCQNpBUnMBVTpQZROHR7fNR9dciy
	 DuOMyuP0hSP++J1FYGN9kxnUb/rCGOWyD2HCUSY2s751wGJSNrmFm6W69oSQ5PmwabzyZ
	 Cn/zl4W6RzUzcHTqL/XE0XmjNx42pYL1dP9YDHQIWEQ964vQWm7i1AFU3tG8oFmg7+x4W
	 WIiCvBDpUWOkyeOT31++6dMgg7KUakRiINL1pyUE4ACs7uYN4slI87FCydImGMCEmmYt9
	 rMWxGWiRmqTLZ++vZOCtTIk3ARdc2eOBcvPu6yaR+CdvObjdSPziJteExhFZkJJ8GFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=zGCyhR3+wK0MZo3ZLFnO+j4LZwP4oGwjLnEhKkeqIL4=;
	b=PHnv+JW+59dM3381rfqfVDGfnaWFJxqyS+skyhjh5urRsx1Zz3OLB3a0TObsBU0stJLG
	 vSRA0ZcIuMoDstzPlkB3J2kJU7mc6ijPDz2mJ2C84WI3T7MJfdwCbKCRvm0kcFJfDmM/g
	 wW6AFpAKeB0nGZZDgJ0oAHmwbvA47VlfaYHdYEpv7xMpuj1pY1Dh3YMp++fXtbN04HIcW
	 gZThN4oO/YxeaYKE9ieHUYfOG99WpUMN0Y6CJ8VZdsZTPs+h4GQLEBBViSdUtWFmZJWMD
	 Iu+yVsSwu1t1ygaqv9Ohws1t+DGDNnAq0LaIDBFuZgNAOMMPbL4CNmMSEkMqU0N78Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJYMsJq1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5660A3806;
	Mon,  9 Nov 2026 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJYMsJq1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979EB1F008A4;
	Mon,  9 Nov 2026 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263974;
	bh=zGCyhR3+wK0MZo3ZLFnO+j4LZwP4oGwjLnEhKkeqIL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJYMsJq1OZWxcXuKehV+wKRu+YBnQB6Xv+q0/nTp70kGFy+ETBJBEtFWM7bOozoDN
	 7YvGZZMPUX2uwh8UfAYRdFbUOON89DUlJ8kygHFCYpDyHCWH5lPn8soI+G8UaCvvXG
	 VUdYOHuT9sOIaRY0sYwDjCFBDH2cBYkQ8liNaTIxehHALntCwHO3HTx/t77I7Gd4Q8
	 KlBNyyWEZ3AODWtlGCtJcEKL1yCX4AI0OnkFRN4QObgWsM9HEWaf4KUXvg8QfDZXWX
	 bNC+fg15zoCS595AV8gcdDPlGtQEAPezRMR8/Co7/GjDS9RAGa2u+JVmLsezCqa+8u
	 1YO5+PHUgZdug==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 4/5] rtc: gamecube: Use unsigned int for control0
Date: Mon,  9 Nov 2026 23:39:06 +0100
Message-ID: <20261109223902.84918-9-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109223902.84918-6-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; i=blum@kernel.org; h=from:subject; bh=/GlVLFsapPFDtU/j0HQxwlNw+AqRScdienFcTlvCnWE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfvCd5y1noLp10eOlt4SPXXm6LMlNI39HccW7Voi36t sZHOgwlO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiFe8Z/hdplH8ulH1l5PyY YeHy/s1tyf5O37z5P4YUZR0UElaXVmZkmG1xbl9e5R65dNbozfPb7p87Lbq2VmLS6uIT24qE7V4 osQAA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

regmap_read() expects an unsigned int pointer for its output value.
Declare control0 as unsigned int to match the expected type.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-gamecube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 4b45274effdf..ec672bee0134 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -190,7 +190,7 @@ static int gamecube_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned lon
 {
 	struct priv *d = dev_get_drvdata(dev);
 	int value;
-	int control0;
+	unsigned int control0;
 	int ret;
 
 	switch (cmd) {
