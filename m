Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464024;
	b=bCo4GX/EiApxNBkL+om+Iuc2DIYlyILPXbTePnNbPD5Ra31orMH27aZVwcLfQS3lqOeE
	 cu6C0mGUes4otSJwQQmuWONeYjjhi5lUiMUXbRjJHYlo/OefOV2Xkbn5L7h9RQ5zrMTQJ
	 /5DBrKV45xsRZk8ooDHhsVJAUi9ImxvDm7wIkwhctgD1Ksni02ziOpobJ36p1EaqI3+Ka
	 HxfDs9gvJu6YfKfwVaeW8qmh4p32OrmbK9Lb+jJS8tEnIaWIR3+vj+KWKyDSGbDfx1+2D
	 i5D8HnikHkGRMaB294iaDSDZXIHvERVMdaGJadkle6RWPT2Bd1Bs+DDP6JPiQpoeWgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lafBaGzib/nfUJhb2MTI1mfxlmB6w3uNCmPXLXoCcU8=;
	b=AI/NtVxYaiSOD9Sxu2HaFGWZ1JgAeyCO2VVicyPspq9eIdP9BQqQBSy+iUw7CwcxpXw8
	 gz4Au8HuqPTqxXXG813JorVbz0zGEhZkZalwyXtSaaQj7eevAbayuxCs3/5vmNPtRroKp
	 Tk0ub8xMG+FhR7wG8rGYm0gpVx0BGv+mlOVIX9RuBYK8TE7T41IbS8JuReAZGZ1F4Z+Vl
	 z4HmELz2vNGi5CKwuhWStFehSsppxOdQ1qPHmEr1/Y7WWh+N0dNtR1LgChGl0baUIjK6Q
	 GhCXSquDWDbk5OGf5BtuWShENLGFIkobeG70ToQInnjz/wI+AIjTBOS7GnpD/DiVkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtM3QgtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE61606A31F;
	Mon, 23 Nov 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtM3QgtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B9E1F000C0;
	Mon, 23 Nov 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464023;
	bh=lafBaGzib/nfUJhb2MTI1mfxlmB6w3uNCmPXLXoCcU8=;
	h=From:To:Cc:Subject:Date;
	b=RtM3QgtKHi93BUZ9vS0uZST9CtS2F3EgWc+cpbG02hKYxlSmf81K1oUwIWTCilMvt
	 SWmSvcETrz7V+fQF8vKyXJTjQT5oFLpIKj3rG2OVttqDuG7V6mp4cCR6uru2EuGptP
	 Ng9J+xAzf0121RYp4FzJdVZOZgFdWLs9JLfz4To7zR0Tc900Se6TREYY5AJ1zkGwmx
	 UxQzK06YqT5o4JPp3gC5VVUqHD/lwtYyZBgSjqrHgl1An8bOnncTGFPKGiQWQMQTNK
	 Nd2K3CpIbiCMgc6CcKGnRaEomijNHI0TS9Oy1ujN51pHFTW3Bv35KMSnK9JLTAkjXx
	 gOiJ0UPm6RSOw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: "George G. Davis" <gdavis@mvista.com>,
	"Mark A. Greer" <mgreer@mvista.com>,
	"Tianping.Fang" <tianping.fang@mediatek.com>,
	Adriana Stancu <adriana@arista.com>,
	Alexander Bigga <ab@mycable.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Benjamin Fair <benjaminfair@google.com>,
	dmitry pervushin <dpervushin@embeddedalley.com>,
	Dmitry Rakhchev <rda@emcraft.com>,
	Domen Puncer <domen.puncer@telargo.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Eric Liu <liuer@nvidia.com>,
	Gary Bisson <gary.bisson@boundarydevices.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	John Rigby <jcrigby@gmail.com>,
	Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	lm-sensors@lm-sensors.org,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Medad CChien <ctcchien@nuvoton.com>,
	Mia Lin <mimi05633@gmail.com>,
	Ming-Jen Chen <mjchen@nuvoton.com>,
	Nancy Yuen <yuenn@google.com>,
	Nicolas Boichat <drinkcat@chromium.org>,
	Nishanth Menon <nm@ti.com>,
	openbmc@lists.ozlabs.org,
	Patrick Venture <venture@google.com>,
	Pavel Machek <pavel@denx.de>,
	Peter Hartley <peter.hartley@sigmatel.com>,
	Piotr Ziecik <kosmo@semihalf.com>,
	Ran Bi <ran.bi@mediatek.com>,
	Ryan Brue <ryanbrue.dev@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Sergei Poselenov <sposelenov@emcraft.com>,
	source@mvista.com,
	Tali Perry <tali.perry1@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Wolfram Sang <kernel@pengutronix.de>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH 00/10] rtc: assorted bug fixes across RTC drivers
Date: Mon, 23 Nov 2026 19:59:11 +0000
Message-ID: <20261123200012.502284-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

Cc: "George G. Davis" <gdavis@mvista.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>
Cc: "Tianping.Fang" <tianping.fang@mediatek.com>
Cc: Adriana Stancu <adriana@arista.com>
Cc: Alexander Bigga <ab@mycable.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: dmitry pervushin <dpervushin@embeddedalley.com>
Cc: Dmitry Rakhchev <rda@emcraft.com>
Cc: Domen Puncer <domen.puncer@telargo.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>
Cc: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: Eric Liu <liuer@nvidia.com>
Cc: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Imre Kaloz <kaloz@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Joshua Kinard <linux@kumba.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: lm-sensors@lm-sensors.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Medad CChien <ctcchien@nuvoton.com>
Cc: Mia Lin <mimi05633@gmail.com>
Cc: Ming-Jen Chen <mjchen@nuvoton.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: openbmc@lists.ozlabs.org
Cc: Patrick Venture <venture@google.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Peter Hartley <peter.hartley@sigmatel.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
Cc: Ran Bi <ran.bi@mediatek.com>
Cc: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Sergei Poselenov <sposelenov@emcraft.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>
Cc: source@mvista.com
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Wolfram Sang <kernel@pengutronix.de>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>

Lee Jones (10):
  rtc: rx8025: pass parent I2C device in clock_adjust_ppb sysfs
    callbacks
  rtc: mt6397: handle non-DT platform device matching in probe
  rtc: ma35d1: allocate RTC device before requesting interrupt
  rtc: mpc5121: get interrupts via platform_get_irq()
  rtc: m41t80: use devm helpers for square-wave clock registration
  rtc: nct3018y: fix clock provider use-after-free and leak on unbind
  rtc: stmp3xxx: unregister child watchdog platform device on unbind
  rtc: ds1685: check driver data for NULL in ds1685_rtc_poweroff()
  rtc: omap: prevent NULL and dangling pointer dereferences in power-off
    path
  rtc: bq32k: use u8 register buffer in trickle_charge_bypass sysfs

 drivers/rtc/rtc-bq32k.c    |  6 ++++--
 drivers/rtc/rtc-ds1685.c   |  6 ++----
 drivers/rtc/rtc-m41t80.c   |  5 +++--
 drivers/rtc/rtc-ma35d1.c   | 14 ++++++-------
 drivers/rtc/rtc-mpc5121.c  | 41 ++++++++++++++------------------------
 drivers/rtc/rtc-mt6397.c   | 19 ++++++++++++++++++
 drivers/rtc/rtc-nct3018y.c |  3 ++-
 drivers/rtc/rtc-omap.c     | 21 +++++++++++--------
 drivers/rtc/rtc-rx8025.c   |  4 ++--
 drivers/rtc/rtc-stmp3xxx.c | 29 ++++++++++++++++-----------
 10 files changed, 84 insertions(+), 64 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

