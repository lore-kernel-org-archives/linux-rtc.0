Return-Path: <SRS0=xpCi=SG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC8EC4360F
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA76A206BA
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 17:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PkK5MxeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfDDRLR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:11:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51542 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDDRLQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 4 Apr 2019 13:11:16 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so4973435itk.1
        for <linux-rtc@vger.kernel.org>; Thu, 04 Apr 2019 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r56PFnvFNbkuu6fKIPqWW2CUTLL5qPhK0vfa3csRPuE=;
        b=PkK5MxeH5h066Qhv09erVQWVTLxlE6pEuLIU0AAtl+njj1I5SDAWgP+qA9ViIwwcY9
         AuggGttzToFJsyK0YY/mroiAl1AhqnqnLsrHcIFnH6a28cLeq8AtDM4ylXDeCJdLfWCs
         U+eFwW2GOvNMv4Z5MDb8zbqrgw+KuwYDNAcT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r56PFnvFNbkuu6fKIPqWW2CUTLL5qPhK0vfa3csRPuE=;
        b=oBeYTBb60ig0rEEsDV2Mclrrn2uXlhF8rXKlW+NrwEEdhNe0dezjG3ig45iYoWXaHM
         QRMk1iOj6k6hlNKsCDtElAza8esXPPDrwt3ZNMrG9veMrVPH8o9VDkPx1FsMtcWtpjFg
         IkvqWOBKjdqdZhuB3A3bYUj/ZiyQ03hR4DBN0M4A5krA3OME0zEC5xiLeHBpmxeShyug
         vMoCTtiGHXax/pNhgsMHkfx+SB7CteN23Z7zv1yhdqZkwcGGawtfYqUGBUyrS7C2dKkW
         z1mnbudPU8h3S7uAXIUdtXEKM5dIXjzEcU0EnSALpvtGp4O6f672trkvWhV9CO8zlQxQ
         s7tg==
X-Gm-Message-State: APjAAAVZIn5LabENPjt8NVTivsXuLqsH0ZH+YQ3DDLK9ffrD+IsQS3s7
        7LNIdDub28dW902/d8rnmpk65g==
X-Google-Smtp-Source: APXvYqzkbqd/0TCxfzOWucLzq0jXN7nLIrFonMQevGkXf46yS6UtKcGI+qygW7+OPbYSdPaFwxLhXw==
X-Received: by 2002:a02:8c59:: with SMTP id j25mr5796250jal.4.1554397875814;
        Thu, 04 Apr 2019 10:11:15 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id d133sm9559835ita.5.2019.04.04.10.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 10:11:15 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard backlight name
Date:   Thu,  4 Apr 2019 11:10:10 -0600
Message-Id: <20190404171007.160878-3-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404171007.160878-1-ncrews@chromium.org>
References: <20190404171007.160878-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

We want all backlights for the system keyboard to
use a common name, so the name "platform::kbd_backlight"
would be better than the current "chromeos::kbd_backlight"
name. Normally this wouldn't be worth changing, but the new
Wilco keyboard backlight driver uses the "platform" name.
We want to make it so all Chrome OS devices are consistent,
so we'll change the name here too.

The Power Manager daemon only looks for LEDs that match the
pattern "*:kbd_backlight", so this change won't affect that.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/cros_kbd_led_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index aa409f0201fb..c56c8405f39c 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -77,7 +77,7 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	if (!cdev)
 		return -ENOMEM;
 
-	cdev->name = "chromeos::kbd_backlight";
+	cdev->name = "platform::kbd_backlight";
 	cdev->max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX;
 	cdev->flags |= LED_CORE_SUSPENDRESUME;
 	cdev->brightness_set = keyboard_led_set_brightness;
-- 
2.20.1

