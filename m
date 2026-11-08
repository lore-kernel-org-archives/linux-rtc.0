Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173319;
	b=FeF//iFvCXgfXYWZ3WnzDIB2vPFJDk7GjWqnkxcWjloZ2HzAixPRyiX+MYpehDcJcAoo
	 AYBCPR7WuIy2kBUSLS4Aq10jMuL7iD+3Z2Cd6Litj6dM+uS3Itdrf44oLSjj0UecdaFFV
	 nEB/nwHaIhEmhahHULm9808kDP4T+lwSAfuDcHx0OYSWDwt4mE4rFH96X+dRGHrE3sA+s
	 t/R5Ieg2LjtzNoyxEKy9cLEam3NlHuiZHAwQ0POPPnxv6bw955YLQAQY10Mbwv+HGqBNA
	 H9KJsZn0sH8ocooRr8WJjrtPIc5pTVDy7TdCmvhOqTYa+R2H5/u7z7JxObSanpEKXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
	b=WcT0iXpxBuxZHlEjgiLlElTKrYMFLHHCZbKjo4CyPwP9vgyJ/y3MQzggNPU8m/oIphkz
	 sfym1rjSJ3fSVMmtlCTpuGCT4PwyWWvipY74I03uS26G9hkjo3WsdQHbGppNCufKRG0qf
	 9I6crjkdbBqDB0SHHU5K9akU0PGH0O0qJbsCVST8yaLccUFeuOG4rDWt2rQJCdq5SV2w/
	 5Lnijd/6twTMdFTJ7mss+nxdryd+A+nHuAbge6QmM27qVDRbJ7b4MnxfrGqxnwQObQ/or
	 OgZSh27x5W8cnTDbp+gmeinINiHyUcp/zrGELQ0mr+1stDDXZhNGoEHktRWzn/DOubw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2AcM23z;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CB606A322
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5CB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2AcM23z
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so229587f8f.1
        for <linux-rtc@vger.kernel.org>; Sun, 08 Nov 2026 13:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173317; x=1794778117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
        b=v2AcM23z1BVOLFwTZKhszyXsOaKS2NgJhzLGOR/HKF+uWV+fg3Yigp9Q0rJrrRXRPF
         n600tkwCP2SlPXnvgldYU29T5mltCD7rwnIGDiSbyGMRfa6aH+R+VyTipdEhm8myFcYG
         GxFAOepF9tjJloagYmtXkLWrxssLrOcams4WZgVtYf0ScpMjAhL23j4cHPfAt27mRsWN
         AtwZv1QFbZ/eJdLPH+a3kH3ueIrXwdd5dlimK3KA8/msL/0dxBMEI2k3wqHacp3LSRQw
         BsnTiMABx/OVq/k9klM/27DhUTQ+6vQc/AtBeJeTpDqi48/u0X24BjADKHn+GKMZDxyV
         L1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173317; x=1794778117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
        b=Uv5iVaa2zQ1tVNao1F8etbiEleGNyijKFU2OLAn3yJozwzK1d/Q4OKQljpVQF7spwx
         LTTTZp9EzPs0GTEN942dxQDG9r9V84E7HAZYu0CL35+4nJKIH+m+68TfPPkHIGO7T3mh
         PnvOKxjlsqRNfFaZ+DJ37RHjMG90ofK4x4M8TDrISNdcQlPMaAdBDnl0tq3G4qCx5Vnm
         xxSvHpbQiR+cjNFoXfN/x6Mq0T/2ZOf8aT4uysrq5b3uAT1pzPrWbEDZMWkyVJsEEPnf
         LxmOMTRTN8/+q1AcU/wL+tAbLh/prG569PORUkGaDWGwfL9pwqqs7X0cEc4Vcxmv2SwP
         Qg4g==
X-Forwarded-Encrypted: i=1; AL+hErFGtcCxmS4L4JdoLLi9ANUGSQw8ATtN18m45Q1XXvaBtR/CpgA8UygzhbG5CPQHuc/UjuyksPxmQ7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z85mQYzgN2V7GPzGmSsROn+L9EegM3SLfLVfAUAgLvvmX/9A9qX
	i3yQ2EPruiZO0aYhbLrh8hX8u6otVFsdPNW7u7CbjUITS5FnGcdNBRt3
X-Gm-Gg: AYBFou2GH12g85arGwBe9BI7i4n8aXg1ffDERAeR5HxiHZOGs5jA+QFshaaehNuZJ0f
	d6vspP1bKQC8sG8qwGEPL1UjIVyA3ZHvg/GyK2P/KoyFz7qY+P++lkZMxEKTY3xnws+AW47UKlH
	scXbgtm88oKL7T95aLABliLGyap1RAOgzOUODQmVcHiZkAbyr+QJup6/P5oAsvjobVss85GzeLo
	nm9/KSQACLtPV60TLYEYS93bDH2GANM23tOO8jEMNSFLADyU5U9fkjS7Z3c8gYKhBmDTVI6qaMa
	wr3qBdFrcHefJzF/sqvzdgKdoOLTl1ZHSH9YcEuSfV9IOz3gaW/5ogJHGW9EJjdPMzKtDz3bULQ
	Nckp52H07pOIpgna10p5vCpA56PX6Y6+7L7RkIcgWIakeQtqc0qsSYEHRX7KIp0JD8qEtIl2iTe
	bxzKE/8+37B9N4nXmg4q5p9CVDav3dy81wh+AkH9dUsGQr2E37niEfPeE3+oUqFD6079j+Bk/30
	HOpq932SSl5o08ogMEKAwtuvyFSniOfMbtv2VW6K0+NovFsNGCptqbe979cjLjxCZgVFa35IrFa
	q+S5jta2pPSI7GmPwd0bZaNh55whfeJeig==
X-Received: by 2002:a5d:5f50:0:b0:48e:5df9:1ec9 with SMTP id ffacd0b85a97d-4958b34c671mr4024764f8f.24.1794173317559;
        Sun, 08 Nov 2026 13:28:37 -0800 (PST)
Received: from hp-z640.fritz.box ([109.76.148.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597091400sm5692050f8f.32.2026.11.08.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:28:37 -0800 (PST)
From: Owen O'Hehir <oo.hehir@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 3/4] MAINTAINERS: Add entry for the StarFive JH7110 RTC driver
Date: Sun,  8 Nov 2026 21:28:25 +0000
Message-ID: <20261108212826.15890-4-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108212826.15890-1-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
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

Add myself as maintainer of the StarFive JH7110 RTC driver and its
binding.

Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa647f5d3..2ee86a46c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26877,6 +26877,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
 F:	sound/soc/starfive/jh7110_pwmdac.c
 
+STARFIVE JH7110 RTC DRIVER
+M:	Owen O'Hehir <oo.hehir@gmail.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
+F:	drivers/rtc/rtc-jh7110.c
+
 STARFIVE JH7110 SYSCON
 M:	William Qiu <william.qiu@starfivetech.com>
 M:	Xingyu Wu <xingyu.wu@starfivetech.com>
-- 
2.43.0

