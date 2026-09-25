Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EA3CCA19
	for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313701; cv=none; b=LjiLhRQYnUOu4pK7CzsWdyus6EIw4tToxm0tB+oGQnmtAs66epZ3Ef5uQu2z+8uNY5hzggItvNq6IDHqBnHnkA0DqJYUtuojhlpfZH7uKrnjp+BTskzt198+sqeWLIxligMsXCVbz1lExgobmBrI4N1ti4H/a2NNM5XfJefjeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313701; c=relaxed/simple;
	bh=HlsPc3LcCR71JU7/vkK6byPIaxLrsf1M8iADnRns2OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IF+aFhQ+W8YetLV4BYp94khpjm/f7zvztt0kRi3DzGskEr/eZXGaUobI17j8UOfaXKWablemkzW4ETau00EEk2GPAB8tLTvDUTZGTRDXpv3zj0a6N61fcv05iRSmNF5f0obXWIhlm58kauwH4KF7VOWZRGL1fcQVNSbNb8Ow4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDb+sWhF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDb+sWhF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd80so231264f8f.2
        for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790313698; x=1790918498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1vNpKPR8tetL0rLolzuK6mB/xx/PcBi1bh4XSysNP0=;
        b=TDb+sWhF+G/LOejrM7fnZdADCfC06pqdGS+iGt6gqXysa/rgwoQxrfo8fX7g3KFig2
         M+kKczBPdLkF47LFv9VG9Ts4cq+POnL3HlsQWpXWNqG+irQohignHQ/an4+PVCwNviJ+
         d1im0y7No3vrBG7BwAnDWKNWQVrL38ACLkVI9ioE/xq4aN+JDv8ok169ND4FYVeGHxHz
         EqivhTJPl0l8B04QASjAbm/vfYf4PZQChMTHw9q4w7YCoP7woBUM0rKuMvCqHY4tMcJH
         tbHRF6Tl8ysWy+vOI9X+tGAEoWSi9XHN2qkyJgVIvCF5EpDHPZjQE/iOMSsMR3GtntHW
         j6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790313698; x=1790918498;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1vNpKPR8tetL0rLolzuK6mB/xx/PcBi1bh4XSysNP0=;
        b=E+G8B4hAw/yUsQf6cu5bkuoLd7gP/456PL+L44OU4bHc9ao0DSh7i0qHAoy6vsiTpz
         SoRS2o7FXByN5+vX9asrOYX2E5kr28LpFXUuj72eqVVMPC78mmkLV4neMFj5IMhJCee6
         jueujD81IYxLtEo+8CpWWXSYvASypeMhp7OshIn5xGe9/y1tq1T1+iqnjgtTllSgWUPq
         jHVSjfm9kGfwpeMtwpPwHKsXRc213HUwPPIrbGre4+1n0Xjfsc1FtkWsDBjM8mgiZeK7
         9XJa34G4VfPDhRf+TTrJXAvMLhdkikmF7bjesT4X1iIFo3ez/VFGdQbFPpKd9KwitXyv
         ixow==
X-Forwarded-Encrypted: i=1; AKwUvBwjTEsWLkTdlKZoMZv4mBklIwnVL9mZ+UJX/AROfAGkiYt4wW+qj4zfQtTr85LTEJ/TdviC5HF46jI=@vger.kernel.org
X-Gm-Message-State: AFuF++kf0WbQOrPiAi6e507HH5qNJzYLqfn/NFG9+2+cgg59HPCly1TJ
	0DP0Ht4k7KqUmn6ILLUZRL2LcH1JCk29y56ABT1nn8umPwFuYiaWbSm+++Uj4lBmxbs=
X-Gm-Gg: AYBFou1FhNA0ZhSfx/ApVY7IRGDN1edppCECc6h/K2uGC8mBz9gN5u3Hd7GrkJk320D
	SYfOgV/qMbr52CNWuG3ilj13eYm/fDU3N02+T4EwbPXKrythZybVsGDPAMvLyL56O3TD16QCWsL
	aI/+iLPt3zDvSkxhz5rnD3vmq4sI+erQwR7hxUWr0D9Tkh7QQM1fFV7PRcXfiVL+/4xc5UjTVE8
	aSyn+2NS7B2WYIEmBrch27/GFse7XDycfFNzXVgiAdBAkT0r9ZbP1xorwvI0Fmw2Ikz0kIdqs7G
	MyMyO/cpbTc+rxJk1rEamBt+RoeGLMWwdDDet+UIqzXhA/xCDNV2NlKYhlCdmyza+UDHxnpX13z
	cBXnOMK6ajaTlegxnkOr5Uv/8SQG8GS8FwrbFIYJIbdc//VwbNAmbtIlbwLlVOzGgWxrobiOeMn
	MEN7dQi1guocQH0N3hZYvxns6Tfi2Ql8rk1GmPY726md0zw1UdFm0RkppCixHqyz1KP6OZxrAFt
	jAuIIizCULY5fKdc1C4wIySpE9Pv4VBygUuVM9YZzWUF/wZ23r+slUDvbwFAkf02V0+W7L65PFF
	iMYWNul43vReVnvYvdmw+/ezzXMn3MZoQA9HaR28fRqtbF/KWCwaaPjS3Pk=
X-Received: by 2002:a05:6000:29c2:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48879d6a64fmr2304968f8f.8.1790313698119;
        Thu, 24 Sep 2026 22:21:38 -0700 (PDT)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6450a3sm3699394f8f.25.2026.09.24.22.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:21:37 -0700 (PDT)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Michal Simek <michal.simek@amd.com>,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] rtc: zynqmp: Enable crystal oscillator when setting time
Date: Fri, 25 Sep 2026 07:20:15 +0200
Message-ID: <20260925052015.22019-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RTC_OSC_EN macro was defined when the driver was originally
introduced, but was never asserted by the driver. On cold boots, after
battery exhaustion, or on platforms where firmware does not configure
RTC_CTRL, the oscillator remains disabled and the counter never ticks.

Unconditionally enabling the oscillator during driver initialization
would cause the RTC to free-run from an uninitialized or stale counter
value, reporting an untrusted time to userspace. Instead, keep the
oscillator disabled until a valid time is programmed: guard
xlnx_rtc_read_time() on RTC_OSC_EN and return -EINVAL when it is not
set, and assert RTC_OSC_EN in xlnx_rtc_set_time() once valid time is
programmed so the RTC can free-run.

Per the Zynq UltraScale+ TRM (UG1085), bit 24 (OSC_CNTRL) is a static
level enable for the crystal inverter rather than an edge-triggered reset;
asserting it from set_time() is non-destructive and will not glitch an
already-running oscillator.

Tested on Zynq UltraScale+ hardware, confirming that read_time returns
-EINVAL while the oscillator is disabled, and advances reliably after
setting time.

Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
v2:
 - Leave xlnx_init_rtc() unchanged so the oscillator is not enabled on probe
 - Return -EINVAL in xlnx_rtc_read_time() when RTC_OSC_EN is not set
 - Enable RTC_OSC_EN in xlnx_rtc_set_time() once valid time is programmed

 drivers/rtc/rtc-zynqmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 5bcb7536e973..6c3ba8f1aa57 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -59,6 +59,8 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 	unsigned long new_time;
 
+	u32 rtc_ctrl;
+
 	/*
 	 * The value written will be updated after 1 sec into the
 	 * seconds read register, so we need to program time +1 sec
@@ -78,6 +80,14 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 */
 	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_STS);
 
+	/*
+	 * Now that the time is valid, start the crystal oscillator so the
+	 * RTC free-runs.
+	 */
+	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
+	rtc_ctrl |= RTC_OSC_EN;
+	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
+
 	return 0;
 }
 
@@ -87,6 +97,9 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned long read_time;
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 
+	if (!(readl(xrtcdev->reg_base + RTC_CTRL) & RTC_OSC_EN))
+		return -EINVAL;
+
 	status = readl(xrtcdev->reg_base + RTC_INT_STS);
 
 	if (status & RTC_INT_SEC) {
-- 
2.53.0

