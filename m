Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2803B9617
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198643; cv=none; b=q5bwc2GWqx/LH22itruzQl1oNHDjdGtyWt3Uh1dp5xf4oLalchzhAoGbg+my2DqbJkd7ipOaCbsBLjdAgJ/Vr6+GhsCcwV4fDRIGy5uXWhTkm3sGPNABFHDlRtszwv734NW6I4QkOwIClsbjvIEDX9QeT302ux5+LN/wFEC/sgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198643; c=relaxed/simple;
	bh=GPcWCw34kyfkarzSrLj1Q4kRNMiNXVGbYogVGPPudqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sRES0hoW36BOfqQxgQO6gkOzIH9bDmxwRR2L+bAS+PT6CUPQLaXkp+EZrUtOj5R2V/JnPwVHN7dx/D/8ujl0hkMRUa6h3e7UnH6wJXMD4h3GZO9jM+U+K0ONztWGuXbtfGLSGHmkdbixw/DJQXQYVaUxMhIKHhp7YRfn/dsxoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cIposwp5; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cIposwp5"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D9B4A240105
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 19:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788198141;
	bh=UENdJAJyahjHlzGhEf0s0mTLazWGcYweY6sOfP2eFPU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=cIposwp5YLLhj+dXEINXGjpa6YU+J6ypZzWnvgKqgPi1j90zNeYPsNaYmjtZ9SbLt
	 d0yz5E67/Ks0E5bIa/bHpgooanLcA+ecH6n5pUswnOO1+AJ3RAz0H+cL9XHJL8Nj3x
	 cU3homGscKMC9MWNCzcjElrRUe4mguQLD8ctOAglhv/4TWyO4ohhqD8Qd++KPqeDyf
	 9zf+5HRxdgxAfZ/aio0k/hJvPbAUjTUnApX0LreeufJzimFBUp5ULrF5sp1xgEU3nb
	 YuIkdy9bGm6MVCh1sYHs4bLqcW9xBC7dVnD2MP1bJRRKXA5bZeYc2R/nZ6Fn/BSHJQ
	 byx3gVk33qPJg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hYbsk2Q69z9rxF;
	Mon, 31 Aug 2026 19:42:18 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v8 0/6] rtc: s35390a: Allow use of output pin for interrupt
 signal 1 for wakealarm
Date: Mon, 31 Aug 2026 17:42:21 +0000
Message-Id: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQ0WrDMAwF0F8pfp6LZcVu3Kf9xxjFduTVgyad7
 YaN0n+fmw4WsuzxwtWR0JVlSpEy22+uLNEYcxz6GtqnDfNH278Rj13NTAqphUbBU/GHjAqNsIf
 YF+BKae8dirbDwOrYOVGInxP58vrI+eLeyZe789NI9HGpu8qjxpzNxP1wOsWy34y7LfLkgd2nj
 zGXIX1N940wlf8/ZQQuODgp0RBoR/L5PORCw7ajCRvlL9AKWAFkBQIIb4ztoNN+CeAcUCsAVoB
 a1ME6iyTVEmhmAKwBTQUQEFEYj1qFJaBmgFz7gaqAItdQaJXX1iwBPQeaFUBXoAtGK20IG/jzx
 N0cMCvA7g6Q8x0CNGhpDtxut2/LL1B7dAIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5384;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=GPcWCw34kyfkarzSrLj1Q4kRNMiNXVGbYogVGPPudqU=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqlbz4UKCHNj9pHy7GWorlg5xJLZYQ59i8r4lrx
 a6i49I6YkOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapW8+BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L8cQ//bNsbVB6gcgCpVuqFjNBCAWSzkhCbS6K
 4Co8seimzQ9oLnSyo5QOIaoWT2621Bk1CPxxDIJpYEttt4BvQYIpah6RYXA0mM9kT/wrMFF4/u6
 +Guepw5QVZQdLFrhUwAcXSbyAkCebMyObKtef4AVXowYZB/Swwkd4fWu3gs+emY/J8bpt4LVlS1
 gaWLGvsPAJAJOvmQEpQcYIMSKxvriaKM3A67ElaBoAmjdzNEs0K2WNOR3cvKEm/AV3J6H9u2u7e
 KhEtflijA6vfOSgKgh7hG9Jgs9cDkrUtZvUZkikxckLKu1sY9tK6q0FanEehdzC9k5lC6Ir5nJE
 8QfBh1JSs9/yjGuIKa706yEixDthpJb1GmxdrfvaoGAD0KoSdK5QKqKisKblJPtjMH5x2HM+6km
 0K4qGmTKABNlCeuSoX43UMkCHA3lRyY4eFJq/DOS7/IoAl9xH/DAuxgNfCBCQtsZv8XgffDpu+d
 pS7SIAQOsTG1BqokRhUGofDpZorvATxayLfJmxHWIebinBJmtvSFDeytZ1xly/i2itqXuUFxT3E
 n2EFdxi/WwTyTi8+G+3gSdhyPMQbvvXiJm+rIoaVHfh2jU4bf1Ft67tqEUfOz9rIaTIgmPU5Qs/
 yx4Mv62LCMh1/dJ7iiZ7fKxG5XURNwzE4aHnQa1vupLjpfMaRoek=
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

 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 117 +++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 drivers/rtc/Kconfig                                |   2 +
 drivers/rtc/rtc-s35390a.c                          | 473 ++++++++++++++++-----
 4 files changed, 497 insertions(+), 98 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260630-rtc_s35390a_int1-556ccb308d3f

