Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8355BC67839
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441012081B
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441012081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLKJc6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:32:58 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:51029 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbeLKJc6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Dec 2018 04:32:58 -0500
X-IronPort-AV: E=Sophos;i="5.56,341,1539615600"; 
   d="scan'208";a="2306209"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Dec 2018 18:32:56 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 150ED458D844;
        Tue, 11 Dec 2018 18:32:53 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] nvmem: check invalid number of bytes in nvmem_{read,write}()
Date:   Tue, 11 Dec 2018 09:24:14 +0000
Message-Id: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add check in nvmem_{read,write}()to ensure that nvmem core never passes
an invalid number of bytes.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
V1-->V2
	* Moved checks from bin_attr_nvmem_{read/write} into nvmem_reg_{read,write}
	* Removed checks from nvmem_device_device_{read,write}()
V2-->V3
	* Changed the Error from "ENOSPC" to "EFBIG" on nvmem_reg_write.
---
 drivers/nvmem/core.c | 97 ++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb..dfbc8ff 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -76,19 +76,60 @@ static struct lock_class_key eeprom_lock_key;
 static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			  void *val, size_t bytes)
 {
-	if (nvmem->reg_read)
-		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
+	int rc;
+	size_t new_bytes;
+
+	/* Stop the user from reading */
+	if ((offset >= nvmem->size) || (bytes == 0))
+		return 0;
+
+	if ((nvmem->reg_read == NULL) || (bytes < nvmem->word_size))
+		return -EINVAL;
+
+	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
+		return -EOVERFLOW;
 
-	return -EINVAL;
+	if (new_bytes > nvmem->size)
+		bytes = nvmem->size - offset;
+
+	bytes = round_down(bytes, nvmem->word_size);
+	rc = nvmem->reg_read(nvmem->priv, offset, val, bytes);
+
+	if (rc)
+		return rc;
+
+	return bytes;
 }
 
 static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 			   void *val, size_t bytes)
 {
-	if (nvmem->reg_write)
-		return nvmem->reg_write(nvmem->priv, offset, val, bytes);
+	int rc;
+	size_t new_bytes;
+
+	/* Stop the user from writing */
+	if (offset >= nvmem->size)
+		return -EFBIG;
+
+	if (bytes == 0)
+		return 0;
+
+	if ((nvmem->reg_write == NULL) || (bytes < nvmem->word_size))
+		return -EINVAL;
+
+	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
+		return -EOVERFLOW;
+
+	if (new_bytes > nvmem->size)
+		bytes = nvmem->size - offset;
+
+	bytes = round_down(bytes, nvmem->word_size);
+	rc = nvmem->reg_write(nvmem->priv, offset, val, bytes);
+
+	if (rc)
+		return rc;
 
-	return -EINVAL;
+	return bytes;
 }
 
 static ssize_t type_show(struct device *dev,
@@ -111,33 +152,13 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 				    char *buf, loff_t pos, size_t count)
 {
 	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
 
 	if (attr->private)
 		dev = attr->private;
 	else
 		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from reading */
-	if (pos >= nvmem->size)
-		return 0;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	rc = nvmem_reg_read(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
 
-	return count;
+	return nvmem_reg_read(to_nvmem_device(dev), pos, buf, count);
 }
 
 static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
@@ -145,33 +166,13 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 				     char *buf, loff_t pos, size_t count)
 {
 	struct device *dev;
-	struct nvmem_device *nvmem;
-	int rc;
 
 	if (attr->private)
 		dev = attr->private;
 	else
 		dev = container_of(kobj, struct device, kobj);
-	nvmem = to_nvmem_device(dev);
-
-	/* Stop the user from writing */
-	if (pos >= nvmem->size)
-		return -EFBIG;
-
-	if (count < nvmem->word_size)
-		return -EINVAL;
-
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
-	count = round_down(count, nvmem->word_size);
-
-	rc = nvmem_reg_write(nvmem, pos, buf, count);
-
-	if (rc)
-		return rc;
 
-	return count;
+	return nvmem_reg_write(to_nvmem_device(dev), pos, buf, count);
 }
 
 /* default read/write permissions */
-- 
2.7.4

