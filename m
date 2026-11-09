Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239112;
	b=Eva+IG6+1fwJdXoF/nKN7reOKPpn0/ejS3tPjgYQS0GSl/zXEpYyz85uD4A6TEJbwjqV
	 T2axIyeyStIRMnf9IfazQ3kJKewLGiSrFVzAUNETH1I7fETb5Qov3vvO6dhv6+4MpRx9M
	 nWIW2nZXhcmxjHWxD8KiOl+sgtG4FL0fyOiJQnqC6gJz3Dcp1aopkNzZAfiGLFXWQMT4K
	 8MRsmoKPN7DOGrjWwuYczQY4Lfi/p1ZGrgirZUB75TH2PE+gOI8J4JVUVStuNJA79g+6B
	 XpFK9+Vut5tRcLTVhXNmsl2Q8uznlrsydyNvFvD/SvlMxU3Y6DP0u8LgoCyhZmhCESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=++xuuyWKK1G1etes6zMMtPPyYRZJNwwBAUgMD6pOMi0=;
	b=lM3bG2D/exGHJFeuqiuxbmMcyN3Q2erBg0f6LIhkrFI/BGSUGbnYk2f/IiPD7/8JEE1G
	 5qC8AOS+6p7ZB3yq4UPrtq5aHbQ8eJKXh+PxK2BlXeJSPw2gB+JpS5+iVhLcOc8tnOqVi
	 +PYXsv+QJqrzWyFpVU3xmnEyPFFBRC4S6Wij8mvas2WbGP3u9BoWMC8/AG+bjLFLZuiSO
	 2hCABG/V1NUGPzD8sG2VEiqNgUkaRSPBIfHiFIR2+sineoY4r+6loUHlzgj71jhXze9yS
	 gU+Mx/zdvSCcvocjlgdtO585narZ1G1plQZDWMegl5n0RT759G2AVdzPKCyLB7drKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaOJtD7j;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F7606EEB6
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217F7606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaOJtD7j
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so9318275e9.1
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239110; x=1794843910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++xuuyWKK1G1etes6zMMtPPyYRZJNwwBAUgMD6pOMi0=;
        b=xaOJtD7jx5mEGk5B/pZ9Exhce5KGFHlTlXdlBgbOwA8PLMypkHyTwDyag5aMOe3y39
         pSDHg6X8ek2rff9JHpDnbQ07TsroWqDA4IgkASDG5Vp2lSaW8NY9C2/QvDSpYIi7UvCM
         zzHZqxIB03YAFS6CGOzmJcf9u6cUe3D33u/wN7A1tL8IHQn0lfrGWqzm22xTrlRSqLlu
         Y38vQSBocLTXUwllRhKLQayP/lE8Ud1aumUDHTlLfTt56HhUrgss/cIMq4NZfaC+uPXo
         FdHSUbOoHqYZZJ3L07+tjToh3N3t2xQIPPLX7TyufanZwheUU2w+AXJqCQSky6W7sogI
         Sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239110; x=1794843910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=++xuuyWKK1G1etes6zMMtPPyYRZJNwwBAUgMD6pOMi0=;
        b=HbbJ/DiLSgvdkAq0/yiSNFDpv/YDfjFc4wqya34fdfPbzM3ee9SiGdbadvZg8aoS9o
         8QogW7VJYWORsL0bqQATT32t3NHjQ3JoYZrvNSN2TeaJwheLqY6YpgteV1wMmcFCOtQE
         r7/t1CatNKaSxdZCVG/4/fEu9Fd5c26np3Jm90TNnsOIJ8glkEZzb/uS1mzeHcPT2hXe
         OalQQVzcBF3Db05rYYE6pgEnMABPLxPqaJA19aGHmpEM2BCXIKD2niNHs7Zt8TvtW8Y2
         e1SOJkgIhNpQlfxSs2bMKgTX6y0dJx5F2V8WHTdxI47eGwO2IPbXtD8y53gyTc4CFoEp
         SkVQ==
X-Forwarded-Encrypted: i=1; AL+hErGcHSz5P+Mmtn6NQMLIqlIsyyu7URMENbWgHFau8RioDaWqTJvmtUGN+qMzqrnc8tf36StUZCgGJmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wSd7sQzf97K0JNY+j0AKYMfAVbu4L3yvf4Nbwsgc+StuDnajx
	C3sc4sgeTbwE++i9VJV/GMxxN24W8lwGECzlYMd9Wz7fB90D1GThgnJJ
X-Gm-Gg: AYBFou2lSwd1meGu58Gwz+BN7fwk51sowy1KAgN4xGm13PrenizDGjGPZE3g7nmUFN7
	Qorm3qiAtnjpye7x0zaxijLaUGMPxV4s43QveeBlsvhJTbQm5pJPdbbhgoQ8c5utVD2lP50Cq4n
	NyVQKXXNbWSq3JclVdijU98jzwkmCRsYUTBI5NxLooO+SyjAEwYJ26itMf2wqClE20GQY3jIPYl
	EZcJhVsrR/UtpnlZORRtjSRTx8rHph/u396R0txGjOdgilsHPM13O3Ksb5RfM/O5+AZZxSGy7Ef
	Ujf6nvpm64kcGNz2iBK85gfBQV/3UpMfwOSbETCeBIRZAKgfKgIUTv2Z6K+kTJEVjrKS8LgW5Yy
	nkw4TlTO66X81o9U0iNYJbzcW2Qil7s8ktPoY8tEephZVX1bpVy6bwukW+N+Qe6MSKzevhTGqzQ
	KrkCvfT99EBJo7PnQTWlZuoZkQQE05m6K3s/2q13aQ8pjYoTKZ7cFXBvi3XHGCn5cvous9b84Bh
	80umLraV44/l3iLQ0xDRjjQx4AYIxqOLV5f97ViCDvcxi7AkqNzeUbXKDlaqULL38UeAe0LaJVd
	pEZmGVLTUhemMLvkRWpsRkN1c/QfQr0gvg==
X-Received: by 2002:a05:600c:5397:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4b963c8d7ddmr76018955e9.33.1794239110309;
        Mon, 09 Nov 2026 07:45:10 -0800 (PST)
Received: from hp-z640.fritz.box ([51.37.204.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm257163645e9.5.2026.11.09.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:09 -0800 (PST)
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
Subject: [PATCH v3 4/4] riscv: dts: starfive: jh7110: Add the RTC node
Date: Mon,  9 Nov 2026 15:45:01 +0000
Message-ID: <20261109154501.63762-5-oo.hehir@gmail.com>
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

Tested on a VisionFive 2 v1.3B.

Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 82ea63f71..817898eab 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1206,6 +1206,20 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};
 
+		soc_rtc: rtc@17040000 {
+			compatible = "starfive,jh7110-rtc";
+			reg = <0x0 0x17040000 0x0 0x10000>;
+			interrupts = <10>, <11>, <12>;
+			interrupt-names = "ms-pulse", "sec-pulse", "rtc";
+			clocks = <&aoncrg JH7110_AONCLK_RTC_APB>,
+				 <&aoncrg JH7110_AONCLK_RTC_CAL>,
+				 <&aoncrg JH7110_AONCLK_RTC_32K>;
+			clock-names = "apb", "cal", "32k";
+			resets = <&aoncrg JH7110_AONRST_RTC_32K>,
+				 <&aoncrg JH7110_AONRST_RTC_APB>,
+				 <&aoncrg JH7110_AONRST_RTC_CAL>;
+		};
+
 		csi2rx: csi@19800000 {
 			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
 			reg = <0x0 0x19800000 0x0 0x10000>;
-- 
2.43.0

