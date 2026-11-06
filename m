Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987771;
	b=v7mZnmhNYtpzRI68jfCpeHzPJCBo1CxmVe1PHFk6JzfKroebBK5HBWNaTk+wY18zDa2X
	 BJ71GcMw9l2bGvhbREFwJFV+bZP1/QUn/GSzRVf9Xc2FFywOwhN9jFQlW1ZTrgEuqJ3X+
	 AwYI3n1YHJ5GbrvZ1RT7YM5lnBlmkUc8xOk6/oRyccR5c5wQtnz9DwudjV5EbIG7qKNg4
	 +25+DAuTVP/zGjNrz6lXtcThZmR1boGCrL+XELu6qH9t3pyrPAhzqWYwcpJhsZFooGbxc
	 7cMNb9VBKhxG0+oi7zWijzx5QKZx2NBeGM0PaGIEmuEBJI7CKPszwiN12DALCYSqKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
	b=0+2MdTRQZPhYrepeTwtbnpzrWcw0GA8Hm7NbC3xC4JA9yANo4ygWY5pkGWl+1F9CXm7+
	 9C2FDG43rZlXKHauIKW8b/qHfNX+SO5lfFixj2xhbrEJOjULYv9WSTOWvdPjxBYvb3a7+
	 TTu5h9BExStN8b7h1uZNwlG63jdRYroZi5MsYTTy6KrpQpsWSsJXEX0xWBzBotAfMeicG
	 adov9Qj+1jfMKgiZxRNKD5RhhTRr4wK5wol5eDDBGhlDW6mi7U4izaSRJxMT3k4/A2MJc
	 nWuvbgu88r+vq7j+oFFMVdNEP05fl8e0kPl+8xjuCCse06Up2ntPjdoRVqUA60WmL0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUH3TMPQ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2185606D803
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 17:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2185606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUH3TMPQ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490d59c3edaso681230f8f.1
        for <linux-rtc@vger.kernel.org>; Fri, 06 Nov 2026 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987769; x=1794592569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
        b=uUH3TMPQ1yqfOWZH+L4gSxy7Y4FwnccmDu+viIbWjbFBsqr2yT6Ezee+DbBKjRYoMN
         ih1K0n439/4ZxaaqUDFl5ArkGZbA3xrp2apW06jk1AP9CylzuXHb4cVlYysr0HR1m60V
         7Ef5ZG5ssw+DpmXOwrLdQTXg0A4CbtRdTbdSyHx68BF9ZVsrhcA6RWeSkvoCv+8dtjck
         UaqhfL2c9aNZoIqCPJQQDtS5//2IhVS7ANlnFLzW32EyaZJf41NtuSnmzjkEKTMWT0qJ
         6f0BhMvrrx7LrdQQFP8Oy2F1kn3/7Nq1Zd03gHEdxZkJKyj3INzYXh+8Q75IiO5uJl4j
         f7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987769; x=1794592569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3eWGx2zpAT4OXgx07lg3AYpdKyWukUrsNNsX1hEEVzo=;
        b=UxXRqjbHlamavopHcaoNNvagGgSpov8GBdZh+QqUI69Qc2WfA2OR3h2ITDgWXG9+UA
         nqcBPqOhQ2Tefg8YzIKiFnr2xIQl9V5ZKSGyq7HglctDmqPiEIXGf7O6wG3JS5VweWBD
         BRV+SQo8DzDP/LmmVlE5HeMXIJPVnRCNhWOf6obc18AH4W7d0w4AFVOV4S0FvC8XZlqp
         vHiO/fXJvpeL9MfOh6nWygP7BogZPFh10TaRYXpp3R30DjhPMja3vBt/4IO7qoGWAfWz
         5bNkRKW0AQWYWeTHbXSFh4xV+gp1RWgY1Wr18FuVxSEG9eWePGYBRJ2DGP9vTi2jMCLI
         0jTg==
X-Forwarded-Encrypted: i=1; AL+hErGc6aS0HsvqVqBSW7ihYBjYQ/PqB3AaXlesRmdUBLfnJ3Ey4wDkpeOViRwPyz21WWqJ7ExOA0O7xlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fxZipuu9dI0AIetz+iZNuXRdBmCc4mMQ2bCKqJBDRWx4dHrbF
	WRByqhUZj78Roz7+DHM0wdxZske4Iv8WCYJZOrTJn5EPNlNgsssfIjeI
X-Gm-Gg: AYBFou2PC3XkgXK2ahKqmp7baj7e3w6dTPlFU7oW7jifnZGUC7xNDeIGuXrh3pbdRny
	D0Samf5o1a+lHLmP3AJ0GfpXzUsTwUaebYw/F0qXgXseQqxlLlpWygTpurTvw+2muyLgJHXPvJS
	EhozUyFwouVWILwjyRlGuDrqhEVAHVqT/vhrKPt5D6+Jax7TJFa+GzYgnznym6/5fGsAOYO86OX
	4badsZBkmCTr+GSopseOvbR0eDsgvtxqRQd7aWbM+AAnpTWRH1Am8RewBeGexdeV2c1MkHiEUzQ
	0ZBqTEESnTf8vSbEsxQbLl6AqmkMjRi7aJ+0Djy1vChagraPBCh1JCOe88vG9RZXvVctYMWrH6M
	mx0J8mMsgyj4oKoYyo6FixYQaU5TmbHjNFVi/dNNoclNxSuvq9TAG1ub3hqEOMwzTlRsLfeJpCG
	JLk3pV+23TFqEr7Y0dGtPYE2mmAaVz284wXxHMrihca4uWNPxN5nCpOxse5hzo7Vi8iKtM9CoZK
	n4sap1NYVHCB16WmSt7L76mksKGKiASVVTZPgLYcpscj73HdxcF0ai1EiyHrx+s2igb8hL5TUxZ
	wHMM1e1VEhs2CSSXpjh1New4snQp6Uw=
X-Received: by 2002:a05:6000:2c09:b0:488:8347:a110 with SMTP id ffacd0b85a97d-492777dc1fcmr7593332f8f.7.1793987768982;
        Fri, 06 Nov 2026 09:56:08 -0800 (PST)
Received: from hp-z640.fritz.box ([64.43.161.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723283dsm4649612f8f.23.2026.11.06.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:56:08 -0800 (PST)
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
	Conor Dooley <conor@kernel.org>
Subject: [PATCH 3/3] riscv: dts: starfive: jh7110: Add the RTC node
Date: Fri,  6 Nov 2026 17:56:00 +0000
Message-ID: <20261106175600.3877614-4-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106175600.3877614-1-oo.hehir@gmail.com>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
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
index 82ea63f71..14f92b942 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1206,6 +1206,20 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};
 
+		rtc: rtc@17040000 {
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

