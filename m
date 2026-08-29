Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B13A83A9
	for <linux-rtc@vger.kernel.org>; Sat, 29 Aug 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013387; cv=none; b=Eqqt9SNT0Bfs+JwS+IYyAgsGAvJfVybxCNzy3rpn83xj9MrSSacO8r2BHnYXRz07vOyryqRh2D5NmdE2I+7JPi5X4/s9Fla0guLfVSYM+FiOfe0geZiJNG0dP55MYBryi+nq6AKVQaAb8hX5ZBhgs03/Iq+cMPdtxWI+hu7Pwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013387; c=relaxed/simple;
	bh=tDaTHFOwyiivUFEBu8/xnNHDerIoAfTl61mduREGOAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aUr7iQL031KGZQWZbZfJxrPi5BFilTc0hc355fqwq4fuA3PMlXW4Cq4NEUTggsI0yvvwJsRYVgTwSCboBIKVp1u9V33cRlLZVG63ncWtGwYwRehm54e9tqcXiEb2QhthoiA2bOhXVBjANT+NsvdXynS8VvHDxZNnAnQw13yD1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=I781UzDX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="I781UzDX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BBF1E240104
	for <linux-rtc@vger.kernel.org>; Sat, 29 Aug 2026 16:22:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788013376;
	bh=FD9e+8r2u+AtH5qzR/nhuSAU22YsHMn0VhTVAWsOCu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=I781UzDXvlJGP8xvjlBuKSAZP8i7J0iESsrFM8FuSWcRu7V1R3hSEce8dwYvP6gFO
	 g1nquYYF5B9/nygwvwgWHMHpSXBHwEBgyCaAevkr4YblgDWjxLj3vVVocTUy0nc1nd
	 GNbFM89CEU5b8DpZLTanpPrINfPJlCfhzcFHQNW8j38lVvhjEG9mlDf95u7Kr1O170
	 oAVdb8oxFmMrW4nhsedSsdN9THQOOdpzb8a8Tq9J3EjLhp4+bd+zbNgg84YPPpqosq
	 mGH1WRGrBKFwW5j7uIxmJekqi++bMcggsFKr1U7CPaVwnfSW/FUbvE/59hsUN5xI/A
	 NTViVVUfoCNAg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hXHXZ4cX6z6tsb;
	Sat, 29 Aug 2026 16:22:54 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v7 0/6] rtc: s35390a: Allow use of output pin for interrupt
 signal 1 for wakealarm
Date: Sat, 29 Aug 2026 14:22:55 +0000
Message-Id: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQTWrDMBAF4KsYrasgaSzFyqr3KCXoZ9SoEDuVF
 NMSfPcqTqGucZcP3nwzzI1kTBEzOTQ3knCMOQ59DfunhriT6d+QRl8zEUwopoDRVNwxgwTNzDH
 2hVMplXMWWOchkDp2SRji50y+vD5yvtp3dOXu/DQSflzrrvKoEWsyUjecz7EcmnG/E+Q+eYq5D
 Olrvm3kc/H/M0ZOGeVWCNDIlUXxfBlywWHnccZG8Qt0jG8AogKBM6e18dwrtwZgCcgNACqAHah
 grAEUcg20C4BvAW0FgAMA0w6UDGtALgCx9QNZAYm2xdBJp4xeA2oJtBuAqoAPWkmlEVr+54nTN
 H0DQJOvES8CAAA=
X-Change-ID: 20260630-rtc_s35390a_int1-556ccb308d3f
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4990;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=tDaTHFOwyiivUFEBu8/xnNHDerIoAfTl61mduREGOAc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqkus9x7ynOFIRIDIt+QFONbwahiv7RxA2T8f1K
 Q88wTlAhw2JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapLrPRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Kh2hAAhgIP+G2vBBTUIr2HdOoIstIogP0wVNJ
 +mJGjPjg9p5xS2qdL4a/vKBoyBhXhB2yTsgTHPCHUfpAP6ksfZV3Ek1Sikwcna9xuLiMwBB2T9K
 LpYnIpopqcxt7V+ONJpoDwvmEYDdayGoPjbKCf4KfNQZyZL7nxxmWvg16X85Xgk5f+ZTuni/5mK
 TDOdQR01npt4ZJkupAQwd2MjO43Yl9JCATq77MrXhpHHwz8HooEjN3t1fnCgWao73v2mrzHeMuh
 3wYVwhMSJgUY+rNBycd0Yu3yxSCKnKT4pTGsbgbmU/0dfp+WCuEQeYOBr9ohT+OhYGrXcRQLKou
 aYq/UajPU/n+dBvRV/uvch5YM2BXZeS0aFIrmP/7opSdSNN0JZBEqQpJgDbcI//PYp+qsxl4GHz
 ExEs8a4lSRv4JpPT8AadkqfNrWJFL3f1ISSpzj90T01mlJanMFrp4rcUyFaPF/lMpIc5pcLX7Jx
 xLSxedTnWQtwzm/vLkYv0RGYA9kSypd/i6cjAFNP7Ppq9e3eQqsn9Zmn2FkmQUmumStv8US4QY1
 3B8rHSjvE51n2oMFoglrFrliM4K3+HSbb3sc4yfxNB9WRMnlH5RywCr49kBq5imr+hW6QZ82Udd
 aLYcnViogKStUVlMKtcXxyKpOpkHyah5hAFngRi+MpsQ399kg8Zs=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add pinctrl to allow the use of output pin for interrupt signal 1
for wakealarm. This is needed for wakealarms to work on Synology NAS
devices.

I could only partially test the pinctrl patch. My testing system runs
ACPI, which makes it impossible for me to configure pinctrl there. I did
however verify that with missing pinctrl configuration in the devicetree,
the register were correctly set. So there should be no regressions.
Every other function than ignore, disable and wakeup should also be
considered untested.

Also If I am not mistaken, wake alarms on these systems are currently broken:
(not tested, judged by looking at the devicetrees).

- arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
- arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
- arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
- arch/arm/boot/dts/marvell/kirkwood-ds110jv10.dts
- arch/arm/boot/dts/marvell/kirkwood-ds111.dts
- arch/arm/boot/dts/marvell/kirkwood-ds112.dts
- arch/arm/boot/dts/marvell/kirkwood-ds210.dts
- arch/arm/boot/dts/marvell/kirkwood-ds212.dts
- arch/arm/boot/dts/marvell/kirkwood-ds212j.dts
- arch/arm/boot/dts/marvell/kirkwood-ds411.dts
- arch/arm/boot/dts/marvell/kirkwood-ds411j.dts
- arch/arm/boot/dts/marvell/kirkwood-ds411slim.dts
- arch/arm/boot/dts/marvell/kirkwood-rs212.dts
- arch/arm/boot/dts/marvell/kirkwood-rs411.dts

If thats the case it can be fixed by using this patch series and adding
the example in the devicetree to the s35390a devicetree.

If somebody still runs one of these systems, please test.

Thanks
- Markus Probst

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v7:
- fix issues reported by Sashiko
  - check return value of `s35390a_read_status` for errors
  - select PINCTRL instead of depend to avoid silently dropping the
    driver on platforms without PINCTRL
- Link to v6: https://patch.msgid.link/20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de

Changes in v6:
- instead of forcing 24-hour mode, check on rtc access
- Link to v5: https://patch.msgid.link/20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de

Changes in v5:
- fix issues reported by Sashiko
  - fix time corruption on setting 24-hour mode
  - fix setting 24-hour even if uninitialized
- Link to v4: https://patch.msgid.link/20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de

Changes in v4:
- fix issues reported by Sashiko
  - require "pins" property in dt
  - remove maintainers entry for include/dt-bindings/rtc (which only
    existed in previous iterations)
  - fix multiple reads to status1, which clears interrupt flags
  - fix not waiting for Power-On Circuit check
  - fix missing pinctrl dt callbacks
- enforce minimum length of "pins" property in dt
- fix pmin2 on int2 affecting int1
- force use of 24-hour mode
- Link to v3: https://patch.msgid.link/20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de

Changes in v3:
- fix issues reported by Sashiko
  - fix use of uninitialized time data
  - remove dependence on `CONFIG_OF`
  - add missing `pinctrl_enable` call
  - fix wrong index used in `s35390a_pinconf_set`
  - fix interrupt not cleared
  - fix `device_set_wakeup_capable` called to late in probe
  - fix mode caching even on failure
  - fix failure on synology quirk mode update ignored
- only set irq in alarm_irq_enable callback
- fix alarm time not set if set_alarm is called with alarm disabled
- use pinmux instead of pinconf
- move patternProperties below properties in dt
- remove dt-bindings header
- add '#clock-cells' dt property
- merge 32768khz and user frequency mode into "clock"
- remove alarm mode
- refer to mode now as function in the code, to match phrasing in pinmux
- resolve checkpatches --strict warnings
- remove mode_init bool and instead set initial function to -1
- remove err_read probe variable and reuse err
- rebase onto v6.2-rc6
- Link to v2: https://patch.msgid.link/20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de

Changes in v2:
- remove sii,wakealarm-output-pin property
- add pinctrl
- add fix to allow disabling of wake alarms
- add synology quirk
- Link to v1: https://patch.msgid.link/20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de

---
Markus Probst (6):
      dt-bindings: rtc: Add pinctrl for S35390A
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access
      rtc: s35390a: Add pinctrl
      rtc: s35390a: Add synology quirk

 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 111 +++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 drivers/rtc/Kconfig                                |   2 +
 drivers/rtc/rtc-s35390a.c                          | 475 ++++++++++++++++-----
 4 files changed, 493 insertions(+), 98 deletions(-)
---
base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
change-id: 20260630-rtc_s35390a_int1-556ccb308d3f

