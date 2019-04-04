Return-Path: <SRS0=xpCi=SG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC195C10F0C
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BC206DD
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPE6sONU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfDDRgs (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:36:48 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39396 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfDDRgr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 4 Apr 2019 13:36:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id z9so1282389ywd.6
        for <linux-rtc@vger.kernel.org>; Thu, 04 Apr 2019 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zd2r6EESc6S1jgBvvSnCZ/pZSAW/Iie5VkqnNCE6jZM=;
        b=sPE6sONUClr78ReGxLalfvJ2xQQwrGUa+9BQ6mHrrQncMSnwp9vcKr4OzuCPlafSC3
         g4IQWmlXTfCG1OwN8IBHLB9UUccWj3gq8rGg9MtAom8q61oMdW6D9ATKimltMKIu59Qf
         mzsLVqqSuyMz6L7viynbg70U82nTYD0lwtPUjGWCqbnJ2Vy7gnTqNfFYiafII8HZPy4c
         yzdszw9NlIFEl5Th4vy5EBHIJExr9uhYQX1Z20CRcnSTbDG6ZutsXFOMeOYZWFBr9aGv
         l3ntSZ+S6rPr3735zLTvOqJUwb+GuwDtvL73mOkHfnjnP2nJSiV1fcAJB/BqkaO3Bzye
         6fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zd2r6EESc6S1jgBvvSnCZ/pZSAW/Iie5VkqnNCE6jZM=;
        b=uUF/ic1CR/gqGpkMALqKtjMqw2Np3nr+PwgVBsUFRZa+RyvqnPh45//pUpzbGxL3Cu
         Rb08VlvWFBfuohCSvfKYGxiQj1rwINdz9C1AEw+wFwRmR1Ic16ZnOGvbRTMaggtP/Llf
         C27xYeRJGTV/O6ouG81JWsE+gBoEzYwfu1H5TZNQAdi9XPiiJi5TNX6+5bup9DFFg04m
         +zz4OBgti3pbP7N7QZ2+w25sO4BRH5YcUXXl70e0TMTFbdmwyEJRI/kmocyJpZVjTpdx
         UKqnmKaj3KoeIiSarPEHXhQgvUoPjvD9U6BM+2qpNl4ta/biG2/vVglejJrVF96PqL89
         trkg==
X-Gm-Message-State: APjAAAVvEi1Qm7ZuxTta+u/muTuiJbJvVipiWDtuXRFfMHGjypav/58E
        X+XkuJ3vXk5fKVLYnzq3jCy9MCLwtTtUKqhvDthxOA==
X-Google-Smtp-Source: APXvYqy/U8cGyeopEsevIkbhOvd5ynofiCH3bWcG9771LY+k14o3nAMR+zGfHl4PxKl/cxejjmbsg0futE/Q9OPTtYw=
X-Received: by 2002:a0d:e403:: with SMTP id n3mr6186276ywe.408.1554399406641;
 Thu, 04 Apr 2019 10:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
In-Reply-To: <20190404171007.160878-3-ncrews@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 4 Apr 2019 10:36:35 -0700
Message-ID: <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>, Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
>
> We want all backlights for the system keyboard to
> use a common name, so the name "platform::kbd_backlight"
> would be better than the current "chromeos::kbd_backlight"
> name. Normally this wouldn't be worth changing, but the new
> Wilco keyboard backlight driver uses the "platform" name.
> We want to make it so all Chrome OS devices are consistent,
> so we'll change the name here too.
>

Wondering - who is the "we" you are talking about ?

Guenter

> The Power Manager daemon only looks for LEDs that match the
> pattern "*:kbd_backlight", so this change won't affect that.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index aa409f0201fb..c56c8405f39c 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -77,7 +77,7 @@ static int keyboard_led_probe(struct platform_device *pdev)
>         if (!cdev)
>                 return -ENOMEM;
>
> -       cdev->name = "chromeos::kbd_backlight";
> +       cdev->name = "platform::kbd_backlight";
>         cdev->max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX;
>         cdev->flags |= LED_CORE_SUSPENDRESUME;
>         cdev->brightness_set = keyboard_led_set_brightness;
> --
> 2.20.1
>
