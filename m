Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794946386;
	b=BeFJJzjwae8hPMLW6ndwDf46RXHu50NzbECCQty8I8MBikonptlJhV1+dqrwyG/BKHvx
	 lt6htLaLn6a1aKittyKgHvjeutOf73tu1zG5S11rSOiztuPuLCWqMxUVl+0s/2BsXOUFE
	 9o/PQ8OgPF6J0xbB4WlGct2j5P7YvzGy9CINjv8NTykqlW8QTNi+uqgnxeoqy/h5DY0oI
	 M68mHI9ObpkV+MMmqRO4J9Xjsa9rTWHE0yMyRkI3tSEWYV34tomSDang5sN5IalLUi3yb
	 9eCXH6YPkzu0Rl62pCzzLcWGvUo0XV2IofI/BP41woyzKXWlxrPc2Am+D3UX6rB0Qqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946386;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U1zAc4lGwOD81/4mD5AHdHewiPUIO3rCF6SmQhWg03k=;
	b=gtzbc+C3T80ML7+u43d29BTTnRhgO2NgZ6R4BHKYbbmc9zzRCg6RaHYzly1/PRi9zPZ6
	 K23euD+fowaucMBhbVNTAFu6/NwbjVeOwXwcMHfMAVKm1QO8KjMY6nEC3HHCKY8oVHay3
	 EOIGqk41XSVZkTQxyUwNxNFLLcNE3QVobjikfbMpjwJoCCbDGj/G0n6SKP13YIkwUoyei
	 CYcpg6bnXC8PIxXEZlBHKyptOTM3eqL8qJ50Wco2yWo/0Qr8elGWii/mLlckDooapl9z6
	 G4LyXypZy+okynkx3yHIRl0HP8+U6BB3/KJNqoPelF7j6jxRKXz2ExbzbxZ6bk9CLlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P9/AQEwM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90749606A31C;
	Tue, 17 Nov 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9/AQEwM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794946386;
	b=sHPmjReHDcmP4sUGexlJZk5ELlY0xWR3ozvT1lzsE3wKblV815v91bCOp56N4PJ0GnJK
	 ec8XYsy204IrGPAxxHnRyH8t+j7REQmP5qdGEZ/XmqSxr9myqNzx7sLkAb+kEx0ZIX17L
	 4FSp/BTTs0Wzc64Ljxn/NSZlOpaYWJ3rwXSRHpfQpzvCVQluZXYfSWopFz79CZiKEqywY
	 FSYb6+AXqVWYnBf64uzPxy76OYxK9So+vVw8a/UYwvjRU9wwcWzb8IrQiUh/r5B1r0RzZ
	 RTztFPrJ26QUwUb/HLaRf4lij8GbZaWy7B6ud6FOp1Uk1EzUZ/b+sVBadQdDsPJql4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794946386;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=U1zAc4lGwOD81/4mD5AHdHewiPUIO3rCF6SmQhWg03k=;
	b=B/+5NSOsn64gyC/zXDOb4juMCu4dp9/mENcr2HcSxV4Dgci1rgBWKcUKe5nacZjVTHFe
	 yK9NRqzk9ObL4ASuirqo18sP7rYD/VK0/IC/tpPcPFLBOZvgACGU1pEaGxMdt/eaVBLX1
	 xdg/1FUzqd17KiL3TW1WlXIbWhkQTIyhA34lI9TLL7QOky8wo5q8124p+guJPZzfCieER
	 0E8/SYCZ77yp9cwnPD0qcIr3V7XzysqDGMnRhYFJ0oQ+F8HS0V4WWCpFy2pjaA1HLPEZA
	 q5QG1QglcWE3DoyNi0Z+QFdYZ5EjcHrtrcEX4apOK9HfxMX1G6ieXZWe0O7JEIUvZaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F3D441F000C5;
	Tue, 17 Nov 2026 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946386;
	bh=U1zAc4lGwOD81/4mD5AHdHewiPUIO3rCF6SmQhWg03k=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=P9/AQEwMo7mPnpzkHhyqxkd2+HG2qoz+1fN6+ObkX/uawWvneNV0Z1kcIpXXCBqJ4
	 Olj6FSLTqrU9LD66qxwpYFUtggghwnkgL2bi7MsYHGoudpiQZ09RgoA+VsE+I6fN8l
	 4gi7U2jPwRIB/INUanwrMbIijJ0APbD8D7ojMtSHyxvBziOKRJHzxKj9irEfjnEDsj
	 4nEh6Q1D/lmWXSqd/taDyrpot7p5vvk8WMQPNERevloVgCfa5W2FD66ueuP3jzHO7S
	 HynWqfp8eoqJwjFqOpQgNbgC+r0Sh0uwe/k7MbcG5YQoc+0fC2ttxzw6zmtqTgaW8z
	 BWLzFT1bQqQLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 85DB14AAA2;
	Tue, 17 Nov 2026 20:13:05 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 17 Nov 2026 20:13:03 +0000
Subject: [PATCH] rtc: meson-vrtc: keep the alarm across the hibernation
 snapshot
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
Message-Id: <20261117-meson-vrtc-thaw-v1-1-b58a2c3919d3@iav.lv>
X-B4-Tracking: v=1; b=H4sIAE61/GoC/x3MQQqAIBBA0avIrBtwggq7SrQQm2oWaahUEN49a
 fkW/7+QOAonGNULkS9JEnwFNQrcbv3GKEs1tLrtiWjAg1PweMXsMO/2Rm2sJmecsR1Drc7Iqzz
 /cZpL+QDTRidsYQAAAA==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=SA/YHiFrtpyx141R9I9mj/voNyRERhsuFPxCUy/+Hlc=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFl/tgYcyVxedunn3MdR+1ew5Nh862Dv8X7Ju+ZICfexS
 VzicnzXOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE8v8zMhzPfWsf7n1ry6d1
 ezY5iXmqHVh4vPzG7tIdus/2Lr1Ue1qOkeHZR7Vi5yjlZvUzcnXHOtvCf0fedb+mPf3kttJivUX
 np7ECAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

SIMPLE_DEV_PM_OPS also installs meson_vrtc_resume() as the .thaw
callback, so the alarm is cleared as soon as the hibernation image has
been created. An alarm set through the RTC (rtcwake, wakealarm) is then
lost: with hybrid-sleep the system suspends with a zero wakeup time in
the SCP and does not wake on it. The alarmtimer is not affected, as it
sets the alarm again from its own suspend callback.

Set only the suspend/resume and poweroff/restore callbacks, so freeze
and thaw leave the alarm alone.

Tested on ODROID-HC4 with v7.4-rc3, rtcwake -m no before hybrid-sleep:
BL301 printed alarm=0S before this change and the remaining time with
it, and woke the board on the alarm 3 of 3 times. Waking needs a BL301
that acts on this alarm; the stock one for HC4 does not. Deep suspend
still wakes on the alarm.

Fixes: 6ef35398e827 ("rtc: Add Amlogic Virtual Wake RTC")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/rtc/rtc-meson-vrtc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index e5f9f05ffee0..f34a98defee6 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -86,7 +86,7 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc);
 }
 
-static int __maybe_unused meson_vrtc_suspend(struct device *dev)
+static int meson_vrtc_suspend(struct device *dev)
 {
 	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
 
@@ -115,7 +115,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused meson_vrtc_resume(struct device *dev)
+static int meson_vrtc_resume(struct device *dev)
 {
 	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
 
@@ -126,8 +126,12 @@ static int __maybe_unused meson_vrtc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(meson_vrtc_pm_ops,
-			 meson_vrtc_suspend, meson_vrtc_resume);
+static const struct dev_pm_ops meson_vrtc_pm_ops = {
+	.suspend = pm_sleep_ptr(meson_vrtc_suspend),
+	.resume = pm_sleep_ptr(meson_vrtc_resume),
+	.poweroff = pm_sleep_ptr(meson_vrtc_suspend),
+	.restore = pm_sleep_ptr(meson_vrtc_resume),
+};
 
 static const struct of_device_id meson_vrtc_dt_match[] = {
 	{ .compatible = "amlogic,meson-vrtc"},

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261117-meson-vrtc-thaw-09a01c9c9a5e

Best regards,
-- 
Igor Velkov <iav@iav.lv>


