Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E743C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1120892
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D1120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLGLg2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:36:28 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:5386 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbeLGLg2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 06:36:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539615600"; 
   d="scan'208";a="2022461"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2018 20:36:26 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E99434045600;
        Fri,  7 Dec 2018 20:36:23 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 1/5] nvmem: check invalid number of bytes in nvmem_device_{read,write}
Date:   Fri,  7 Dec 2018 11:27:42 +0000
Message-Id: <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add check in nvmem_device_{read,write}()to ensure that nvmem core never
passes an invalid number of bytes.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
V3-->V4
	* New patch.
---
 drivers/nvmem/core.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d9fd110..db7de33 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1433,10 +1433,21 @@ int nvmem_device_read(struct nvmem_device *nvmem,
 		      size_t bytes, void *buf)
 {
 	int rc;
+	size_t new_bytes;
 
 	if (!nvmem)
 		return -EINVAL;
 
+	/* Stop the user from reading */
+	if ((offset >= nvmem->size) || (bytes == 0))
+		return 0;
+
+	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
+		return -EOVERFLOW;
+
+	if (new_bytes > nvmem->size)
+		bytes = nvmem->size - offset;
+
 	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
 
 	if (rc)
@@ -1461,16 +1472,29 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 		       size_t bytes, void *buf)
 {
 	int rc;
+	size_t new_bytes;
 
 	if (!nvmem)
 		return -EINVAL;
 
+	/* Stop the user from writing */
+	if (offset >= nvmem->size)
+		return -ENOSPC;
+
+	if (bytes == 0)
+		return 0;
+
+	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
+		return -EOVERFLOW;
+
+	if (new_bytes > nvmem->size)
+		bytes = nvmem->size - offset;
+
 	rc = nvmem_reg_write(nvmem, offset, buf, bytes);
 
 	if (rc)
 		return rc;
 
-
 	return bytes;
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
-- 
2.7.4

