Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779221;
	b=z227ge5o70AdjmfU3jyxwzeDSH/kwQYWoPTEeY28reUxhUe+jnwV6Tla55ZuotkmmWyF
	 YZFwOn0xlpzh1+mgsdS43V2KdfpqmnDf1LBK8kqwNqif04hygiiuvcPV65/E0bsNn/yb4
	 c8Ma0/sxu5INJllfYncnjWjm1RqZnS/tkne5TpfSAplVtQVnT+1lqgU4j+6PxL8jpSZDH
	 wI0E2KCg4rnF3k06VPtyObd5TnVKwJ+uCYhN23Dajq+F/7JIDyWhYJFD7XyUYeWioA0Vz
	 bhBFZr2eG7fuv9GVjkepVNAC2Eob8VWjB10FcmX//bkDcSq6k5EeKzEaKK7cUDZml6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779221;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=U2gohBzagSa+2Hye1CwgJ1Gb51mHXB6mqhPeT2MCDT0=;
	b=zYESafahIpIYy5JFPc4+vLjh8YYcEViJ+Je8b3M+f5Kegkp43Nqs/V0oZ7QIQpG5Cp+0
	 /cOAkjFKdiLSflMFXQC/HMU+7eNk7u9CG38tIgrszbQIMrIcWzTVEBfkbNyfO5bKJY4EJ
	 DU2O7X9IJLysnLIwYlBdJKPfTDcoc1SZ9OEd7r9EWP7qn/fUcWqiUFWKN9/vELV1G/1MQ
	 j7Wq3xoFgw6g2lbX3ZLSdxwu9KT2sZ6yTj5QVbHZHxKUenwY7TAgd5i86LkoTrhH6HN0C
	 ILGsEbjhiM6WnWQzxyeieSSnH6uBN05GCktffCPqeEYT4NFWKZpRGkt5K4bmJ25BMGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=f3+hGUml;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819D606A324;
	Fri, 27 Nov 2026 11:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9819D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=f3+hGUml
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429983a;
	Fri, 27 Nov 2026 19:33:37 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: paul@crapouillou.net,
	alexandre.belloni@bootlin.com,
	maarten@treewalker.org
Cc: linux-mips@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: jz4740: Register the power-off handler with devres
Date: Fri, 27 Nov 2026 19:33:37 +0800
Message-Id: <20261127113337.390592-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa21cc8494c03a2kunma4830320395e03
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGB9CVkJCHk5OTk0YTU8aSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=f3+hGUmlwC4O26RsiQfC/GQok1y26msxdbC1z+Cp3kXeJRRUciMbyYchyFOsNBQ4mgNtaT6UXMNQ3j+fVolG8PCN1PJH5r99nwgaVCj0GU4GmQlx7xS2zUxWPoiKauq5mAsXGWm9wOJpj30RJgz/A/cokqRlfrUxFBxT56pwSwg=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=U2gohBzagSa+2Hye1CwgJ1Gb51mHXB6mqhPeT2MCDT0=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

A clock registration failure or driver removal leaves the power-off
callback pointing at the old RTC. Register a managed handler with
the device as its callback argument.

This issue was found by our static analysis tool under development.

Fixes: f9eb69d1ae2f ("rtc: jz4740: Add support for acting as the system power controller")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/rtc/rtc-jz4740.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 32c331f3feb3..63ef067eb824 100644
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
+	return NOTIFY_DONE;
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

