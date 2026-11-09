Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239111;
	b=31Mh85ttLHPNHpqQbYoI1J+mKNes6f/CJmQU746qNJjPIQg3z5sPbJzB8/iCGMPhZkiX
	 BIXjGuBiFsfSO3gyyrCUOZnWmMNwmmezsDiwotNltC20xIOcB2F5zl0ZRzTOuTTVNgYGE
	 xIkth9lo/b+1RMSVPzbiKGiDTJuuxKD5Ny2SKmwUqgGkB/7N0RcAOfnV/2wSYUufigJ1B
	 zKMBAii8lkD6vQxYlpmofJBaigmA3xUsGlO7V5okqkgP4tjnrdkFFCbGed71HB573iuwH
	 n9DQ/tt88D4Hit4MEkhhF3SEmeRF2Q8mv5xC23u6/s0URgyi1gyz1cBbR7+ZzK/ZTlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
	b=GABW89Ifb4GP6+xSoPbjDzBE7K/kCmEoejny6VA46jawhWKEbGi5mQSR2n623G8VuxNY
	 PzHgKci6ciEcObh1QQ/Aye+8Us6CFyttJg/APRxbl4aF4fJDdEBduqYytxP3OAcgvn/9k
	 W3ouNvBO7AWyuPghB83eO1+fWkegzvSRepId84opyZUD7kTxmwsV2kvmegmqjcJFuq39d
	 0JJHNkpNgLCkz0qf5PJyqbiVZhzSupaDY/LvQHaCNiIR3qI/QiIH5m8lad9LrQBjhdyVy
	 vtkmzAz2oLSUiczvh9+zZ/fnWHz3Y4W1jedLHPYPuVLJ+m+xbLMjGFObttLtXJg6o+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxMiVwrH;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6B606EEA3
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF6B606EEA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxMiVwrH
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so12762655e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239109; x=1794843909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
        b=kxMiVwrHgthmZG5BwH+M8Z/aD7QF/ofqnxPCU+Eu92AUH+c1cK1DpdSeAK9TAJjwY7
         7sMjuNWTQasTENCjxM9bbsMcrlKik0NA8N58kzbdqCDhjyYsCLaXuP1yUnfNSwLsKlNd
         SJRfy3RU0210TAvojGoZsNPp2KPGZo2KkKeUW+v/fGCcHXnsYXukEjDSOmVpTMf7vXgl
         eEBAXoLRpUc0/SCthO7tczp3MpGejFcn7R1po7DtzPz+OftVLFE74NloYZvexw8zkUrs
         BKwkaQJtXXb7QQWmnIEKRf+4OjzMuXTStte2OfYkD0sfJyPqwg8kR1+wDRV1UOu0xm74
         NTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239109; x=1794843909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2Uvgg/TH8ek7dpiyCaiigwe788vwtcSZF4TPOxN5MA=;
        b=BIA9xXJ+V80PoR13piD+h1JOSspSfgelHfaUXkrqxo4Ja1ahMGY/7rfmu7dwpNPAbs
         DmWBRtrq5x/D6mYxp8cnBXFXeEw6EOmJhKxSWhMUd74vWEhp+0IoFp9MMszqa/6Axk8T
         hzDQfj4DsBFg2rWD9kDYdoggU+jKIKEg4dfqOKfIxtCEg1cX4LKKx/8ycYgb4LnKQ8gd
         5efFtY0P1zeqY6LN5Vf6CRaWTOUoo3lToIy4BysFSqZMh+EhUXcVzfKvO8VQIw3rADpi
         YF3sZp4J1OgTlp2GtQ1R4d+9O1kYaUOIYC595t7JWT12Gdt5cZy1p52LNXZbTFW/MdPw
         LZww==
X-Forwarded-Encrypted: i=1; AL+hErFwwE2la0MWNndiKsB+nkHLY+ttZuSVztT14iOAgMVlc3VpF7J6bgamo3tgEVFS6qrZaJp06FHm0eg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZzRWBI8o8F0kKWcS9q9uFAEUYU9BFKTYMmTruKreSztkExjmf
	g/3eu2Estde0V8c+Jim2sPCf1gCUXLGDIv0bQLhl9Om2wHB9TqlncDUk
X-Gm-Gg: AYBFou2ZsBtngBynCF22Mi3xPl6891svyTN62deDbjh904MtVjEMv1tTXz4k8RqaeCL
	V80kSuQui1SdrGvTXIBlgGyjAc+bF8QGPXIvX93eabnrUDgDgIyPLG8ziar9pnFqsMOmu+NRtll
	4f9TB2IjxwxejtRCwSN0rHCuWUAoTqt4GmMDgx/p1vJQSI4o9VieqMJTfPXtQ8D7mAC0Y1pUm8z
	CeOdP5/TQFwJYOck3kbt4akCgW6fExcape8PLUiaDCXcFuEKOQ7TQmNbdytgp2Mo5oeN30luK7h
	RUkFzxQwG98L3bJUIg0Ao+Fp3Oj9u9Hgh//GJmd81aW9zK0mcxa+ggIt3T3zUkISbJ4rVymGmSL
	Ysp1AuTCyJIwfOSDTvWW0KwAeGTI/aDZenvgTm0m2Nqmc16wkMlqYYyNH5zpi7+n0JljepEkIpI
	403+fEcJE2px3jNc1IFaQV9q2sDGEggQb/96KedNIphiuL2xjJseipKt8UkhLfXYj7ay29pjuC0
	vtT6bGNs7SlWJXZSY6y2jmuBPSGs+bAsoLSPdiv5iZT1QCjJj7rUNaejv/XGDq0Y6mahnkM9Abp
	/Ud9jfbZLCt3K05QGR5xUprvygo/LOoDmQ==
X-Received: by 2002:a05:600c:1d08:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4b960d9b26amr81779735e9.7.1794239108805;
        Mon, 09 Nov 2026 07:45:08 -0800 (PST)
Received: from hp-z640.fritz.box ([51.37.204.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm257163645e9.5.2026.11.09.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:08 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 3/4] MAINTAINERS: Add entry for the StarFive JH7110 RTC driver
Date: Mon,  9 Nov 2026 15:45:00 +0000
Message-ID: <20261109154501.63762-4-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109154501.63762-1-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
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

