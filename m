Return-Path: <SRS0=qdFt=SM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815CC10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B560F20830
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 10:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pimoroni-co-uk.20150623.gappssmtp.com header.i=@pimoroni-co-uk.20150623.gappssmtp.com header.b="lM3ADqfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDJK1I (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:27:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJK1I (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 10 Apr 2019 06:27:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so2227295wrw.13
        for <linux-rtc@vger.kernel.org>; Wed, 10 Apr 2019 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pimoroni-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=xuw9CH1UEuJv2KoL2snGmR07N813xLW1PGbgsl7wo5k=;
        b=lM3ADqfVJO44T9VUXy66XXcwSqz9bhXn+aGJB/3Dvb6JNTKGC6KXfNGRaOByzca6W0
         4qX84Yky7btuVAkSwj9UtesnXlbH306U/cLMRMFdQbjV7gvsUFDrb0HQaj+fZWxch+V4
         jU/TogzUgkyygKqI6DiIFvrhbyhmi5FYuevUzagWUP6Y9VEUTeF9ejSkS0utBxrp12d1
         YvhYKuTIK4J0A0GI/Zb4gjNOz+Fle6buYVnuB3eTu4Y1np9G4fV/zf8A4MWWk7q9pEQl
         A9JqJO1KvPnAl+4q9X2geIa3Vexhk1nNrsTMx9l7PXQljyWdZ1WJ82t+tWw3mI7b50sQ
         peyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xuw9CH1UEuJv2KoL2snGmR07N813xLW1PGbgsl7wo5k=;
        b=pCQ9k1cW1KXuUdgcHF3nJ2NQjalliIoKzP5biPzIDwWEDaNk2HlEDpoP+T7kf4U5Ct
         Swobn9AIUT9ncvWMr/bz9yDWCkdboFWQBiuqSjKhN5BQUmZ1PkR6Ac5FYzj/r8hU5HIC
         iXv5XbnKRag5bUOHlyVnOJspdTNBLPZ3SAP6g0BbVm307RZ4bNAEol6wioFhIGwJ5KmD
         PP8BPtpl6SBb0dJ/3HrR5YGgdpI7gliHa7kf2tLRVhSByUekGG9UMMP2g5WKEPyn0hTg
         HaIgmatzduj6eOnMYw9h5sLdEdM9cwmQ6nneFKLhnMrrX9d0uR0V894DctiiUVvJ80jx
         aYAw==
X-Gm-Message-State: APjAAAUBgSwF+DvhoLN98v3id597yvvJKyFnNI7Qu59FUcb+JjxDZpE9
        pmjU0YU2isCWJtsKuKZoEImDFsjEgqAreN1Pb0tz2vrP2+w=
X-Google-Smtp-Source: APXvYqydJcHCXIqs+64pMHRyZWe9Jxexfg/yP8viNfpjRrHi9lEump9wH14HgHeJQHg4QENAtpXhtGeS8I5dlgD3IF0=
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr6323288wrw.156.1554892026106;
 Wed, 10 Apr 2019 03:27:06 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Howard <phil@pimoroni.co.uk>
Date:   Wed, 10 Apr 2019 11:26:58 +0100
Message-ID: <CAGk-eV5UPsJGvmovyz5maEHuEDN3374hzxSptsXxghu3KRO6QQ@mail.gmail.com>
Subject: rtc: rv3028: Add backup switchover mode support
To:     linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Adds support for the backup switchover mode register in the rv3028
RTC. This allows the clock to automatically switch over to a backup
power supply when the main power supply is lost.

From 7ee04005288f0543debe46ed918b77374ad63adf Mon Sep 17 00:00:00 2001
From: Phil Howard <phil@gadgetoid.com>
Date: Fri, 29 Mar 2019 10:53:14 +0000
Subject: [PATCH 1/3] rtc: rv3028: Add backup switchover mode support

Signed-off-by: Phil Howard <phil@pimoroni.com>
---
 drivers/rtc/rtc-rv3028.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d04c2d4816555..b69d8e6408aae 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -74,6 +74,7 @@

 #define RV3028_BACKUP_TCE        BIT(5)
 #define RV3028_BACKUP_TCR_MASK        GENMASK(1,0)
+#define RV3028_BACKUP_BSM_MASK        0x0C

 #define OFFSET_STEP_PPT            953674

@@ -601,6 +602,7 @@ static int rv3028_probe(struct i2c_client *client)
     struct rv3028_data *rv3028;
     int ret, status;
     u32 ohms;
+    u8 bsm;
     struct nvmem_config nvmem_cfg = {
         .name = "rv3028_nvram",
         .word_size = 1,
@@ -671,6 +673,21 @@ static int rv3028_probe(struct i2c_client *client)
     if (ret)
         return ret;

+    /* setup backup switchover mode */
+    if (!device_property_read_u8(&client->dev, "backup-switchover-mode",
+                     &bsm))  {
+        if (bsm <= 3) {
+            ret = regmap_update_bits(rv3028->regmap, RV3028_BACKUP,
+                RV3028_BACKUP_BSM_MASK,
+                (bsm & 0x03) << 2);
+
+            if (ret)
+                return ret;
+        } else {
+            dev_warn(&client->dev, "invalid backup switchover mode value\n");
+        }
+    }
+
     /* setup trickle charger */
     if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
                       &ohms)) {

From ae9228b10d864368b934839156b6d9fa58fb5724 Mon Sep 17 00:00:00 2001
From: Phil Howard <phil@gadgetoid.com>
Date: Fri, 29 Mar 2019 10:57:07 +0000
Subject: [PATCH 2/3] dt-bindings: rv3028 backup switchover support

Signed-off-by: Phil Howard <phil@pimoroni.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt
b/Documentation/devicetree/bindings/rtc/rtc.txt
index 3e6a215e7304b..33fcad8754ec2 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -26,6 +26,7 @@ below.
 - trickle-diode-disable :   Do not use internal trickle charger diode Should be
                             given if internal trickle charger diode should be
                             disabled
+- backup-switchover-mode :  Configure RTC backup power supply switch behaviour
 - wakeup-source :           Enables wake up of host system on alarm
 - quartz-load-femtofarads : The capacitive load of the quartz(x-tal),
                             expressed in femto Farad (fF).



-- 
--
Philip Howard
Maker, Pimoroni Ltd.

phil@pimoroni.com
http://pimoroni.com
@pimoroni
