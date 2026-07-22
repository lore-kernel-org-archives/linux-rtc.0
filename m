Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2D368D59
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731718; cv=none; b=jTE6IEvoiQUwhIpVoF7Xs5lsjGDzUs3BZxdAg+1c5h4SqGPE12W/BXb+L4RH5tAJsN/wLBE/OqdckICHLi234su2UO09B/XyZ/qfobhibCiNeXaK2E936fR66tGJThwNGXU5xtfBlLBNekwffAzk0n0lgvM2W3daHkV/K0Ldo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731718; c=relaxed/simple;
	bh=8daDhhVEFGopKhGWwC1vGtYJ397WHh0sBLBEojCbVe4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pkjNwmrW9g1DkzT0EaaIhFHcaS05aYyhac2l9zEL9XWzh7XQa0EEfWoh0zPs7wzrNpqKU4LzjhuwbZ3QE8MyXcEd42QduEm93/Hrbz5aNsqRcQcRJBLYSII/iUNI0w90KlkfTHeKEVF12Y8bPPirLVDvOk9pW2Crq/tZT2OXseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=j1vortqe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="j1vortqe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so8626376f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784731712; x=1785336512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RdG29z3muBgbn1ti43jq5C44NsXVWFLsxC+XrhFf+Wk=;
        b=j1vortqeonE1HFuAbAxP7XdiEd16viPSh3yfik3ZGY2YP20Yeyp8BZwuFSF7D8QLT6
         SKw2FtRH2kFMYa/A3tUJyWr1HiUnuXux5aP3WjVtgelHg/IItXAkfAnRhb/TlmQd0h+N
         R4hZ1ZmsqEEnTvK2w+CvtauHZZciuF9ox5hFKEYXyC6/X8Z+ILIFqBgxATenSrJSkpRY
         RcrB2n0tAQftaj2nk9fKsHheAF68r+im1IyTmbgR8Tkji4ZiPwJHBgnTRLA1nUHndkac
         BUIub3NryvDqEgC2DUu2b5JHLqaJcGT6hJGLLesdgihzGqCJps2LZgQAU2yMJb6BwNHZ
         ahiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731712; x=1785336512;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdG29z3muBgbn1ti43jq5C44NsXVWFLsxC+XrhFf+Wk=;
        b=IRAKaUZbtOSMC8auj4ex78gjCNJg86cT8b5t2KLDMxcqa3YgTTRBUgFXG3Ss1vxUzT
         YS6vHJ25ZWGvH/onQaGyAtF+x/UgFvwYq0/HXFTXT9ZlX3Zx7WSTCk+seB860297tB9X
         lOGbEvLVptiJRwxmYQnJrs0vdYMbtuT0zuhzbHZg7UIUFO6TFc/NsnwrZqNKWIAyf/gT
         Ve7Sm8iKiPIm9U7bwoRtRAUzI23Ow1kJntPpi6lw6iZERg5N+sQrahGznypV7At1YIQV
         ZbTsojSRuxy2IC96mUhUFs/ArXix+6g2suJ4sxmL+KSu1wxIoxkiyxAaZxtqYzWnsxTe
         sGLg==
X-Gm-Message-State: AOJu0YwBePOw1byf6gqNw8JZmcW8PmFRSXwK8A56Hv+VB5ZVPH0lQ49a
	496a3cE5X0bGS0TAVzgHNF/4g5KfQ8ip4S7O+dx4FdBmjfMXFRDAprvoVWt1h3TCJFU=
X-Gm-Gg: AR+sD12yhwqD3h5/BF7EanfXEGXIUBq1tRCkgagFDlEqJh73c6Qn7/lWKulD5DvXO8W
	+EPfOcjYQL4zmCtRD+AvDAwJ0iG+SOsEDJyYbGCyrncZkoHViOMxzdkGwD2be2Lr8aU28All12w
	AEU/zzUCKJwhxYDzSdK0zMTHmu24caIdtuVs5/jcpFCmKu7v9YkJkQt+Is4889Te3U21JZgDHK+
	zvgWwjNCrCVspneWEGriV1ptWjJP00QH0Bmhdm2aoVhH0Izoomn5rpOsERL6FqIr5eOADKhGpUV
	3n8HqBlL2Q/d7gcw9JA8jjbn+jgffy++XC8usG4rxIsbWYLnAzvOrzN54yGSlO1Uiu6xfsFzTh6
	PkChBP9/a+lyJ5EUvJ70BfWly7wn8S5SHd9042XIPrvZSfm0UYuKrMwSbFliHrt7E0Aokjk1fKr
	t4
X-Received: by 2002:a05:6000:2906:b0:47f:81c4:36b4 with SMTP id ffacd0b85a97d-47f81c43db1mr7895912f8f.14.1784731712418;
        Wed, 22 Jul 2026 07:48:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a589:14b5:ba97:3626])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85bb5a46sm6832816f8f.9.2026.07.22.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:48:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v6 0/4] clk: sun6i-rtc: Add support for Allwinner A733 SoC
Date: Wed, 22 Jul 2026 16:48:18 +0200
Message-Id: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLYYGoC/23OwWoDIRDG8VcJnmvQGXVsT32P0sOqYyK02eIGa
 Qj77nFziYQcv8HfH69i4Vp4ER+7q6jcylLmUx/ubSficTodWJbUtwAFVgM4ORGirOcoo9WOUta
 GHYv+/K9yLv/31Nd338eynOd6uZcbbNct4pSD90ekgVSSAoHWQN5k/xmmy08Jlfdx/hVbp+HDk
 oLBYrccwHqFZBK7F9aMdvh8M91mREXgU8CEL6wdrKbB2m7Rk4kR3BQyPdl1XW+XZPMrVwEAAA=
 =
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=8daDhhVEFGopKhGWwC1vGtYJ397WHh0sBLBEojCbVe4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYNg3TTy8vMwTdudIsmQlovyW58N3OJzL7I1v8
 UWryP5lJQ2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamDYNwAKCRDm/A8cN/La
 hU2VEACYKNnHL5ua2TKNm+vwVHekwFmy4DFH/HShATeFS/g0+FECIlK01uaAzEO4LWMa0DW2Jqw
 UEm+AxOJxVV+opJLPuSrovebEixPKq29h+9L1fOQ1CrLVSLmoq8091ygFrKKhjyY5yZOAlqVivi
 0TG9+a9iMQu/s/OdEDioLC/CpLTHDYbnjCgEk8dQ6ubKV1ExVju5Nqz7JF4QFcQqQ95Sdz7PAYl
 upS9GRN6TroZiAPLFh93z2w96PUKx8Sg1UDVJMfdlnNACjAB4eOfcfA8vUOjjPnEcXpXrK7556E
 UjS+CLG8axHbNIDWP6IptyxUr+VrZ7axMeW+yqNLcJK5ypxWtyOyQpp6WOIR5buy2Z5ruAlA7tF
 37DS120CU5se6iBM34hRKBw3NrM/fWOtchJf15PFj1PP7A8lnSg9wSYtUOGNeEC2D8Y30SVSPtm
 8NsrDHgGsBqdpS7ekFna6iOTKzurRY/Gmtrtd1LJbLTllBO30ifFK6F/gYuCq/1wTiz6DIzeniu
 SGRnsZgyhx/P3bAOITldGRkBvUW+C11KyTmttxp5FohH6w9OtzvH5PepQjr4RWXzPBSUussCHz9
 j51ud3urFi7jzMJ0q84ZAixelWd32vpBmUhETZVw1YAFVzQtxjG1mdzh7nuKdZ8ttb0DAwT4U0y
 vRTaJh2l2G38ELw==
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

Changes in v6:
- Add .set_parent callback to the divider RO ops
- Link to v5: https://patch.msgid.link/20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com

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
      clk: sunxi-ng: sun6i-rtc: split main oscillator div and gate
      clk: sunxi-ng: sun6i-rtc: add a733 support

 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 89 ++++++++++++++++++++++++++++++++----
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  3 +-
 drivers/clk/sunxi-ng/ccu_div.c       | 31 ++++++++++++-
 drivers/clk/sunxi-ng/ccu_div.h       |  1 +
 drivers/clk/sunxi-ng/ccu_mux.c       | 59 ++++++++++++------------
 drivers/clk/sunxi-ng/ccu_mux.h       |  4 ++
 6 files changed, 146 insertions(+), 41 deletions(-)
---
base-commit: c52b5090bf1e3b88745f8a81f264f34100ecde42
change-id: 20251226-a733-rtc-c5167df14e6e

Best regards,
--  
Jerome

