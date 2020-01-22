Return-Path: <SRS0=kbAY=3L=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CDDC33CAF
	for <linux-rtc@archiver.kernel.org>; Wed, 22 Jan 2020 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985062465B
	for <linux-rtc@archiver.kernel.org>; Wed, 22 Jan 2020 14:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAVOpg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:45:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:48556 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgAVOpe (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 22 Jan 2020 09:45:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 06:45:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="425873397"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2020 06:45:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1EDA8202; Wed, 22 Jan 2020 16:45:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 2/3] rtc: cmos: Use predefined value for RTC IRQ on legacy x86
Date:   Wed, 22 Jan 2020 16:45:28 +0200
Message-Id: <20200122144529.30307-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122144529.30307-1-andriy.shevchenko@linux.intel.com>
References: <20200122144529.30307-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When legacy devices are present on x86 machine, the RTC IRQ has
a dedicated pre-defined value. Use it instead of hard coded number.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index cb28bbdc9e17..aee55b658f85 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1305,7 +1305,7 @@ static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		 * hardcode it on systems with a legacy PIC.
 		 */
 		if (nr_legacy_irqs())
-			irq = 8;
+			irq = RTC_IRQ;
 #endif
 		return cmos_do_probe(&pnp->dev,
 				pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
-- 
2.24.1

