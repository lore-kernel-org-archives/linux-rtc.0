Return-Path: <SRS0=eRiM=M6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F6ECDE43
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Oct 2018 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EBF2098A
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Oct 2018 08:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrmlzE8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJRQw6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeJRQw5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 Oct 2018 12:52:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so14572423pfe.6
        for <linux-rtc@vger.kernel.org>; Thu, 18 Oct 2018 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F4klET77vpC5MSEg+hHmdmnyA+1l2CceneKVm/fwxIY=;
        b=jrmlzE8X9PBk3QfRv1Cfp60C33vylp0lkBxz8T8RarUCjyKz6a1ADpSvyxlGTXcWeA
         +C7BFa4VEqFP3Vyz+liAkIzoN/XnwIsIYagiL2aZINDGlAV3ltWKccQbbSjfY4yPsChx
         kOFHxcL8czMaX07ElOvCBIR53cXdDby3bYxXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F4klET77vpC5MSEg+hHmdmnyA+1l2CceneKVm/fwxIY=;
        b=krsyXM74K+Gd9ZD3oktfiwK6bi13duyTdq4bLliATUA3ImcKcPNM4esem6GpwY6T1C
         GVwXQkmQE5PnsPTNSx5MppqL1JbOcHLTX7y4amRd1iGUt1JCG7VGZflR3nq4X7sBtTPz
         l4BpsOTOui+YKzC4pfjNOQfnfb197m65aqrY8hW4Cv78N7wFSDW2JOj0GH5jGu9HbJeb
         55HhXDnO/vWymROkxY8tWIlUYXBb5WqJvYIKKAUGc3twVzXCBAIZv4PtNI9dnjtW1AjU
         4/LNqXBZt2AvkNSQg+TAOYD9D7YHwS2pxIwIkjrECww1wkYPGD13qYYRFlSIDMVsUmuX
         tK3w==
X-Gm-Message-State: ABuFfogU/VQFQe+qJPtVyi02zn0SrSc5kVnQA5bPf1/Q68CS62kx9iUn
        5uDP+HTiOWZBg6KUjPTshJpAxg==
X-Google-Smtp-Source: ACcGV60C8xYduHyBN2V8RbwQaoV4Y1y1K0cdWqigcTFFD6tafafStdkrNnrtQ+uE4CzPVFThIMXcXQ==
X-Received: by 2002:a63:e918:: with SMTP id i24-v6mr27451960pgh.64.1539852778961;
        Thu, 18 Oct 2018 01:52:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 5/5] rtc: sc27xx: Always read normal alarm when registering RTC device
Date:   Thu, 18 Oct 2018 16:52:30 +0800
Message-Id: <e3b4f8848cad42e5a2f4dfb34e342c69c8b95786.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When registering one RTC device, it will check to see if there is an
alarm already set in RTC hardware by reading RTC alarm, at this time
we should always read the normal alarm put in always-on region by
checking the rtc->registered flag.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 72bb002..b4eb3b3 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -415,10 +415,14 @@ static int sprd_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u32 val;
 
 	/*
-	 * If aie_timer is enabled, we should get the normal alarm time.
+	 * Before RTC device is registered, it will check to see if there is an
+	 * alarm already set in RTC hardware, and we always read the normal
+	 * alarm at this time.
+	 *
+	 * Or if aie_timer is enabled, we should get the normal alarm time.
 	 * Otherwise we should get auxiliary alarm time.
 	 */
-	if (rtc->rtc && rtc->rtc->aie_timer.enabled == 0)
+	if (rtc->rtc && rtc->rtc->registered && rtc->rtc->aie_timer.enabled == 0)
 		return sprd_rtc_read_aux_alarm(dev, alrm);
 
 	ret = sprd_rtc_get_secs(rtc, SPRD_RTC_ALARM, &secs);
-- 
1.7.9.5

