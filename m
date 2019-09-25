Return-Path: <SRS0=wEJo=XU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1AC432C2
	for <linux-rtc@archiver.kernel.org>; Wed, 25 Sep 2019 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0721D79
	for <linux-rtc@archiver.kernel.org>; Wed, 25 Sep 2019 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iKTW5eGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393209AbfIYUcX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:32:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33410 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389778AbfIYUcW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Sep 2019 16:32:22 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so492720ior.0
        for <linux-rtc@vger.kernel.org>; Wed, 25 Sep 2019 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Joen6PgN4Ppb107hjPSYd8q2loeVTGPWBeR8yaoJJfc=;
        b=iKTW5eGmeo7sl0Q4HF9ZqwfjLbHPh77cZyWr36n8dzNdMbT+HJemF9vuYIeQp42jxo
         Qacg5Pz2zsOsDg/o/arm+Ck81IAphdlBANecSt6LiqOvq9WAOZlKhtqxEJAO4BWKsFmr
         qDJICSw4ZPcg1YZeuD4zDxTZD0XFTlD27h63s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Joen6PgN4Ppb107hjPSYd8q2loeVTGPWBeR8yaoJJfc=;
        b=X9Ob8SfEu/PQ3/a1fOiRUNXYLNwA977MOsJv6hjsHs/DoYLMLMLx5kOqWkTvyajkSu
         g0fiJYAV5KdPiWxLbqqcMCFvmjAwzBdb8SwNEtNh7pKnIKVvbT+na6v4YymYRGNRnfWu
         cUtR6Q6bwQk3crDNl/NYHyXjPFE8G2hna2//qatMGYtu83qAvJ3D/ocmDhwHEOKpJRCF
         p3gv6b4PudGwq3exC8bgmun92EjM/6cvQfosMKnadjtsu8b7sWTsH8+/iz6fMhf0DjKX
         JiDb5MMwYYvxuGEg41EbQKtPHnbb8zlVGR/Sl+B19/IYvN/GjqrucNoLJzAk0SCm+4ya
         Ao1g==
X-Gm-Message-State: APjAAAXlhI43hQUsL6XvTbi52DHwVhd74lKPxhiSBH0NmHb4km001MKU
        raKhi0j1r9DrdtvZpNg/PZz4aw==
X-Google-Smtp-Source: APXvYqwP6ll3AAaHm5zA/bZMtHo3VackpD0kbI9u/xv9rtajmPg9oQEH0fjV0awqQtIwDacR9W4tiA==
X-Received: by 2002:a6b:b704:: with SMTP id h4mr1413903iof.218.1569443541534;
        Wed, 25 Sep 2019 13:32:21 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id 80sm449790iou.13.2019.09.25.13.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 13:32:21 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, enric.balletbo@collabora.com,
        bleung@chromium.org, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3] rtc: wilco-ec: Handle reading invalid times
Date:   Wed, 25 Sep 2019 14:32:09 -0600
Message-Id: <20190925203209.79941-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

If the RTC HW returns an invalid time, the rtc_year_days()
call would crash. This patch adds error logging in this
situation, and removes the tm_yday and tm_wday calculations.
These fields should not be relied upon by userspace
according to man rtc, and thus we don't need to calculate
them.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/rtc/rtc-wilco-ec.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 8ad4c4e6d557..53da355d996a 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -110,10 +110,15 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday	= rtc.day;
 	tm->tm_mon	= rtc.month - 1;
 	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
-	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
-
-	/* Don't compute day of week, we don't need it. */
-	tm->tm_wday = -1;
+	/* Ignore other tm fields, man rtc says userspace shouldn't use them. */
+
+	if (rtc_valid_tm(tm)) {
+		dev_err(dev,
+			 "Time from RTC is invalid: second=%u, minute=%u, hour=%u, day=%u, month=%u, year=%u, century=%u",
+			 rtc.second, rtc.minute, rtc.hour, rtc.day, rtc.month,
+			 rtc.year, rtc.century);
+		return -EIO;
+	}
 
 	return 0;
 }
-- 
2.21.0

