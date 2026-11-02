Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624847;
	b=Q0zjLcATLJySZyZi1J+aiJ92UC+/EiRv/IudGPinjZgd4vwg+pXhPdqURVvEdf9+a5RL
	 3bUwOwAZxj6EzXJTuQWHCuA40sR1VaQCHy5FdVmYx9/2T7eZCUsGMc86DG7eZcLXweB7K
	 Q5rvmEC6ClkGSrO530OJ3FfVs871WKvXoIGnjMoyEN0iObEa0n+jQKuv12jjKKI2SqJbQ
	 WhR//Sj7ByOMnaeiCYsdETXz9jE9vc4fUbyFNnCZRh868lqyjgpuPyutmxXFBBNiozcBF
	 ln35aaVztawW/CHE9+bEE2N9t7lh7gpyUJwPRmKUgb2gglNXwh9IfY4QJnEThvU3Tcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624847;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=M9DOp1qSa3Ibk87SzKGrTsovuwywdiXspR7koE+lIIk=;
	b=cF2DgM87eF9yB6CNGU/k0q4wS6DbtcDWZF3bzHQYuykLkIfaeREkdouRqxkYpECf+o6J
	 QHOlItb7AuUpGxcDJNeoCXEk8fMf4gCzJGOt3Dc+KsbeiKjlwxu9VyKaypdbjv/D6d76H
	 3SWFRCgEfD8MZ3mh6/j3xFJiKVdzMSXHusQtdpr1QNb+wH6caDV4dfMEL7x7JfltbOl76
	 lVs2GyWjDWz2oivsB3dj1RWGaqtTXUTvUroqjmuEF18sGYGBf/GxtIKwJsZqJrBexgNxw
	 EuEXddrD8DY0TN0nz6fT7B5+IytNRkHAtczdehG34CcjI1INOUCXJw6rqUN5tlw2lqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zfBb4wf6;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DB606A333;
	Mon,  2 Nov 2026 13:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82DB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zfBb4wf6
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4FDEDC4FECD;
	Mon,  2 Nov 2026 13:08:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2BB9960750;
	Mon,  2 Nov 2026 13:07:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD30A10328C5E;
	Mon,  2 Nov 2026 14:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793624838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=M9DOp1qSa3Ibk87SzKGrTsovuwywdiXspR7koE+lIIk=;
	b=zfBb4wf6CXGlHDQhCsB/HC8xM0uHQ2unP8ECRuwMLZ9SnNNl3dlojIN9KSv1DuLYY3BLe+
	vAnb/r3C88tAM/eAixYQM6Fyl4QY5hj6hpn/B7IfgwNdcGt7jLFsKXDCkpYQYALfBEinMe
	Ga39+iW87hx2bZY9qERfxxT/YMb5fg8tWCLXOR5m3T9AxFYucW0YDkXohsg8CJwXzWvezn
	zcqwNTd0dvY+MlkJWX0EZ5fcWTAeoFJLAnwasnDUEKvw745f+yCQLx4pK4JS4Hs78+fprQ
	1+lAAzmA/wbLY05/6+9YzRf7H1kS4bpUwMnnGKOFDPaP3vc7aGBj1jM50k7kjA==
From: Herve Codina <herve.codina@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/3] rtc: pcf2127: Add support for output clock and disable the pcf2131 100th counter
Date: Mon,  2 Nov 2026 14:07:08 +0100
Message-ID: <20261102130712.25104-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

PCF2127, PCF2129, PCA2129 and PCF2131 provide a configurable output
clock. The first two patches in this series add support for this output
clock.

The third patch of the series disables the 100th counter available in
the PCF2131. This counter is enabled by default in the hardware but
100th seconds are not used by the RTC subsystem. Fully disabling it
allows to save energy when the RTC is powered by its battery without
any functional changes.

Best regards,
Hervé

Herve Codina (3):
  dt-bindings: rtc: pcf2127: Add support for clkout clock
  rtc: pcf2127: Add support for the clkout clock
  rtc: pcf2127: Disable the 100th counter for PCF2131

 .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   6 +
 drivers/rtc/rtc-pcf2127.c                     | 201 ++++++++++++++++++
 2 files changed, 207 insertions(+)

-- 
2.56.0

