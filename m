Return-Path: <SRS0=cDCA=SY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9627C10F11
	for <linux-rtc@archiver.kernel.org>; Mon, 22 Apr 2019 19:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A6F206A3
	for <linux-rtc@archiver.kernel.org>; Mon, 22 Apr 2019 19:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flNaOsu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDVTJD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:09:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46163 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDVTJD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 22 Apr 2019 15:09:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so9727441lfj.13
        for <linux-rtc@vger.kernel.org>; Mon, 22 Apr 2019 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VH9k6IbppSw3eg9DYZw+hb/4luBA/cH5OsTX8sYvUqg=;
        b=flNaOsu3PYWTurFoKNFomwcyJ2muSuBSGqM4z30EU2Bt6EK2pStvyRiVvPzLwo6yAo
         zEF/tnEFQv8dKBNBm5a8cl8h0aEsQiJ/fCfvTQN4iYQO6ocIRmtYmdu4KX+xOzr6QD9u
         4cyeZs8Q3Ss3GQgd1So8DiYsnFp3r8nUvxYJR/31A8xlie8/xDY0Nhs+GCImInpZpRDo
         KhFJxXGzMQPabWmkX9eVADzbS28Oe+N8uxsZ+035I0cdxZxEqgw3Gb0vIAki18ARcMPa
         e4uA2XSouCokwpoM3vagFvA76cSlSkY19RKS4z+TVZgmh1OzBvTFh7KodGY6oXVSnTAs
         xBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VH9k6IbppSw3eg9DYZw+hb/4luBA/cH5OsTX8sYvUqg=;
        b=SY5Iyw03mC6Tq4Qj57nhHfEGeDaqZmFx4hgtjEc3PE+lqAaHXb+8yErF1zMvBB9y0V
         IbA3V/ltX+2821MsvEqMIsUd2pLVVTgxeV4iMo3IzGgOE3FFUuWqgawXGz8MasNV2WQf
         /eB9hbun1u6++WOn6UZfle1niuKV9SIheHBS7/EDGhHlfiKJ7Us2OCGoOdYqL3m5JZPa
         fm5jeMzAcu8EoPLMUctPMX7COTZjHGUrBrCDpnBjxHN1OcLGXn1g1+TiUQ6BWYGLEP7L
         4WBYgOUvfK1FWf/OjzzyqGKyeIozA0/wG0QWelOUD8rsAkUCk1aFfLjm9ZsziebOHTzi
         +bkg==
X-Gm-Message-State: APjAAAUf+5ppde46q8ripUdJMsHcmoMCo2jyAyt3sHfxzHc99ojzQQgH
        EA7muhXRGBUb/7lClBdT8Ho=
X-Google-Smtp-Source: APXvYqxJB1DeyumvwO5xpTvPkrCLTIHMmN21KZyaqHo53EYXq58psYVFqGzrypJXRq8rhAJuHfsa9Q==
X-Received: by 2002:a19:986:: with SMTP id 128mr10745484lfj.120.1555960141358;
        Mon, 22 Apr 2019 12:09:01 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id d22sm3114244lfm.57.2019.04.22.12.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:09:00 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: Epson RX-6610: declare missing of table
Date:   Mon, 22 Apr 2019 21:08:52 +0200
Message-Id: <1555960132-8569-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/rtc/rtc-rx6110.ko | grep alias
alias:          spi:rx6110

After this patch:
modinfo drivers/rtc/rtc-rx6110.ko | grep alias
alias:          spi:rx6110
alias:          of:N*T*Cepson,rx6110C*
alias:          of:N*T*Cepson,rx6110

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/rtc/rtc-rx6110.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 5899ca3..71e20a6 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -21,6 +21,8 @@
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 /* RX-6110 Register definitions */
@@ -379,9 +381,16 @@ static const struct spi_device_id rx6110_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, rx6110_id);
 
+static const struct of_device_id rx6110_spi_of_match[] = {
+	{ .compatible = "epson,rx6110" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rx6110_spi_of_match);
+
 static struct spi_driver rx6110_driver = {
 	.driver = {
 		.name = RX6110_DRIVER_NAME,
+		.of_match_table = of_match_ptr(rx6110_spi_of_match),
 	},
 	.probe		= rx6110_probe,
 	.remove		= rx6110_remove,
-- 
2.7.4

