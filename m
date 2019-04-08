Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438ADC10F13
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE90420863
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0JiN23W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDHX6b (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:58:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46486 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDHX6b (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Apr 2019 19:58:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so8720301otk.13
        for <linux-rtc@vger.kernel.org>; Mon, 08 Apr 2019 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE1WYVGVNZvhKVkDzi+IvgK1LGy4Jum42vFJlF26XjM=;
        b=H0JiN23WqMaS6Bz6v4EQer4AcYbtrYtN9qAENkloOrBeH9NEw/mU4pOG6k2k0CB/Oe
         K6R+iR81aDfaCgwyVC6Oc1cj3LSztvEu0c1vBG+RYWQgFcPp4wk9a7UVKFG+ZZqYDWFv
         COOpFloRlQahqhC9hH9ZaEICJQ/8M32g8R/L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE1WYVGVNZvhKVkDzi+IvgK1LGy4Jum42vFJlF26XjM=;
        b=oQNIuY/dpOfsSnm1cYPxPiiKztSKB1nZSelcRMNzNZPffelvPQqqmuMaOP3U31Da07
         p1+YuXFTeGpql+tXdko0cdKuaRfUjuRQJ6CFr2bAngR2JnwAQK1l21Z79ewUEV0YnsRv
         OeCg5nldiK18o7cHUk2moIsNQc2qTPfoR8DYuEIcrmG9WOyFC2dbB8WqUdBDMUwRBauD
         739kW8RUyseVra1VLlFtQexrqskVTjazKwJCwkl1JL0R3inGSHWZNlW8G6xGleF3oJU6
         Q3nhMiylve0MRjSRGDR+OoIb/uAgFKR1Q4j5AZPsAFyNL5MP9FvgR949gjEv4O1OWPve
         kpag==
X-Gm-Message-State: APjAAAUhJPONmj2ApbxXJ13ysi+IGc9ghQ18UAOzw/WPBFRP9eeNdbFH
        ELG2StcMDCMGvFeVZwlVosRjP5zQgsw=
X-Google-Smtp-Source: APXvYqxClYAFwwbSUvkqGYdDnzTRNGCCGcUZqFW2FCjzPH838vlxJ/T2PKmVfRttYVot/NlgRlS4dA==
X-Received: by 2002:a05:6830:135a:: with SMTP id r26mr21173381otq.297.1554767910410;
        Mon, 08 Apr 2019 16:58:30 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id k60sm13112341otc.42.2019.04.08.16.58.28
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 16:58:29 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 3so12029676oir.7
        for <linux-rtc@vger.kernel.org>; Mon, 08 Apr 2019 16:58:28 -0700 (PDT)
X-Received: by 2002:aca:3905:: with SMTP id g5mr18501995oia.49.1554767908118;
 Mon, 08 Apr 2019 16:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
In-Reply-To: <20190404171007.160878-3-ncrews@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 8 Apr 2019 17:58:16 -0600
X-Gmail-Original-Message-ID: <CAHX4x87XiNMnjr+-2A2yHgKbZLaDBXO-U1Uij2sCq=gH9Vv4jw@mail.gmail.com>
Message-ID: <CAHX4x87XiNMnjr+-2A2yHgKbZLaDBXO-U1Uij2sCq=gH9Vv4jw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

I've just found a few [embarrassing :)] bugs in this version,
so after we figure out the naming, please wait for me to send
out another patch that fixes these.

Thanks, Nick

On Thu, Apr 4, 2019 at 11:10 AM Nick Crews <ncrews@chromium.org> wrote:
>
> We want all backlights for the system keyboard to
> use a common name, so the name "platform::kbd_backlight"
> would be better than the current "chromeos::kbd_backlight"
> name. Normally this wouldn't be worth changing, but the new
> Wilco keyboard backlight driver uses the "platform" name.
> We want to make it so all Chrome OS devices are consistent,
> so we'll change the name here too.
>
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
