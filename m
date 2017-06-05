Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:34023 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdFEMm4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 08:42:56 -0400
Received: by mail-it0-f43.google.com with SMTP id m47so15598216iti.1
        for <linux-rtc@vger.kernel.org>; Mon, 05 Jun 2017 05:42:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2eb07379-2b2a-5649-fc39-aeac298d6d7b@gmail.com>
References: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com> <2eb07379-2b2a-5649-fc39-aeac298d6d7b@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Jun 2017 14:42:54 +0200
Message-ID: <CACRpkdZ0wO5k5mVNZzjGPVn7-N=w1LbH+bzRfY_Bcrpx7Pj9MA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtc: ds1307: use regmap_update_bits where applicable
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 1, 2017 at 9:09 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> After the switch to regmap we can now make use of regmap_update_bits
> to simplify read/modify/write ops.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - no changes

Inspected all sites and they look fine.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
