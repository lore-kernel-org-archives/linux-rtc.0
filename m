Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47A4C67F3
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782317; cv=none; b=uAsA3voWRNBGKtF1PmKmbuaQA6OiKEmz0+Rs6KUfgfyOdFLlee39RgOCw6hLgnY81unASw/I7+hz+PRakaYrERP4BSgcqbYlfFKSkXc2f4xN2RXZrQPn9Nzws2dfw2YyesY2d/JYWhjedtAbGAaeKYdFL+RksyjoDjNr9VLoerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782317; c=relaxed/simple;
	bh=6bD3PfnqyU0NTP6XvypjfAMTwFrD43+9GKv+BV5TJgU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k4BjJ4JgkOq6S8MIuj3RjMj8d2eDKhRw/LnQEfVmQb/JhLB3ofNItdiF9TZv2bmpUdRXMoAYAgj98iTIv2o8wAyggqHz2xS+bEaSqA3XSRu7k7eQWr+3iwpbwk+Z+24VVIJozS48h0KCbRz6QRCbbtSoNqGYSsVw3S9JZFDiu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=S+zncQ5d; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="S+zncQ5d"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 95F82240104
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 17:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790782306;
	bh=JrKEQOI8K9h0wgTSg2/tv+7ZUAJ+2oioRu0rgh2iemo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=S+zncQ5dckQcXbh2Xl9tev5w20BxBNS8lLzrhG2OjUD2tbaug1qGUJoLatdbjH6bY
	 D1lHlwJFh73dw/Fft8xNHaF276FRQCYXXsZNCIVryP8gqQB0Z+GtTPxCx2PFEpCze7
	 xACYoBz3nz/oG07DeWSEnUhUr2siwB8IRfxiRUs2Ro4j+n+3cB+KhQeN31uvhumRYe
	 RfsillM+aq9SqiU3u5KQmJLY6jpZUmvgEEX5hBiGxiTSmL69xCmc6P3HPio6l+a/nX
	 R59DXQT928vdtpXec9UR26HucxIAJa1s0Fnm5dHfTohCaPNqQDZESPkihe4wNFKri6
	 qIpn9ZTjPvv5Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvzYC4KyFz9rxG;
	Wed, 30 Sep 2026 17:31:43 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v10 0/6] rtc: s35390a: Allow use of output pin for
 interrupt signal 1 for wakealarm
Date: Wed, 30 Sep 2026 15:31:45 +0000
Message-Id: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XR207DMAwG4FeZck2nOG7SZle8B0JTDg4LEutou
 go07d1JO6SVLlw6sr9Yvy8sUR8psd3mwnoaY4rdMRfAnzbMHczxjaro8wMTXCiukFf94PYJJWp
 u9vE4QCWlcs4ibz0GlsdOPYX4NZsvr7c6ne07uWFyfjt6+jznz4ZbG7MmUeW6j4847DZjs8Wqd
 5JN04eYhq7/nhccYW7+f5URKl6BFQI1gbIknk9dGqjbepqxUdyBlkMBEBkIwJ3WxoNXbg3gEpA
 FADNALapgrEEScg3UCwBKQJ0BBETk2qGSYQ3IBSBKGcgMSLI1hVY6ZfQaUEugLgAqAz5oJZUmr
 OEhxGYJ6ALQTABZ5xGgRkNroF0AWLpCOwHGgXetcgQPGeg7oEEVAJ0BK6Rq8g1qLf9kcL1efwD
 bEHib9wIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5846;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=6bD3PfnqyU0NTP6XvypjfAMTwFrD43+9GKv+BV5TJgU=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqvSte9LaeNPXIzryCOHNjlbyLOQba3t+hbbZp5
 c2h8jlJcveJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCar0rXhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Lt7g//flExMbDyVoUYFAK5W1JMfqa++mb0n86
 VBxscJFp0LsqAuwg9v5H/+p76tYIVQh5IR1k8KdKjI4fq7SVO6vZSCOPVRmjyVX8xhYYRmt0DtN
 4RqJEW2wKTl2stR5qbbh8WheMRu+bmt619WRvY8SFPDvj8K1RhGC6sVKfcm3los/gUceKZUntoZ
 fVetdtVxEN9kU1E+HhRKLjO8l60rW9/vxc+feNlsYgMOeOEBKRfl1rWWPwxdD9vGUfGoebzPsXF
 2nKFr1VPVPsO7VC543wzQ1Gb9wJFkOkMpfYMR6u75ig3FbqACSI8YHnsy79tPfDwhFNhB5t+LEE
 P0vSxsEi88RYrafTXhR47UTHdY5Ed636YnnvW6gKimQaTovsaSiLSTxnxXcxL1SrztViT71WtX9
 YITlnt7ObK1ln6V+oI4leg9mTPffGYK9nZBCEGEA5pTdVdlGr/oHFaHKScxGTDoL1BlRM/t9dx6
 FBMO2VoGW6ZTXI5NzOrCFgN+DTPUtWQV/J5kPfiN8OZ1nJG1gexx7F6EnjNUOc48Dt9juZY4vLi
 rfoGCPp1Eg7jWXk+bIihglEsJPQaXFlHSuUTWBtIzu2M3JUJoT1Db2rIUkoUse/oE1BR5UfIUIa
 +srMqO6SENkikGi+Nk+p/mkKIFG4e3dyNjjerSE1Ka8VW2voN4kI=
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
Changes in v10:
- minor dt bindings style changes (Rob)
- Link to v9: https://patch.msgid.link/20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de

Changes in v9:
- fix issues reported by Sashiko
  - fix interrupt-names in dt
- use interrupts in dt example (there is a known dts in the kernel that has
  one)
- add Reviewed-By trailer from Linus Walleij
- Link to v8: https://patch.msgid.link/20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de

Changes in v8:
- fix issues reported by Sashiko
  - avoid usage of cleanup helper and goto in one function
- replace dt binding maintainer with self
- use allOf instead of manually referencing the properties in
  pinmux-node.yaml in dt binding
- move additionalProperties up for readability
- Link to v7: https://patch.msgid.link/20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de

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

 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 118 +++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 -
 drivers/rtc/Kconfig                                |   2 +
 drivers/rtc/rtc-s35390a.c                          | 473 ++++++++++++++++-----
 4 files changed, 498 insertions(+), 97 deletions(-)
---
base-commit: 5a956dde5526a634dca7ccad27c051ebcc306089
change-id: 20260630-rtc_s35390a_int1-556ccb308d3f

