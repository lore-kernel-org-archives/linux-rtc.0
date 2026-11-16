Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794788712;
	b=QqVMCWbPRONVls4rfUV2Fso4q7P2xszRwGsN2dq9bFVqBQ9U3x8dAQkfo3K2e1DDz3YT
	 gYLxrslM3jVyqbGlnEbYKStjzu/hEfYuhUlUaMVcGDI/OuRnp9YdVXxFcxwT0RyY/Bs1Y
	 BDpX5ccwvRVSEpQCKqbJTAuVBSynLNYQmJY8lw/f4xNRKhYiEm64aJz3yG4/z22fPdUFM
	 eVhUkVWM+bfrOek/37xa4c2+4dv6SOpFpfU7gXx4d71WdcrAiaDCXcHLwmdzMCRahk9zb
	 1x53DXnDsqfQ9hyGiWMiyz6BpDmOJmmWIDqSGcY3dDR+6o6vLlVUyIyvt6oTF9+jntA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788712;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rN4cMpn+dGFY/D0k2zrm6mGpwThTnjUdy+IRo6dkmr0=;
	b=ng3WdQavx51RJ4ifFMbhBrYTCIqBFI/lFsOla/k4j7LDOvxjPGSoJR9vz5SA/eapKe/z
	 OlGdQ1Dd4d89iCIlQUV25/UsYfl/xDCbDTV0Yf1TszZ4Y0GOl9avz1extsFMzpZ6zmgoo
	 ODJOXGW8JlrepiYomI/uY1kwBAq6Fct2w5SSKEN3NBaNS6YoWVUq7+mP2yXrfpBxRmi7d
	 oxbo1HqFIvjByM5Xzj6DLI/aTiHH/570cfh2TwhvQ4LQ8K+ebNswh7yVwZv8plwzcVusu
	 +SpzbsbpKFCgEXy+30KKxzjjjbfKPYc1mMRQHG3xrcMDbxGeKdSyBvVMs3E75AwZluQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi8WvlPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A02606A8BB;
	Mon, 16 Nov 2026 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi8WvlPh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794788712;
	b=bJshNUcXnlESU0SZUfBNlChtocKK0yPPrOEi6bJpfNZbnmlyQmXs91YwkjLR1ZCI4GVC
	 H0mIpSc/U56kWaDncT8Xncczv1cfsXp70ZtaZpm/OAlc5LwhIBNIzUawVCq0ZYhVH0lmJ
	 hCu+yoCs66CZ2Xo1s0ZXBRYfKXzPwc4BPmT7cQYJfyh3o6FgEdkm5pZScrDWgCF40zdrr
	 UMhydlvVgGEBOzTm0mOM1AfIpa6hgAoYZd2XXNZ9EbqKGUw5Ct8UNKYgvyXH68Lsx4DqA
	 brAcHR4VyeMKDGugjjRKLLi0QU6ipqMICcAXRic+aDyr1Q5Aa0JePNy73CYc29/Pc+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788712;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rN4cMpn+dGFY/D0k2zrm6mGpwThTnjUdy+IRo6dkmr0=;
	b=Oeibea7X/CrPBPD2hebca+geAAJjGXVcLa7dDxllrhRLBAU7NhVJ6o9cKlz71ssZsfKd
	 GmD+Ljgrz6quaDX7buyZdgrp6vvs+uqe8FKBCBAC3CWU0sBpvo42ypiQmPC1GaHJz5q4P
	 M0VmzxXomA4vBulRuxQXe4F0kNn83k4AF6TXxEFI5wEfB0lj3UYFtgjJXEukqBGa4iDfi
	 +mjmGHTZf0pRKik0vw+UwSqaPgMKZC6xW1e14hB36nfMsNooB23bX4V0oMZdKB3stouek
	 ORPPBoP6hAUYn7wJBYiHZJCp6OA8Z6orW2ZRn9VcglVWUgi0rKDfDpZc00LogBS0inA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EDF51F000C5;
	Mon, 16 Nov 2026 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788712;
	bh=rN4cMpn+dGFY/D0k2zrm6mGpwThTnjUdy+IRo6dkmr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Oi8WvlPhNp5WPEQXiBLI5NYlVjl2sZc6eJ5fEW3wystlIQfw2xDNiAG6LChBAlxuD
	 y8kXwxEj4LOeO1cvIyXhqH3mIgb7YdYeUNyNFML4gmWY1JIvAZTdWc5pz+SVfSkrzJ
	 BaE4+CGlnMp4cedk9f+10W1nZT+6iFUOpweKJytQ7M8dSImEfb9qmlFpaWj4N6s5nB
	 zQRpRVyhl5tukiHlnRQpa30Jf1lhF1NZkkFhXUZgxsv8+XjtLdXhah4FnsU0uhVFpC
	 H6zViN4cYzQbW1f0pEHTA5r/8GzcXQVy0WHWuvId5/qx6ZMdg1Gepvy93eaD7qWoOj
	 +K1onM8NBtkUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 443CB4A2AB;
	Mon, 16 Nov 2026 00:25:09 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:25:06 +0000
Subject: [PATCH v2 7/8] alarmtimer: Read the wakeup states of an RTC from
 linux,wakeup-states
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
Message-Id: <20261116-b4-alarmtimer-rtc-priority-v2-7-b2c69721e489@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=IOw/r59ERV9A/KJ7cZ9947oIWoc0hzz3hvG1MIMYEA4=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fJOu52+V3Kv87MBnj7jEZ45F9nEb59hNeHe2pCP35
 vxz53TEO0pZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE1sxhZJhW/2+DlQt7upzN
 tadPLb8xBwS82vhn6mY+dWuv9rZ52r8Y/lfZ/nPsFH3P7rpnpUjtr67VX10aOvRf57jd4r1zl2O
 jNgcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

Every RTC is taken to wake the system from all suspend states, so the
first RTC with an alarm and a wakeup capable parent takes all of them.

Take the suspend states listed in the linux,wakeup-states property of the
RTC's parent instead, all of them without the property. An RTC with
"none" is not used.

On ODROID-HC4 this lets the pcf8563 wake the board from s2idle and
meson-vrtc from deep sleep.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 kernel/time/alarmtimer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4153cce182a4..0770f4b0ca86 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/time_namespace.h>
 
@@ -111,10 +112,21 @@ static void alarmtimer_link_state(int state, struct device *dev)
 		dev_warn(&wakeup_ctl.pdev->dev, "Cannot link %s to %s\n", name, dev_name(dev));
 }
 
-/* Suspend states from which an alarm of the RTC on @dev wakes the system */
+/* Suspend states from linux,wakeup-states, all of them without the property */
 static unsigned long alarmtimer_wakeup_states(struct device *dev)
 {
-	return ALARMTIMER_STATES_ALL;
+	unsigned long states = 0;
+	int state;
+
+	if (!device_property_present(dev, "linux,wakeup-states"))
+		return ALARMTIMER_STATES_ALL;
+
+	for (state = ALARMTIMER_STATE_MIN; state < ALARMTIMER_STATE_MAX; state++) {
+		if (device_property_match_string(dev, "linux,wakeup-states",
+						 alarmtimer_state_names[state]) >= 0)
+			states |= BIT(state);
+	}
+	return states;
 }
 
 static int alarmtimer_rtc_add_device(struct device *dev)

-- 
2.43.0


