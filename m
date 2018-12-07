Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5630C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E7D20837
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 17:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E7D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGRlA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:41:00 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:55509 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGRlA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 12:41:00 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43BKWY2nJZz1r5S5;
        Fri,  7 Dec 2018 18:40:57 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43BKWY1b9rz1qtfK;
        Fri,  7 Dec 2018 18:40:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 56XL3GWlET6w; Fri,  7 Dec 2018 18:40:56 +0100 (CET)
X-Auth-Info: eGzk/pvVercL/KpILjp/uJNG6xBDMexWNp9F4ZB+jkM=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  7 Dec 2018 18:40:56 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-rtc@vger.kernel.org
Cc:     alexandre.belloni@bootlin.com, Marek Vasut <marex@denx.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: abx80x: Implement RTC_VL_READ,CLR ioctls
Date:   Fri,  7 Dec 2018 18:40:53 +0100
Message-Id: <20181207174053.10669-1-marex@denx.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Implement standard ioctls for polling the battery status and clearing
the battery low indication from userspace.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index d8e94edcb0ba9..4d24f7288ad76 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -38,6 +38,7 @@
 
 #define ABX8XX_REG_STATUS	0x0f
 #define ABX8XX_STATUS_AF	BIT(2)
+#define ABX8XX_STATUS_BLF	BIT(4)
 #define ABX8XX_STATUS_WDT	BIT(6)
 
 #define ABX8XX_REG_CTRL1	0x10
@@ -507,12 +508,49 @@ static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return err;
 }
 
+static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int status, tmp;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
+		if (status < 0)
+			return status;
+
+		tmp = !!(status & ABX8XX_STATUS_BLF);
+
+		if (copy_to_user((void __user *)arg, &tmp, sizeof(int)))
+			return -EFAULT;
+
+		return 0;
+
+	case RTC_VL_CLR:
+		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
+		if (status < 0)
+			return status;
+
+		status &= ~ABX8XX_STATUS_BLF;
+
+		tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+		if (tmp < 0)
+			return tmp;
+
+		return 0;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rtc_class_ops abx80x_rtc_ops = {
 	.read_time	= abx80x_rtc_read_time,
 	.set_time	= abx80x_rtc_set_time,
 	.read_alarm	= abx80x_read_alarm,
 	.set_alarm	= abx80x_set_alarm,
 	.alarm_irq_enable = abx80x_alarm_irq_enable,
+	.ioctl		= abx80x_ioctl,
 };
 
 static int abx80x_dt_trickle_cfg(struct device_node *np)
-- 
2.18.0

