Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A1330B07
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151129; cv=none; b=Tgm0N1CPDvCPFtK8SmnN/3WMeOXWAi/6J9E4zpkoin6NZ+fcTpKSDKeCZulsqgv91i9JexgrRhWpyKS26Bwmav9K6RZTZTUls3NimL2f9bb7WJulP2/RrJFBn1v6KlSeYH689F3MmJBC8k2XPxkNJYr0f53PIqCWmAKE1dsyMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151129; c=relaxed/simple;
	bh=TifrLpDp7jzI8H9J5GPoqfk4/AG6Qcni0rAiGsSLeJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srw1cHSE0h2My3/t5UytgVoUJI3g3uF4SOt+1voShpgF+o0hjemRQSA4/CKP1X7VYjDBg8xm0TjOTMhWY0zrbEVPJCVAwUDAWx5llYgqcSSHYiUgCsmvq9oOc6VaDMG6NORY3LyPAA2UT8/n/Ly5jnEEbfK5ceFrJSUeguTnPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnEHFhlZ; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnEHFhlZ"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso523594a12.3
        for <linux-rtc@vger.kernel.org>; Sun, 04 Oct 2026 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791151127; x=1791755927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CkvJoLK373ln4zs4Nd5alF3ccwEdYezxl+TGr5Jtiqw=;
        b=RnEHFhlZg3xgnCQeFt1pVwu8fSDBnsNIH/GifzWNg5FxzBOuv4VqQ/UJnnZfQEgg5S
         PN8YgnEMS3rmCE7Ez2VtZtZSjGIm9sXKqkyzWBau1XnlCdYiEi1XIL2GjLPBzGHyzJw0
         CemIA++Z/s1zokI8AZOPmqfeShqOiuVGo9jDZEQ3mZkm8yO7OjUDA5m/2Wk4PsoW+AqL
         LEelRc0rAOObV89E9IF8PXWex8+L5MJ9dUMlFZtiD7XCejdHMVX/I+8LoGC1eYWH52ei
         iRX4wY4gSLptnbLDQIZ1Z/0LLFTtxEoO/oIXS0+vHvPNlo3KpkMY/t7utswHx+j2IfpH
         EbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791151127; x=1791755927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkvJoLK373ln4zs4Nd5alF3ccwEdYezxl+TGr5Jtiqw=;
        b=taPx8w/o1T6MWBCRGYVFWJfkU2m4u1ZkwJDG46jQcm8ODGE8G9bHu9ArIb3QmVSSes
         b0ccHMpijdXH1rC+m8KTo6N+sN64Ue50Du7cAoAVqZHkdW1eYWTtv6KrNXjsyCqPAmMG
         5VRwquOE0n8Qazwbkau3RaulT6O6vx1LOESuaexF0u4sWfCkX8fwM+U3FZkoge44s+Ca
         32IBiDsCYIYmYNcQ86PGHDFDRHBMmXh22BNCdgRW2+qe211zo8jleUNF2/A6/x0/8wko
         xv61Dk2wA2VWpyBZyNpwbVonsB5UQvj6g70FR81iA2nTx8/PhY5dfwRkmlWbvuAbVyvc
         o7Ow==
X-Gm-Message-State: AFq9FYLFi6MXspd5k6IqpFRSSJxO4TZg28WBS5IGCHWwc00RPypGUgIy
	sPuwYzwwwGgIZnH2pSAuXxcg3DpJFVLTE7ISaWIkrGLmxZgxMqGAHQw7rgzD0mvu
X-Gm-Gg: AYBFou0YouejWClXiqYeVe/sGqGrpu/2ibaRKJu3oJbY5zk7Bw7/XS/slA7ICMfyu6R
	12zOegIposr4x4nJxuc8Am0Aw7/rrzJAWJqK3h3gpTdCbfzw4WjIsixmGa06wubRU0T0sM3QyhD
	ce1jCVKtGzpoCh3aPFlhbJK3MhATURgrnAe9iTmMzItjliVzyxveG4pqCrwmmX1x5TEu2JNfFqE
	y0ZIUBEVT2awqofY504VhDGH9tQbyWfspIw1d4y2kr6w6+28bq+ldM8vtfQjK0SZVHtTWKh1mSk
	75dls2yn96otdpHuc4fEtkFQFjalSYxClWrzJYnIhYIScbjYHd08ACEDE/ydAzcg1qUVRUH0UEB
	C3tpyUJ4x/49nu/wIslQKgViVV6k0iEj71vuAihxwEqg4qsSZH5wKWHjYCioVP/owx/OXNMfIkw
	RDCI7xfIyXItCYYoqK3rCRtN3sT8CW4hEi+KsataCb30WFM1+FMba85F+gb8QJCBEWgi/O6F6WQ
	ScMXxa0d6MCSWk79Vj3rlXo6wpNqOJRZhcfiIqN7ZP8FPGGYjyaSEHyiwZW9ofSqVQTgqpWiQ0r
	3k04yKn4AdN0P8GqU9+IPE4dRv8U0eBKiMqTjMgilN+KTKB4
X-Received: by 2002:a17:90b:2d4c:b0:3a0:2817:1fcf with SMTP id 98e67ed59e1d1-3a6ce6ca6c8mr7611689a91.11.1791151126977;
        Sun, 04 Oct 2026 14:58:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d661ef5sm8486218a91.5.2026.10.04.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:58:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Dave Gerlach <d-gerlach@ti.com>,
	Keerthy <j-keerthy@ti.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
Subject: [PATCH] rtc: omap: fail rtc-only suspend without a power-off RTC
Date: Sun,  4 Oct 2026 14:58:43 -0700
Message-ID: <20261004215843.396867-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_rtc_power_off_program() dereferences omap_rtc_power_off_rtc
unconditionally, but that pointer is only set when an RTC with the
"system-power-controller" property probed while pm_power_off was still
free, and it is cleared again when that RTC is removed.

pm33xx uses the function for rtc-only suspend whenever off mode is
enabled and an "rtc0" class device exists, which guarantees none of
that. Without the property, with another driver owning pm_power_off,
or with a different RTC registered as rtc0, suspending to mem
dereferences NULL in the cpu_suspend() finisher.

Return -ENODEV when no power-off RTC is set up, and propagate it from
am33xx_rtc_only_idle(). A non-zero return from the finisher makes
cpu_suspend() abort, so pm33xx reports a suspend failure instead of
oopsing.

Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-omap.c  | 11 +++++++++++
 drivers/soc/ti/pm33xx.c |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 18492165a19f..540232d6f26c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -407,6 +407,9 @@ static struct omap_rtc *omap_rtc_power_off_rtc;
  * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
  * generates pmic_pwr_enable control, which can be used to control an external
  * PMIC.
+ *
+ * Return: 0 on success, or -ENODEV if no RTC was registered as the system
+ * power controller.
  */
 int omap_rtc_power_off_program(void)
 {
@@ -416,6 +419,14 @@ int omap_rtc_power_off_program(void)
 	int seconds;
 	u32 val;
 
+	/*
+	 * Only set when an RTC with "system-power-controller" took over
+	 * pm_power_off. pm33xx calls this for rtc-only suspend whenever an
+	 * rtc0 exists, which does not guarantee that.
+	 */
+	if (!rtc)
+		return -ENODEV;
+
 	rtc->type->unlock(rtc);
 	/* enable pmic_power_en control */
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 82979122417d..02ebf5a6f4b5 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -174,7 +174,13 @@ static struct wkup_m3_wakeup_src rtc_wake_src(void)
 
 static int am33xx_rtc_only_idle(unsigned long wfi_flags)
 {
-	omap_rtc_power_off_program();
+	int ret;
+
+	/* A non-zero return makes cpu_suspend() abort the suspend. */
+	ret = omap_rtc_power_off_program();
+	if (ret)
+		return ret;
+
 	am33xx_do_wfi_sram(wfi_flags);
 	return 0;
 }
-- 
2.56.0

