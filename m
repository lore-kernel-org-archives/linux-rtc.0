Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E753A8B2
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655233; cv=none; b=Ou/FFIjurwHcOQpommt/EzdHcN0herS/ggUn7pdpNMZo6ueoZ/eAo+2iA2UmWIOzwkgWqd00oG78n88UHXf1a2FV3a+7oLlxavjlDJubMTYRsvFqnMdCHuS37t9aSulzon2BjRclSHEknkQjF11S46pDjfhnHNFgqAdKhDvXxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655233; c=relaxed/simple;
	bh=yT4Adw+HYU+Hwm526vroWsA5fwFd8do9OPOt3aExbw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlzUs2MsndOH1b9965XMjbh7NfJj/Od5oMQUfGkH/lEI7c2oiCOjPU27LK8DTg6NMvejt1rMaUAxD6R2AThF2THVVDMO7Zi056VxkY5lE6LVYMUB3sza1IkIYUOQg1JqJ6hd7o8livMuheo2B9JZz0GwppejVJ6d7iFnY048XBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P2iZJTYG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P2iZJTYG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 395FCC5CD78;
	Thu, 17 Sep 2026 14:27:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6CD05FAA3;
	Thu, 17 Sep 2026 14:27:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C377511C78B65;
	Thu, 17 Sep 2026 16:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789655223; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NQIErD8RMj3c96Y2peru6EPUda/1WEEQ4CrKh42s+Ao=;
	b=P2iZJTYGnfnqJojdbtYjMw0NsX3IKbGQZwtyfwF7klzE9sejGGQuU+sMJj5CodLdxxuPyF
	TWX+uX7+XeAXIgySTKN7/T/ss7RSXNklzznuW4uhjVi6FJmUROnCAXDI9tvz9VflRr/Bhy
	AFqzDL2d9byn1moj/z+ps/8sIilM8hb2e230YS2v4uMWw5sCAk99HAy8O10ihSESZ/3fab
	YmdGqWlVwepuGJKIh88GWNWXrkHxuVMCRWbz0UdHLxs1toRqy7VGXAPLv44tC704OaWon0
	MmeNEYXNNfNNcooGuk3DXQduEQLZx2feOe61ug3DrkxRpwL8sNGC2BFS5c2eXg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] rtc: omap: remove unused argument
Date: Thu, 17 Sep 2026 16:26:53 +0200
Message-ID: <20260917142654.2576889-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

omap_rtc_power_off_program takes one argument that is never used. One call
passes the struct device of the rtc but the other one passes its parent.
To avoid confusion, stop taking any argument

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-omap.c       | 5 ++---
 drivers/soc/ti/pm33xx.c      | 2 +-
 include/linux/rtc/rtc-omap.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0f90065e352c..18492165a19f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -408,7 +408,7 @@ static struct omap_rtc *omap_rtc_power_off_rtc;
  * generates pmic_pwr_enable control, which can be used to control an external
  * PMIC.
  */
-int omap_rtc_power_off_program(struct device *dev)
+int omap_rtc_power_off_program(void)
 {
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
@@ -481,10 +481,9 @@ EXPORT_SYMBOL(omap_rtc_power_off_program);
  */
 static void omap_rtc_power_off(void)
 {
-	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
 	u32 val;
 
-	omap_rtc_power_off_program(rtc->dev.parent);
+	omap_rtc_power_off_program();
 
 	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
 	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index dc52a2197d24..82979122417d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -174,7 +174,7 @@ static struct wkup_m3_wakeup_src rtc_wake_src(void)
 
 static int am33xx_rtc_only_idle(unsigned long wfi_flags)
 {
-	omap_rtc_power_off_program(&omap_rtc->dev);
+	omap_rtc_power_off_program();
 	am33xx_do_wfi_sram(wfi_flags);
 	return 0;
 }
diff --git a/include/linux/rtc/rtc-omap.h b/include/linux/rtc/rtc-omap.h
index 9f03a329e63f..d6ec7c4daea6 100644
--- a/include/linux/rtc/rtc-omap.h
+++ b/include/linux/rtc/rtc-omap.h
@@ -3,5 +3,5 @@
 #ifndef _LINUX_RTCOMAP_H_
 #define _LINUX_RTCOMAP_H_
 
-int omap_rtc_power_off_program(struct device *dev);
+int omap_rtc_power_off_program(void);
 #endif /* _LINUX_RTCOMAP_H_ */
-- 
2.55.0

