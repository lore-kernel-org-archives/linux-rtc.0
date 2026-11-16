Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788712;
	b=hCn7pkdJKZF08PwxpUeSGFu7xMyUQHZJOTzrOXZxhRSHB5v4YsKFgogutisHTW8zxzw4
	 0qWl36X2CYQhZQxkLYPhry/ZxPqlw4c5ZepA5ERxmcbhzowzzL3shKMxe7qIzRuZzAcUo
	 wN4J+Mqur43grRl08P/a1dDUaaNuAqcm1U36NSLKbhVn2GrLkrZP1xAXrBuC/RN4YGFtS
	 6CFUdPnj4yc9EfQf/OzKDU8voKtGjI3my6u6H68FAvkXykWmDlID8AcM2CUuAuA8HBQfe
	 GYOrVE9cixuBFns0pDQWMY2C/pli23j3G3B3SXV0UN8yZYhlG2xW6458OUNAMhekIxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788712;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fj5JKSeJMAlyVYfoZF5xtSPea7M46yEaKVIj7hfiK34=;
	b=ql7tKFqnWMM7DCAZC0/SaTJASTiS9asZ5Gez3YbQen6hQTpZJsggSYA5iadmDw1jvp1A
	 0jZlFP0YNxf1Wq3ovU2cdSqOVhHPTIv3zXrK4LbAJGKJzIGiQX4Ds7HXm0LruSB6xxbjq
	 B7Dm1EwMLkQn4ne78nvoFaLLI5SI3gKLWhz+s3kMux17d3EhYTvjRd16c5FjXoQUxfJQl
	 pL0XXztdfVJvtOTbSi/ZV+59g6J9VLayelWr92IGP7vYIYkitSmE9aMA74WjPtj+6YRRc
	 CfJsnuTSEBBsT2rep9VwiajLuwZC3fQD5UkORa4Qlu7jR4zcvi7R+VZ1AkL9BRdVpEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fglc3hqw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4389606A899;
	Mon, 16 Nov 2026 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fglc3hqw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788711;
	b=z15b9yPL3RwOEvFXHt7Y/Q9PdLnGOWia6BGWXLpcLP0/f5z+MrpMpOSDmDbtO0T73W1p
	 VxRGMtnqQCZRPl9uAO3MTAiHtTIlWlb0djfrjeB6vJ1MRIEfKjKtoiDYNd5mxjX2u8183
	 ZFL5O8dPbgVmC5h3seWJQnPGexlaJW1ZMJR98fQtFLEGuXhzm+JO71XecmAVu9tjUScXG
	 rPQHcX5VBM6N/6g9/eGl53bhnSowEqGrFJLFapnvJNQxpEZb/4DxyJ66LXyKHLwnSPcwN
	 fTYu4N8rhekSTcByadGn5qxWggaifv44ISHCztKRQffCSsBQyicy1ctfTN5Cripi1bQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788711;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fj5JKSeJMAlyVYfoZF5xtSPea7M46yEaKVIj7hfiK34=;
	b=sB3uzS1dPitwT1YvaimK8Zs7jD3ru0sqDps8U0KVEQXgIosyTsr9Jqls6UL84PDKq+hF
	 iHZMdZz1EQ9Lu4u9/Qj5ERpSebIYzovV8fl1PAhKoW2T6YTfkUJ79LVYr6L5s1DMDnAff
	 XuEPHFUh/T2/6/S3D+oqx9KJYszglDrn53pEXhweSGoNALme38SdUbf+9Ftoc5uFY/3T8
	 pXKrxRiTBh9qFIuHcJntMnVgfHXlOtz0m5Yf30CGUUtyjckVIOIc9FHRrJdqJksgScU1o
	 KjRu6qbvxC6UzfnWeoRopFZFOBaL0juo3CdD9FsXJx8VhE5vsHpiw/f3vXZioDhrk8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 30B491F000C6;
	Mon, 16 Nov 2026 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788711;
	bh=Fj5JKSeJMAlyVYfoZF5xtSPea7M46yEaKVIj7hfiK34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fglc3hqw21xawRuSCjphQQAEhktac5GAL3B0Qq+GcCzaB3L6hPjpjfUyO/ZS0PjVx
	 RzvvtmXOlEg1SPehzAOQ9JIQzCeOU1iHA/v/SQV3lHdg4KWQPcfEw1VSwC7DhlsILH
	 7/lf7UZKsL+/++66QK5HaBQvlmmVoFl4sZvtogTmWBA10moRmSrv16Vy+XO+BfqQW2
	 zIfpbwTg/BcR8CmJKWkOnUju2y+ZS4n7uLENREoCT03jA979WjQFhM7+m5ozvaTxYd
	 Y4FogGTSX0dFvL6dvVabOwFFx1aQQwSn4b9nYWZN/CzE7NwMPTRcougyIp+cUGvyyt
	 262FybKNzkBQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A38E4A2AF;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:25:07 +0000
Subject: [PATCH v2 8/8] arm64: dts: amlogic: meson-sm1-odroid-hc4: Describe
 which RTC wakes the board
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
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-8-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=KnLlIIqoXkwEM5qIksoDafpdgl/wvWdUGl1vKeB191k=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fJN3R1f0LWlIi57vYrn7w16ulSkcvV9/cn9QcnUpM
 T22/k9MRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZjISWVGhsbZ1QIZGz4v53wr
 ctYsqTN2+dxcjsc85+fyxR1JeiW2NYLhv9/c8r1Huha838rk+vvh47pz1+8ziB5+vq7p1/P44L4
 TSXwA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

The board has two RTCs with an alarm. The pcf8563 interrupt line goes
to GPIOX_5, so once that interrupt is described [1], its alarm wakes the
board from s2idle. meson-vrtc is a register the SoC firmware reads when
the application processors suspend, so it wakes the board from deep
sleep only, and only with a BL301 that handles its alarm.

List the states per RTC, so that alarmtimer programs the pcf8563 for
s2idle and meson-vrtc for deep sleep.

Link: https://lore.kernel.org/r/20261019-hc4-rtc-alarm-irq-v1-1-078fc79e596f@iav.lv [1]
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index 5f15c2299509..0dd9cd2d8245 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -106,6 +106,7 @@ rtc: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 		wakeup-source;
+		linux,wakeup-states = "s2idle";
 	};
 };
 
@@ -142,3 +143,7 @@ &usb {
 	phys = <&usb2_phy0>, <&usb2_phy1>;
 	phy-names = "usb2-phy0", "usb2-phy1";
 };
+
+&vrtc {
+	linux,wakeup-states = "deep";
+};

-- 
2.43.0


