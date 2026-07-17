Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845823F9A08
	for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301913; cv=none; b=vFtVPSHy3T0L7jvv4nXnTbIr+WPWfPaitmb0xdA92jaeJRwphj0wHosq7M3k/vGcDV9h19iKG+YxYEyEaaOJsIgRP/XdJKt8GzPpCx8qQ3eTzkOG/6kAU7N9JyN0cJfD6jSYob2+X5/yfVTASjXoYUP56Rg6DkdwAUpzbdPNpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301913; c=relaxed/simple;
	bh=77KlE3q83JWLmFeSQ4+fhX01mwhYxjPLqk/uMP3kvC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WhrkGD/ouzETMQDWeHkom+f6LyLbH3On7O8orZqpYvmVy1tfKPA/7atsp19zvDJxpinUtPpwY6kIqK9P3U569EujcHT9hMEGXpCelfzIPMBx71QG3z0aOkwfB3rVUXpjtn/UQfSDAeLB26P/bTMZ3HAFVvK33cUOGqnIi5qdoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YvtElCQb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YvtElCQb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47362928f65so7187600f8f.2
        for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784301907; x=1784906707; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=alzKa1fHBXJDMeEN+D5I/NY22/iphGwMNqGxpCcq0iI=;
        b=YvtElCQbpJSd5jNanrXRKpbGfCriZuNyHtp+HxliT2g1/q2LPm3Emj57xua2oqY0lM
         nbRQ8god7Dt9vojSvubsyjeonZSJiuK+Pe54dAETzOhoRmW/reLDkoNUMa4XHU3LvUIs
         oU2SLYpNQh80LntzaSaAUo3eFMBncEkcB3R4cLoF567zhBrhBGGYxGrQFISGLmE9134/
         bFhRiGPJXwJltO2OI/rhsa9MA8i10fbH++mdXfaqlE1FNk/rBcOuTn3LFMrrNHjPS392
         Oq4nWdgs54X66Z44MqA22f5k5itJqW4QZxyu0OkBDeY1HKqW3OdLb4Gap7kkI48VSshF
         sS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301907; x=1784906707;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=alzKa1fHBXJDMeEN+D5I/NY22/iphGwMNqGxpCcq0iI=;
        b=iUbVemK9HZaZWAF3R7LA59EBcMVphhXEKj/Tzaf3e/G+9I6S5C0CEim7FnKFcZk9dT
         UWg9xtF46VB1dOMII3a/vPyFBbYSt5WFHCjoVihSUe2gEuhTbdQt6hCct733Hhikv/FU
         iGB0lTg8VUdxsC1ZWIDS0/BOJW8jfZNQbJtjihrzXdIjeCghynPcNd2ro/cqkLcW2I6q
         1cOiMRM0+sJMplzIbQmopNhhQ8TLnKVoRiirLj29zLn1bDpG1kKwjQn0u7+0hKtGXyjJ
         yvk48TAvjL4Se+8fVuXZsz/8qB78VBIbkoarpvJOOmE8rA674uiuR+pfoRSoK3uCUom0
         BOTA==
X-Gm-Message-State: AOJu0YyX+AGQEBQ5q+TNovnsZCOBUFBeMt1hW/8aRwB4wKv+qAWcDjil
	Abl5hxBeO2hFAPMcDwpmDMA0cHgEmF46Mueei+Iarn5xAi42dFWzBZ+h9uydD6EtF/0=
X-Gm-Gg: AfdE7clsevu3o98aBMF0sI6IdZ+X8it5TyI3RnJI5sb2uKQdj8G7qNx6uI5ajQnlPsw
	NEqCbGnehdzlAKf7oPRL/3GUNPp8QYfBcksCDCtr+rhnkAGWu/XOyIuetLvB0GxLmMH0Pd9RPgF
	O/Ia/qlQISTLEEDSQ2P7X+n2dIxczOFPfnhQMGm6mUmbH+1jEsHC2pnLtlrbaZw6SJmU4NvQjc0
	7Xze6ZOTvpv8MvsfkairQMzhWCuaI9rY6Wjfc+1MfLJG4YEG0RXmKXF6LnRPOonnxDWbucdOuqZ
	f6hSfnUV6ZCWBr5W1gUm6TW8z8e0BVEotQy26kT6JU86AiudsL0yR4IQPwrXfTl6sB3sijdecCj
	LSFmTRRgjAyNjQyesK1j5ynqS28RW9tMa0Q8IJeFJpf0a2UAK/kVIIKl3+iA5+F/v3WxojixrHx
	LrU+imN5rtWNw=
X-Received: by 2002:a05:600c:6d82:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-4954a405ea3mr27250835e9.19.1784301906790;
        Fri, 17 Jul 2026 08:25:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8e22:8a15:f33f:dc60])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495499a5847sm40546205e9.2.2026.07.17.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:25:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v5 0/4] clk: sun6i-rtc: Add support for Allwinner A733 SoC
Date: Fri, 17 Jul 2026 17:24:50 +0200
Message-Id: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJJWmoC/23O0Q6CIBTG8VdpXEeDcxCsq96jdSFyTLbSBo7ln
 O8eeqNrXX5n/P5jYpGCp8guh4kFSj76vsujOB5Y3Vbdg7h3eTMQUEgAzSuDyMNQ87qQ2rhGKtL
 E8vN3oMZ/1tTtnnfr49CHcS0nWK5LRAsN5y2SgAturAEpwZSqKa+2Gp/eBjrV/YstnYSbNQJ2F
 rMlC0Up0ChH+o9Ve7v7fFLZNojCQOksOvyx8zx/AdHYTdkbAQAA
X-Change-ID: 20251226-a733-rtc-c5167df14e6e
To: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=77KlE3q83JWLmFeSQ4+fhX01mwhYxjPLqk/uMP3kvC8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqWklL2FEOkdoyGqNmeA3invLT2BibU6BrGaDsj
 IJbFrhMdIqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCalpJSwAKCRDm/A8cN/La
 hd1TEACiHeYWv/HEYx9MfigJ7YxKzSgXcjza05w9VF5WDm5yJWZBzoekG9qfib/WNPfCkF9m41I
 S8ZqqDE+wIwhlCjO4rXzx8EAhublnjsUtoL6Sg0YlaQfVdevS88y+5/3X3pwyzihGKhIR0pPeVL
 dcwaYPBAfoiCf3DU/JQqFkvRHVeyKJoYDktNMX80zTHuSHidRjfHyR4RWDLVuJIq+u3UHH6vbKJ
 Qur0yvWaBgn9+UA//joL6JlGA0fahfTy8e6BjyRN+QPKcw9j3/cv7wzIqu5u35li6F19UMVrw5h
 ar1eVDzYP+KFepeuO7HrltoGL6/eN8zOC6rpmzI7w3QNe6IjLR8kCJOTeypvRYSLnzViiGvzjHu
 bkubJ8iwbVR9YeKj2WDC+kVNscRPt5mzXBUip55JjackPQJWakxWHQxgssHiVRSBylNcafSHAj4
 WkHYM/UVxZdKVsL6Oyfy06i48D6f07slbRRjm6oS5dvXSRxY3HAYqhcFxrEi2a+q4PcsHEal3r9
 8uq9bWnSabXZPf+kKINrDvZRveEzK4Hlk0X9mXsV5sCyU0X9nRvaJfpkPFaYb8U7SjPUGo0Myyn
 EZzCq0k0xb92LhYe+1sujFf4r1bbK77X8vVGNK1X+VTVTLftrHD+Y+Ux+M/XUJ25XNZWvaZZQ25
 CvP50Dn3wQCho5Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add support for the Allwinner A733 RTC and its internal Clock Control
Unit (CCU). Reuse the rtc-sun6i rtc driver while introducing a new
SoC-specific RTC CCU driver to handle the hardware's evolved clock
structure.

The A733 implementation supports hardware detection of three external
crystal frequencies (19.2MHz, 24MHz and 26MHz), which is represented in
the driver via read-only divider operations. Implement logic to derive a
normalized 32kHz reference from these DCXO sources using fixed
pre-dividers. Additionally, provide several new DCXO gate clocks for
peripherals, including SerDes, HDMI, and UFS.

This was tested on a Raxda Cubie A7A.

Changes in v5:
- Droped already applied changes
- Fix determine rate mux helper calculation
- Changed clock split commit description
- Added a macro for the clock number without gates
- Link to v4: https://patch.msgid.link/20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com

Changes in v4:
- Remove unneeded export of mux prediv helpers
- Link to v3: https://patch.msgid.link/20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com

Changes in v3:
- Disallow clock-output-names DT property for h616/r329 chips
- Fix ccu probe helper to properly unregister clocks on error
- Implement .determine_rate for ccu divider RO ops
- Drop unused DCXO_CTRL_REG_EN define
- Link to v2: https://patch.msgid.link/20260629-a733-rtc-v2-0-7b72112784f8@baylibre.com

Changes in v2:
* Changed DT bindings as suggested. Those have changed significantly
  since v1 so I did not pick up Rob's review trailer
* Support added in the existing RTC CCU driver rather than a separate driver
* Added DT parsing clean up of the existing driver
* Xtal detection exposed by RO divider rather than a MUX.
* Dropped conversion to aux device for now. This is not strictly related
  the a733 support and will submitted again later on.
* Link to v1: https://lore.kernel.org/r/20260121-a733-rtc-v1-0-d359437f23a7@pigmoral.tech

---
Jerome Brunet (4):
      clk: sunxi-ng: mux: fix determine helper rate propagation
      clk: sunxi-ng: div: add read-only operation support
      clk: sunxi-ng: sun6i-rtc: split main oscillator div and gate.
      clk: sunxi-ng: sun6i-rtc: add a733 support

 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 89 ++++++++++++++++++++++++++++++++----
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  3 +-
 drivers/clk/sunxi-ng/ccu_div.c       | 30 +++++++++++-
 drivers/clk/sunxi-ng/ccu_div.h       |  1 +
 drivers/clk/sunxi-ng/ccu_mux.c       | 58 ++++++++++++-----------
 drivers/clk/sunxi-ng/ccu_mux.h       |  4 ++
 6 files changed, 144 insertions(+), 41 deletions(-)
---
base-commit: c52b5090bf1e3b88745f8a81f264f34100ecde42
change-id: 20251226-a733-rtc-c5167df14e6e

Best regards,
--  
Jerome

