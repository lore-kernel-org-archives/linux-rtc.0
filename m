Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854799;
	b=WH+rVtwCglgk6oi4nmucEhhBlZaWJ8oryEAy0K056EjyTritdI4LlciM8h78ZtEY9tXz
	 +adBY2tDOg4IH7UynFIkpAYNRn5CWVnNj4UEbyPX3Y1rXLPsNWn52cuTI5t9J0815iBIp
	 bbwxTlvhXB1BWSo2DFzNiWUhOLvetOWtjbSSBfRpvk9UL0no2yiUjWvrloh9OufKdRlRT
	 5cvF5crcRlv0ODfO+zXb9oWhpVicEnxUwafTQJZs4qqT16ctqpRroIqF0rIOjl/uwKm7S
	 4qPoXkBkJRXoI8/mJVLFdX0VFhg8cmi8CJu34TTe10EWKRCXW3mReYdnPZIVTE+nAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=P78VDpsJpTz+1/Uu6wAD6OIZCd9bSuoX6Podaf0tODg=;
	b=ej80xRrefJk0P9A4Pm3vxrkowp8bEqyAQxTsSN0GAkb2oVq7T2AAKLUt1IGAf+X1HJSR
	 qI4/k8bRLZ79bMOx0BhJT6alYm60hboAWTvUdjKDD71/l5m8SpS8PCqn+FzGZ+P2Cgron
	 vD0UUIn6VTPWvC8XbXN2+qCLgQvJYD45zsci1ocfF/zlulAjHtuSCDtOlw0NVrpTwCUYt
	 rdmOmvBCqtEZIvZsDc4FmMNwBxsxqXcp5WQ5GDRSSCi2Xf+RIyHUaqjKpNHFe2fRzi5T7
	 4xx40bIz6YOvbSyQZbmv1dOaz21qnJuwhj3hJ6EmkYT11Lb1l+3t5+FoKogAMXfi44Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc0qHYFT;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80132606A32A
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 18:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80132606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc0qHYFT
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-849c2965b9eso1167228a34.1
        for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854797; x=1795459597; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P78VDpsJpTz+1/Uu6wAD6OIZCd9bSuoX6Podaf0tODg=;
        b=mc0qHYFT/6qwRjTi3Dtv+++yFZW2fqcMUAcIKPmQF2uTfb48OKPIH1SeI2qe5vtsXR
         q5Le9wFFEJZAdvcimDV5B7gmwCUaOlsGHATwTfxRRirTW4XEjRlvL/UVFoMZg1lPfx+I
         Xy3vSdrq/orlPickEvoGy144vofdRuguz1AJ0mEJXfBjOSCMQk9df6lBHQ/e0JUbpxUz
         q6HFcq+0wmiKJighYZt5EC/3Suu8GosBiUb+GAvlCqhIOMPQWUqoD8MlTlyAzW+eTI1O
         jhXfpB8+n6zRe6rEMlzy11XjSTDJfbj8oeaiiLK9LHFqtwfLyNhT6A1rp3I63IsJZ504
         U2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854797; x=1795459597;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P78VDpsJpTz+1/Uu6wAD6OIZCd9bSuoX6Podaf0tODg=;
        b=MVn5+k58FQ5l4OJp9YjAcMfNvrmLhe4ewzm2sxNqOrPt58768lVXLJGL2V4ek2x9nV
         /33MbvQxSSs1u1WtRfGzkVdynysubloZQpAYuqUva/up6zZ8SKsoEAyCqX1Fdkv8dTLi
         ns8WFMb4uRJANKnuZFWamaDmlyQWJAMKs7OyN2SdloLMVJhC6YkNfqazMGdZelkB96uN
         SoJkXTNNwM+JBgUTHSTltqZ/geKZggm2SEkEJ270k3lRRdo1uRcrdRj3kzuJ3GJn/01j
         1xl10MCRfJM9YToUjsRu1O5XBj+V+u0KTHxSLt+bGiH8203cFHDPvPDMl1QknrHLZ+Ay
         hDBA==
X-Forwarded-Encrypted: i=1; AL+hErEN7KbmKVZgj1uuRvkMY9TXzBcU+MDKBhL1beW0rOdzf8EtzbhwggzHS89276Fq/ZcOv5fU8v3BQWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z85WxpoV/dGv6QoU+B3mAD6SfhI65uCasB3opbMVLo5x4Rb/uQ/
	Y86886pLNBRK/Yi4BRtmUVRLvA+6PADpZMP5wiWZnAqWvKZo1ybVANoA
X-Gm-Gg: AYBFou2KiO6Bi/7REOyuK8mKawK0y4RkUd1HfIvuPhQsjdm/ucwR1AUswl907jvuJVa
	N3b71/URgx80kEHH/xOg5X/krkRfiSCHGDsYgxs7siD5ESLRRDzVElHHuI0NTg20bFig8/zUn+M
	9gqDMGoeFmPw42bSkuK1nuNbtFN/e3HNBkW2LfkyzUnuX3Rci23j5iH2PzPTswpCr0TZDUPZoWS
	2zg5PqJEzyMRKZEWTKD4gtpBiouUTpGj6gaAFCTZ3Ov7I2miGnFlZcrzvtiArhX2ee6ZSeUb/+/
	oRULNRpZVGaDoXumHaJbqlq9VmPyG8Tzp5l8/oF4U8LdfyLYkMOOYgfwaf2h15cOlI0yEBpwHig
	wqKzzcI19I7BrYltCeFQaQv4o05D53Dih1M2F/Qb7irvDQkxPz/BGkq6X9N0LySGlGWXagKiRSs
	9ndPe+IaxbZ2QhTNZ8Ny1lhwfY2g/DKzuGukG8/tvQv1Fb9PCuXhQ5k3RSwM6TcpInX1NQXhdww
	aAi2fcYuFGv/zXXaoMU1TKOv8gKLAKqW1jNPSuYefAp9Y8OHvNjNAXcWbhD+3wynPkiAxVzkJO3
	oGa/CwejLVyhwZ6q4xkrhaVjV2bLTVTKNOO/NjUj7Wyarda9CYSv03Z733wZ9ErCtqHpVB0jE8D
	Ylu/u5+hM1sbJmNjE+RdHe+DO39RaOBHJTs5CbLoL
X-Received: by 2002:a05:6808:3186:b0:53c:7298:3591 with SMTP id 5614622812f47-56e5fd4852bmr9836229b6e.1.1794854797281;
        Mon, 16 Nov 2026 10:46:37 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe242b670sm7210735fac.17.2026.11.16.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:46:36 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v3 0/2] rtc: mt6397: provide the RTC's 32 kHz output as a
 clock
Date: Mon, 16 Nov 2026 12:46:32 -0600
Message-Id: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43Nyw6CMBBA0V9pZs2YTkcosPI/jItaCjbKIy0QH
 +HfDbhh6fYu7vlAdMG7CKX4QHCzj77voBScCLA30zUOfQWlACVVRlIdMVzD5DBO7o3TEMfgTOu
 7Btsx40JjGC2yuqM0ZCmrM+acIREwBFf75+acL4mAm49jH14bO9NafwJJ+lOYCSUWOs1rzistU
 z41rfGPg+1bWIVZ7a/q36tCiVRYo1VOKevj/rosyxeEFL37MAEAAA==
X-Change-ID: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794854794; l=2739;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=edI0U8BJ05vm1zYUWZKlM1TrWGXlJBUbcmpWbDIqGNc=;
 b=NLQ9/9ifb2vqQe0on9JdNLDbVdTMhveUDIstOj4nsP4FUeFFlZdrmwfVC4+mYhCjsUQssYltO
 y+PtxNWp0vnACO+TbUGWxj431pgV6oe5TK+FwOAtVekLyd9sDVCpExb
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives a 32 kHz clock out of the PMIC, which boards use as
the sleep clock of a Wi-Fi/Bluetooth combo chip. RTC_CON.F32KOB gates it,
and mainline never touches that bit, so the chip only works if the
bootloader happened to turn the output on.

On the Amazon Fire HD 10 (2017), which can boot through U-Boot instead of
the vendor's LK, nothing sets it in the former - LK sets the bit at every
boot, and the MT6630 combo chip's Wi-Fi and Bluetooth never come up.
Letting the RTC provide the output as a clock lets the chip's
mmc-pwrseq-simple enable it. With the clock wired up both came up on that
board in two boots out of two, and in none of three without it.

The driver registers the clock only when the RTC node has #clock-cells,
so no existing board changes. The MT6323 shares the MT6397's driver data
and gets it too; every MediaTek PMIC RTC whose registers I could read has
F32KOB at bit 5 of RTC_CON, but for the MT6323 that is inferred from the
shared driver data rather than read from a datasheet.

Lee has applied the binding to mfd [1], so v3 is the driver part only:
patch 1 gives the existing write trigger member a name that says what it
is, as Lee asked for the new one, and patch 2 adds the clock. Both are
for rtc.

The board's devicetree that uses the clock is not upstream yet and follows
separately.

This series was developed with the help of an LLM.

[1] https://lore.kernel.org/all/179459615032.87488.12726056214378307165.b4-ty@b4/

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v3:
- rtc: name the new struct mtk_rtc_data member control_reg, rename wrtgr
  to write_trigger_reg in a patch of its own, and the local con to
  control (Lee)
- dt-bindings: dropped, applied by Lee
- rebased onto v7.4-rc2
- Link to v2: https://lore.kernel.org/r/20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com

Changes in v2:
- rtc: check for #clock-cells before reading the driver data, which is
  NULL when the PMIC has no RTC node, as on mt8173-evb (Sashiko)
- dt-bindings: add Krzysztof's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com

---
Ryan Brue (2):
      rtc: mt6397: rename the write trigger register offset
      rtc: mt6397: provide the 32 kHz output as a clock

 drivers/rtc/rtc-mt6397.c       | 95 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/mt6397/rtc.h |  8 +++-
 2 files changed, 99 insertions(+), 4 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

