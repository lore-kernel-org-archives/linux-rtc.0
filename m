Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793771683;
	b=e1rbQtRa0e3M+0V0ms6noZ9kg1xRy6dy9eq7ueZDToQMyW8Gvncnh91vUioWrd8Dq37v
	 VEFS/MvIjwms9y4HpHjtS6Rh1Zp0tuhCom4bKCaIsHNhowOdD8P9ecbAW7k9hsZSzY2iA
	 jhQ7+CIKjtNcUqCCCtuVcaLmlS9QRjniP1kZtUhOYHMGRqvX2WFx9l0M7djbjH/KyeYh3
	 +wigjQicoWQg30Z18VrX+NbwfXdNL69fHvkI19QrhDzApWtnUYsJBnz7JVapo7DssaKYy
	 Bx3Dfc4p8gtW2MgXDrjTCsUb+JdWD4m3zqpQl8hs7UiMiTUsfVgB0JOFT45jz8d0pjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1FAAzk1F3U0dWRjx+bbNnt5XzEZZ95SXINPdQt5c6fc=;
	b=CM0lSgM+LnE0DaZP0uIHg5jjUv6v7iOkfiLEhHF2LAVqQOgUZoJL2DC0JjJhGVFJYIqv
	 GPHi6X93vmBXnbYbh/witYDS6+tBEblMSGp3bmc6r5VECLPhJvD/ODN8cHMRkwePcxHQM
	 5wFmK2y/R1fsKMoSMtgy7vciVcO6/jT9/cY7Q91esNm4rQN/OuntDK2ZFROwWY3WLgNM4
	 EFjlOjgup4UAaT7xAEE37OEHgc57enzFed8TrVGJBkEI+z/Q2hF3qbodVCa2Sg4RDK7gH
	 o1F9TZKdm+pnI+b/6gSOX9PUSYxoZWeipGZncggJ2dStoIP9kxPzJ10F0UCzhuv3o6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ2d6y9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64009606A328;
	Wed,  4 Nov 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ2d6y9y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793771682;
	b=eEn0CgkKYtBRwifLClqc43HfbK3kuomsnnvaT1Dp4DKPojAECybaZC5CAb+Pp7dVL0Qi
	 /hQ92jT35ogazJcxtYs4JFQeX3sjp5F/nQmhqZbtuCX9zzvJhnF3GHrqpYusQdGxJ54Gw
	 jDMz9udhhDmW5K2za8MyTRdm7Hx57PklIseHh4DAIYJUaOVUsPX80+u5CtF9qVOivIowR
	 L39+B5CxRMMDcMm0k446VrMu0JxdUpKCo0Dgj5KM27a5jfqBmTXJ1pypkp9bck6SrXsT4
	 1SFMekttZXuEdkgRNoPTKpnzLHk9N95rRkqKFJfgEdtgSCsmuiL0AjoQ2Q3w7kXXllQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793771682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1FAAzk1F3U0dWRjx+bbNnt5XzEZZ95SXINPdQt5c6fc=;
	b=GwbxZi0UmRkiRboMPT8km7qje0au2LY0K2+TS/NAOMCxLfjvCkeZ2h00VhJBcOxc6SRN
	 iuUibXT3YgM3D6bP5sm0cv1fYPA/pFrSVI1pvUYVt85uM+p6CDsr9Aox8oorWWrIoyA5C
	 NmkIS0I/F9LrY3kSqmvCCAVjLorabzUQ+SGntqZdBUEri9C3EXDT09Pp2vclsIeeRvAl3
	 bj0krtYADR2EvxY3SYwXN0+4iVY8pskX5dFVIHRkSBmhWcgkl8zkghBiDLArfk1ddx8el
	 ywMCQjBpv/jOdx+YuZcE6cDvcz4g8SffcM6YCvaWVeTh7DZjfTCb4zdBdVB+ux1ELVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 61F0B1F00A02;
	Wed,  4 Nov 2026 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771682;
	bh=1FAAzk1F3U0dWRjx+bbNnt5XzEZZ95SXINPdQt5c6fc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WJ2d6y9yLhOaKfuEqArN6bHOZlXp92EcfAOrkJgce+KUB3LHt3vrO8BOhdImo9ffm
	 8p81Q7a5BlJiGPTdmnRLPeVCZIJ5oa11gxwo4vQRh6z8h/wF7+937F/a1PL48rJF53
	 Y2KgovR2fkavbwrRaGyfsmb44i7MmJX/MSHWP6/ugfRLiCzvD43ptM1HJzpSsoqSpz
	 0B+b3Kv7lorV3vl3Z3aPPdrBwt0J2szFM0h546AtPq4YiVsfCH3Bs81osd4GcmVEGp
	 52cDvYRvBWXoVe8yLthXnXFddu0GBOz0jXyaeyK8YrLKkWO5/heinDhzGrwRD0d7XG
	 Dzdhmw0PRcHzA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E38B746CA7;
	Wed,  4 Nov 2026 05:54:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 04 Nov 2026 05:54:39 +0000
Subject: [PATCH RFC 3/3] arm64: dts: amlogic: meson-sm1-odroid-hc4:
 Describe which RTC wakes the board
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
Message-Id: <20261104-b4-alarmtimer-rtc-priority-v1-3-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=mClFISqM3EXGiotFJ5We6p4d5yRWASHPRbsQrzuZFOs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmvTsx/0t9Y1JBm47ouRblE/XLWtge6bdG3Losv+Wh4L
 pJL8zNrRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZhIZgTD/8ignF9Lcg6ff/Tn
 uLWIQK3C5sgd/0+fVFv3eVPx2Z8LFr9mZJg6pzb9+qJk69ZdWuLpSS9anldfmTjZ56rb5sZdl+2
 OL+cFAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

The board has two RTCs with an alarm. The pcf8563 interrupt line goes
to GPIOX_5, so once that interrupt is described [1], its alarm wakes the
board from s2idle but not from deep sleep. meson-vrtc is a register the
SoC firmware reads when the application processors suspend, so it wakes
the board from deep sleep only, and only with a BL301 that handles its
alarm.

List the states per RTC, so that alarmtimer programs the pcf8563 for
s2idle and meson-vrtc for deep sleep.

Link: https://lore.kernel.org/r/20261020-hc4-rtc-alarm-irq-v1-1-b2b8c68d54f5@iav.lv [1]
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index 3ece30a0a1ff..935dd31572cb 100644
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


