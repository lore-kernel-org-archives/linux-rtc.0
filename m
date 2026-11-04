Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775918;
	b=1/BtYB/bhSQWZ/hTGZyGrNUjbHeBN83UEuSmF4xMWLPl38lcq+J7OqXbMOe4GL37EIoh
	 nyJUHY70silh84JM1vovCeemk5dOIMEA7HCpKWwhTsu383Sky9kMxMywaksWOX04ig6JR
	 Ft1bllx90hv3ira4bLvcfDPfuuK3ICfGudMTkYqEW/RGLj7QYu0YtlP9CYK8XQxL1m49v
	 Aqepb6y4B2NyloNPO1EfhWrAAKGOAR2EeK50sPEGU8js8Fpekbmj1euS0vgi3SofA7xI3
	 tJCqIphMZlaFIa6Fh48/G2H4Z959E9Id69HRKUMDuN3dcS7ipQDo/UCTdWOzm0qycYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775918;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cXRTR6Cd1Y2eTy4MIHECYmjQTfa4P4H4thCUYYRgRZ8=;
	b=ptCafkWMWz5W9FNpv8QuxgGFP8fAu8Sf7CnBIjoE8C1i5yjDnT56lzYYKeNU077koP12
	 tJUzfU/QWeJwIOZVd0QovsnBgRrjmRHaSkmzbVjm3KXiFUrsE7heKbqXKRRpMq62hhm3s
	 Uhr1O5YBcS2/Ys1Zc9CicYaM1HxaRHsaGspR+kzqRGRyvJ9z4GIvY3Tu+AR0bOsv4sb9/
	 OwMXRyfzGC3vs2O1v00RfGCwUk0fiSXjXtv8o1Om9RvwrFwC0piKpf0bunz+havvl0aEi
	 CnIvvlkgwQuMxPurYLZh2sBADgHdNl8FeAP0dF1KWyn6jTBgNJYmn3thQQ3E6AtvcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b="srVG/7Np";
	arc=none smtp.remote-ip=95.215.58.51
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99391606A32C
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99391606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=srVG/7Np
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6utNHivWyaA8ZepnyHTTdDHkXVyFNNb5pORoTt6doaQ=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775915; v=1; x=1794380715;
 b=srVG/7Np6E2p6rEBdJz5gHPqqqtAWY2O7kqyCfvCVfrHZNBjk1Cc9YF1MRSwJh6vqA0wDpdV
 5pO9IFdGHeYUFWa0IguYG7wwsNi2JkWMVMKRggF0Em1toJ+BwdcG1sI5PEJ5cDbAjkZIcGmJFRs
 LAV3EiTKJWRpE/eS9DgKlBJnFsvp5nTD5g8JS2uQxBoQyc1gCts/kATARel8Ey7/yDAUyrU4ZoL
 VsmDh7XSVwb6eRtKUaRzlYSLDKveltKUJiq28v4mCSjms92naqv4EtlYlmogkEbxJ5kOIL8lzOJ
 rSEaVaucnyeD7Q1yusyTWjYLhnmCW80BMu6EECrnU4ruA==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0198b4517bc619b5;
	Wed, 04 Nov 2026 07:05:14 +0000
X-Mizu-Trace-ID: 0198b4517bc619b5
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
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
Subject: [PATCH 0/5] Add support for the Microsoft Surface Pro X
Date: Wed,  4 Nov 2026 04:04:31 -0300
Message-ID: <20261104070441.74127-1-val@packett.cool>
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
Content-Transfer-Encoding: 8bit

The Surface Pro X is a 2019-era tablet powered by the Qualcomm SC8180X SoC,
released in three variants (SQ1, Wi-Fi, SQ2).

Patches to support it have been around in a downstream tree at
https://github.com/linux-surface/kernel for a while. Let's upstream it!

I have permission from Maximilian Luz to use his From/S-o-b with modified
(squashed, stripped down and split by model variant) patches:
https://github.com/linux-surface/surface-pro-x/issues/7#issuecomment-6597291831

One aspect that will need some input from people with internal qcom
docs :) is the PCIe setup. There is sort of a multi PHY or multi
controller setup, and for now we've been setting up a single
controller with num-lanes=<2> and it does work, but it's not the
proper way to do it..

Thanks,
~val

Maximilian Luz (3):
  arm64: dts: qcom: sc8180x: Add Microsoft Surface Pro X
  rtc: Add basic support for RTC via Surface System Aggregator Module
  platform/surface: aggregator_registry: Add support for Surface Pro X

Val Packett (2):
  dt-bindings: arm: qcom: Document Microsoft Surface Pro X
  firmware: qcom: scm: Allow QSEECOM on the Surface Pro X

 .../devicetree/bindings/arm/qcom.yaml         |   4 +-
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/Makefile             |   3 +
 .../dts/qcom/sc8180x-microsoft-cambria.dts    |  38 +
 .../dts/qcom/sc8180x-microsoft-carina.dts     |  50 +
 .../dts/qcom/sc8180x-microsoft-caspar.dts     |  38 +
 .../qcom/sc8180x-microsoft-surface-pro-x.dtsi | 853 ++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              |   3 +
 .../surface/surface_aggregator_registry.c     |  26 +
 drivers/rtc/Kconfig                           |   9 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-surface.c                     | 129 +++
 12 files changed, 1161 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-cambria.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-caspar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
 create mode 100644 drivers/rtc/rtc-surface.c

-- 
2.56.0
