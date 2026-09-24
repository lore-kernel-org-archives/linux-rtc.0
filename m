Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E580427FA0
	for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234519; cv=none; b=dH7V9BwcCVAKtxtS/tbMpacHm1FV/owyT5/FQ9f/gQz+8gfXffqa/nmEIc4ByPBoRCMf8yfRgOeVenQV7QMulkm8ojaOrDQ6cgMz9BqgyNiqXwH6VCfD50+eMDjMxfwfLVPZGg2m56Dcjc31wnwMfcymZGUHffKQajS4XEtDHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234519; c=relaxed/simple;
	bh=rzUGhvKXG1QedQRI9Pa8yyhEiMF19LqXarJtEqui360=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNPQf8KxuI4o/U1YePnZ6CLrDTFADn7hh2N9CDapI1NEGrA759i1ys/LLRjNfZ+XHRvWN3Tb//rTzo/iBczCDW2fFJ1O/p9nket89ePLvxbo8Qh7HUhUATmQ5xzqKLF/hlADlz+96fY7cFu1a3VvO/D0ShBu7g7CjWbWqVImqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VczU9ZMw; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VczU9ZMw"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so9518785e9.1
        for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234515; x=1790839315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDX1YWZgv2v5Sh7tItNyghYlDCdlCLpMr/PsN3YN948=;
        b=VczU9ZMwCCwSNcoDfTN3WwzIiudtBriTNrPRnW7017/HlNR/T543mjuamjkXWtDzgy
         hWATGjSGM7hiXLAzKKAr0IcM4rImS4SpLgEgQjsgkVtzHzRUvLuK3dBDZNTNCCYcgYT2
         SefZqVPNQ2QagszCuN2QNamGmNWfCxKtMlRsYPAcn9HtHJuLy+caNqeGS6XXel5PtrZQ
         zRbugh++8TK01K7JKKy3/Mhowfw4EvQHBMcHiPo0nG3EH62favhhAoJcCv5Ou8/DIVZ0
         6rXiXnohJ4L2gbDyrQNXU9ILPE/MetTjDxUQLiPxwWK+oAh+UUo/f9yrfLEuJBms+lZT
         A+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234515; x=1790839315;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDX1YWZgv2v5Sh7tItNyghYlDCdlCLpMr/PsN3YN948=;
        b=rL38I9Jit4aSikrkyzexZPrje06n8At+tnM1TrwPhxFAWMK1uGl5aOjsr0symBKnCN
         S7Iwnh1HVOQFDADFhGcL5n0AWK7s+b7jQDkGM6xw/jfbEV8Tnfqsqs2EINtmX8l2UxHY
         83KU4akeIOxOYKAsWeprmJ8qNehLDSGoWo6uH18EX7BzjGMbc8X0HW3O0oIZkwbFfLql
         0hDIJ7UXpFZi7xSUTpffJY/sIydrSfXI5RJe2swtLFr3qR1MQ2JrjklFFXvcECoO6H2u
         Qjwv206FvK8ECWhBO+jA9w3iwNW/idLO8wb8FujZeL8oDY1Gzh1rZF2JunvPb/C7Z/nB
         8xSw==
X-Forwarded-Encrypted: i=1; AKwUvByLqFqwGjODh3578rDIP/jxVax26P8BwcIAyGRSCXAFdUyJF9TWHoBUqC0yVgn/k7ohIZjwYFK7y/0=@vger.kernel.org
X-Gm-Message-State: AFuF++ltKo5GSA++YEBGmRGJxPilxZx83MvpFOu70UCqK7RPMkp98xos
	h5VHQGmwVpMZn/5L1uHGCtxTe9VhLrBEdPTQRv5imqlcwDTh0E/L01bH
X-Gm-Gg: AYBFou3nW26XDWj+U11khvxGOK9UZxM25GKXctArz3LIH5fJ87TWlfqJVBU968BivT8
	k8xobeLpj3ky2/gz1bDN3cuYaYpHf7SWLxk6qwdBffNvrKGw9RlkMzwweiyqNIPVaN+Z0I/kRfU
	VM0X54n0Rbe9IfPAXPqWdRDp84mo4uuOScMcpHsWj/10G4NG80Z69o4GHhNREdf+OHaDWUx7ASf
	sLegeYPJnmSfyJ7EtvXEspJRBrAxgPejYpZASxCgxawbSNkA+G0kfbOXvobU4IjSkvgx8y3+F4w
	bg2wqEL0ma6A3Kc95zz8FC/EzQD9Wfbu9T3rgfS59eDZ4i3ADB2O4J1ru4imfJcfF6R71bOTBTL
	p3hcj3STplo0QhDEa3P1FeNs6BuXeIyxOQBxMi1+lhlGnl74rYpE1Wyc2MC8etKCKD7svrDi5RV
	50jKbqvGtwrADPwWYpTFlfqKi3cr5sMNrCdmZ4rIiZsZroVIGCwQDM/aRxOetHn6RZgUz5kGojZ
	ruNzQh7Asa1mqcPzCZRA3W2jQQ2IpWwRfzq2F5m60AdLTK1KYuofpBlPY76FsxAh3+2d/k/BMf4
	e9dUgj4jBrnSt0w/SVhyQY1YjwWSe+N1xVI0Ku8VmLiE0plTJwkm91yCtA==
X-Received: by 2002:a05:600c:1385:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-49fe66fa5c2mr21450465e9.24.1790234514858;
        Thu, 24 Sep 2026 00:21:54 -0700 (PDT)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bb9891sm41051975e9.6.2026.09.24.00.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:21:54 -0700 (PDT)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Michal Simek <michal.simek@amd.com>,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: zynqmp: Enable crystal oscillator in initialization
Date: Thu, 24 Sep 2026 09:19:16 +0200
Message-ID: <20260924071917.80004-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the RTC crystal oscillator bit in the control register (RTC_CTRL,
offset 0x40) during driver initialization.

Although the RTC_OSC_EN macro was defined when the driver was originally
introduced, it was never asserted in xlnx_init_rtc(). On cold boots, after
battery exhaustion, or on platforms where firmware does not pre-initialize
RTC_CTRL, the oscillator remains disabled and the counter never ticks.

Asserting RTC_OSC_EN alongside RTC_BATT_EN ensures the oscillator starts
without relying on bootloader initialization. Per the Zynq UltraScale+
TRM (UG1085), bit 24 (OSC_CNTRL) is a static level enable for the crystal
inverter rather than an edge-triggered reset; re-asserting it when the
oscillator is already running is a non-destructive no-op that does not
glitch or reset the ticking counters.

Tested on Zynq UltraScale+ hardware, confirming that the counter freezes
when RTC_OSC_EN is cleared, advances reliably once enabled, and is
unaffected when re-asserted while running.

Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/rtc/rtc-zynqmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 5bcb7536e973..278705ec09f5 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -167,9 +167,12 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 {
 	u32 rtc_ctrl;
 
-	/* Enable RTC switch to battery when VCC_PSAUX is not available */
+	/*
+	 * Enable crystal oscillator, and enable RTC switch to battery
+	 * when VCC_PSAUX is not available.
+	 */
 	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
-	rtc_ctrl |= RTC_BATT_EN;
+	rtc_ctrl |= RTC_BATT_EN | RTC_OSC_EN;
 	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
 }
 
-- 
2.53.0

