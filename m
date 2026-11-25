Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591241;
	b=cs0DWhCoTjDXCYYwgJsQqC1NbGI5pAOKk2UWRnbcfaP/jeThvcU7Wo+htRBP/vTPnMo8
	 l7tnbPCsBmhCf2lk/4FVaNwusexcXYpV4xebnyD7KFjWY734pJr76m83kM87h2xGO5PZk
	 lHpL+VlcPGaTiIYHxG82izIx9vYLsUzGGmtxIVVjhda1kXQ8kiHXsT6mOitGkAnLS4Sdx
	 eNTnmtNi5gtEKThDtIFTJ2wMzldpSZU8uijrz1+bFlSJJFahN9I8hD4fW2l9MeihbWKdS
	 0rG8Lp9Ppn9vGtbDHV0vgpPPf0C18S5fo0vNF+/OpYtRmM9JIWnXm6si0rkxGhHB0BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l1SQBJPQH32GaCf6i6Hpvj4B1BS4U8Mq3RY+38E+QYU=;
	b=NEZIXxwwaBILiNVKYTMeB8p1zDJ3lOEB5IMvkg4wNljf0ZeGZuGi1kLGLccB+VmDiV0I
	 M4fZ9X+iopqxH22rzUgY+4WFBXWYCyL9M6K/Is5YHHc/zf6b80SZUrFYGjYqbjLfMF2/F
	 BlnX26SZc7/0SYKR6AJlOoLuCJT2fZkpM23lq0XsaMdC818HFBC9NjAdUlJOX6qkltjD9
	 DZzteKnMIAquLZA6GhDyrRpgEPzH1aRbzxJQkbYPv2cgCG+bSwt/awEWNM2Ld/m0fSIbe
	 Ck/hwNZZDS6OtkYvGFHUZT1bTDAb7GU4oI3/4Xx8qlmN+Jv22Py/RPkRUBeYJ0ALqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Hj0WHV0;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE174606A33F
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE174606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Hj0WHV0
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2471545eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591240; x=1796196040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1SQBJPQH32GaCf6i6Hpvj4B1BS4U8Mq3RY+38E+QYU=;
        b=0Hj0WHV0sCenXk/k/xVcG+zSdCreRDnD/0hLussH4OcMEsCHKs2cJCeuaNJHXOdMEQ
         5icV7kjOJoiRr2VoLmk90HusSg9HJw+joHGCkYzd/qs5wgplo2gNXHItwA0r82O67+82
         Bk4viAMgNdSQw7Z7QdrhGHtxOEhU8OMjGwJGM+boj2LbVL3XwPKarLQ8R0dYZ8AyqTHi
         v/MJ++szMSU4Nx8K8v/iPc6R5HheJrifO6Yun/y1quskPQtygqyBFeUpf4M6iTWiNKUU
         4IICQN7VqE54J428XNHhD7vVxXuWxuWT3FLR35EgR21DSrvlNdW2sjKyUVO+S64I9C36
         3yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591240; x=1796196040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1SQBJPQH32GaCf6i6Hpvj4B1BS4U8Mq3RY+38E+QYU=;
        b=mS9pgym1JaiSh5d7+Xb1eVZteaYTxBAx32G25Xoe5MvwstOVA9x5jp16lmiDx55giM
         uc5djfcOK6JTmHuYnWXNZLCIGo9DBjeSjIt9GyPsQG3n7ub6ZDoV3u7D+GVVXMCClDYZ
         bs6fjjZNIh2IUFV4QPeK5vfmG7+l/a8uPZ9b4MrDwi2vRcZ+Sv4OZT7zS/nlf4hCUY2G
         xvpydNX+zwcZZ2hFGMDqWs7k2vCJ9IEX0wz9HLWDCSTD3OyvTWWS2aU0e+13YxNRcTaD
         PZGVmBfayi2Mx7jRTVljylj5AdhS91im42oisC/H8lpIBUQloasaMNkiJIWKldOtVG08
         cwTA==
X-Forwarded-Encrypted: i=1; AL+hErEC9qRxfsknZcvz0uz0yMXKCkC9iwelNkSbbcykoLmRSNUU/talHdAMRC3PokGykajAib94W+giUhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VpahhyvJr/ORTW5+0HIHqwNW2LAXf5nxrK/nMo3el3UV9/hLO
	7kPmPzS+FIErVYcQXSLhsEomSbyx8MXrPF4f/eMkgda44cYGVJsVFCt0
X-Gm-Gg: AZFdTZfWsCTWRyGxbwgpmhxnsbqbv6XeXvmlVZ3pSqpx4SXinRWq2LM9KgKcooiaKla
	Q065U6bUAKuT6rpasNzbTmRy/fpZWn12x7seSnIV29ceBChY0Yp7cLNFBPbwwOzXHZeMSc1/Pb0
	jou2rWOIdF5IMDzu1F4iZcKGRmExpG+FIMggdf1N3hlQf0iH5VjkYapbABX0X02Cb7qkf80CGX+
	yKK4CVspqFHBihe0jSy+LAV4crJTTfFEnQBZib80BJgR2e344zFtUnDdfy+FMUa0GoTrmrbh0kA
	2KhPMs3sgzNgd6Wv9Xokwta0LAjn6cDh00TFvBacdPeqiH98tkRitobyFekKqsJ+B8CtZRHuSHA
	0XyEEHIYRyMOmqdQP9S/bdDNDblmZPmvzWXaEgowvfEypA73LBkWhtRkX50etzJYawWLFgCAubl
	tXL9cOxlgpzPguA9v6EjhT5JnVNgmYJvXs/QPwHow/G1HNis/lflvjN2aerdsycLtZWWP7ffaA4
	dRF1cvz66ifVAZpW+pZSqAODV5PjzYS0c2zm9XA1DeWYFl+22Ylp9H37T8tOlKWdQL6Abf2uCV0
	ceqZketHk9nhlTMPhD4kAdy5xgcuAZV01xH7M/fAyk65gNQOAq+9EXFXyohpJkQb
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr22650185eec.31.1795591239429;
        Tue, 24 Nov 2026 23:20:39 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:39 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
X-Google-Original-From: Prasanth R <prasanth.r@lineo.co.jp>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	CL Wang <cl634@andestech.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	Prasanth R <ragaprasanth@gmail.com>
Subject: [PATCH 00/12] rtc: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:14 +0900
Message-Id: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
X-Mailer: git-send-email 2.34.1
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

From: Prasanth R <ragaprasanth@gmail.com>

These drivers set a wake IRQ with dev_pm_set_wake_irq() and never clear
it. After unbind and bind, dev_pm_set_wake_irq() warns "wake irq already
initialized" and returns -EEXIST. For jz4740 and atcrtc100 the probe
then fails.

Switch them to devm_pm_set_wake_irq() and devm_device_init_wakeup(), as
was done for rtc-pl031, rtc-stm32 and others. Patch 3 also fixes an
unbalanced clock disable in the mxc_v2 remove path.

Patch 1 is tested on an i.MX6Q SABRE-SD board by unbinding and binding
the driver through sysfs. The others are compile-tested only (ARM,
clang, W=1).

I used an AI assistant (Claude) to find these and write the changes.

Prasanth R (12):
  rtc: snvs: clear the wake IRQ on unbind
  rtc: mxc: clear the wake IRQ on unbind
  rtc: mxc_v2: fix unbalanced clock disable on remove
  rtc: mxc_v2: clear the wake IRQ on unbind
  rtc: imxdi: clear the wake IRQ on removal
  rtc: da9063: clear the wake IRQ on unbind
  rtc: fsl-ftm-alarm: clear the wake IRQ on unbind
  rtc: jz4740: clear the wake IRQ on unbind
  rtc: atcrtc100: clear the wake IRQ on unbind
  rtc: pcf8523: clear the wake IRQ on unbind
  rtc: pcf85063: clear the wake IRQ on unbind
  rtc: rv8803: clear the wake IRQ on unbind

 drivers/rtc/rtc-atcrtc100.c     | 8 +++-----
 drivers/rtc/rtc-da9063.c        | 4 ++--
 drivers/rtc/rtc-fsl-ftm-alarm.c | 4 ++--
 drivers/rtc/rtc-imxdi.c         | 4 ++--
 drivers/rtc/rtc-jz4740.c        | 4 ++--
 drivers/rtc/rtc-mxc.c           | 4 ++--
 drivers/rtc/rtc-mxc_v2.c        | 6 +++---
 drivers/rtc/rtc-pcf85063.c      | 4 ++--
 drivers/rtc/rtc-pcf8523.c       | 4 ++--
 drivers/rtc/rtc-rv8803.c        | 6 +++---
 drivers/rtc/rtc-snvs.c          | 7 +++++--
 11 files changed, 28 insertions(+), 27 deletions(-)

-- 
2.43.0

