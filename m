Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859805;
	b=wONgbSW9VtURlQoS1QFRvnW32FLkbs1kALwfAEamaMnYuW2fzRNBPlap+AK4fBPNvwvT
	 CRFteKrwgXBA7FNFmeQqbJ6JOWJA4hhU3dMmF0USL7A3ahd4LyMGJT29O7N6VWUoLwZoQ
	 toxGwyhJgF+X7Csq23xU84SdgUrOUOJLjLCFEpkQO3UTVWRCyrUBBtXSerdtvpbRxxO1r
	 ReHGpPbgdce2JSR6EUUCCO8bQS7laROhdLlISlpkQqD7SthnoJFBhuP5qlUaDJdiq6svD
	 kF+ERfRgm1jNGnoGP6GqDHieO8unilmPjw1osPRw94/zwYb7oit1CIQcEG7hj/cp9Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859805;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=S60cZbyK9HGaK3s93mo0tQxG0ITRxxHJ4dgWHxHq4Gk=;
	b=5ICbGyihLODbOEtp4wT3e3hnG5K6cL/AH4tG4MqOi/zbb4d5d0sn0Ipf3YCOq50BRo/G
	 V1losBg3wvFJ2xlKInPuWYoslbXrd7FFJfD1McIc3TJ0Mx5hxmxlP++JPx/B1Xcy98kMa
	 NFlyQ/I5DC0DIHgj8gEZeX4pIuSf6W8+UIC1/F6rqptbHF8OZE4k4hGS32jNCXMU3XcEP
	 f3B42EoUy48f/w1BQnQVhch19KtHHO4xeLljrUv1tZb8/uw7byzwKmOOOjviEupjFPjNK
	 /cXB+xAQaRU5nj08O2xKfhWUS9BNgWwYdXOZOPcfTDWrk13Kkc2hxCiZsa6MrhaZFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=KiBrWL80;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39486606A31C;
	Sat, 28 Nov 2026 09:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39486606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=KiBrWL80
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655966b0;
	Sat, 28 Nov 2026 17:56:39 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: paul@crapouillou.net,
	alexandre.belloni@bootlin.com,
	maarten@treewalker.org
Cc: linux-mips@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2] rtc: jz4740: Register the power-off handler with devres
Date: Sat, 28 Nov 2026 17:56:38 +0800
Message-Id: <20261128095638.840312-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa22195dbf103a2kunm6fb6b2a93c934a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBgfVk5NHR9NSB1PSENIGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=KiBrWL807U3Me2eXIvUrrBh0eWpf2k9ggwOFEAkKt5MBGSCo+CFl3x+lLCLfV2o3Q2Fw9n+TrX040wMXswLNFNEBGfWx4j+Y/WNJprfwqfLcEBOhkZCo9zYygAeRANjmz/BDxZZkRP43PJs0umWlLJ4zaVGWzBkUKLWG6W5VY4c=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=S60cZbyK9HGaK3s93mo0tQxG0ITRxxHJ4dgWHxHq4Gk=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

A clock registration failure or driver removal leaves the power-off
callback pointing at the old RTC. Register a managed handler with
the device as its callback argument.

This issue was found by our static analysis tool under development.

Fixes: f9eb69d1ae2f ("rtc: jz4740: Add support for acting as the system power controller")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
v2:
  - Return notifier_from_errno(-EIO) if kernel_halt() returns, as
    suggested by Paul Cercueil.

 drivers/rtc/rtc-jz4740.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 32c331f3feb3..825dc035de2e 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -68,7 +68,6 @@ struct jz4740_rtc {
 	spinlock_t lock;
 };
 
-static struct device *dev_for_power_off;
 
 static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 {
@@ -253,10 +252,12 @@ static void jz4740_rtc_poweroff(struct device *dev)
 	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
 }
 
-static void jz4740_rtc_power_off(void)
+static int jz4740_rtc_power_off(struct sys_off_data *data)
 {
-	jz4740_rtc_poweroff(dev_for_power_off);
+	jz4740_rtc_poweroff(data->dev);
 	kernel_halt();
+
+	return notifier_from_errno(-EIO);
 }
 
 static const struct of_device_id jz4740_rtc_of_match[] = {
@@ -396,15 +397,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request rtc irq\n");
 
-	if (of_device_is_system_power_controller(np)) {
-		dev_for_power_off = dev;
-
-		if (!pm_power_off)
-			pm_power_off = jz4740_rtc_power_off;
-		else
-			dev_warn(dev, "Poweroff handler already present!\n");
-	}
-
 	if (device_property_present(dev, "#clock-cells")) {
 		rtc->clk32k.init = CLK_HW_INIT_HW("clk32k", __clk_get_hw(clk),
 						  &jz4740_rtc_clk32k_ops, 0);
@@ -421,6 +413,12 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 					     "Unable to register clk32k clock provider\n");
 	}
 
+	if (of_device_is_system_power_controller(np)) {
+		ret = devm_register_power_off_handler(dev, jz4740_rtc_power_off, NULL);
+		if (ret)
+			dev_warn(dev, "Failed to register power-off handler: %d\n", ret);
+	}
+
 	return 0;
 }
 

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

