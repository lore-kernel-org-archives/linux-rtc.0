Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34612 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbdHWIZ6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2017 04:25:58 -0400
Received: by mail-oi0-f48.google.com with SMTP id j144so9920099oib.1
        for <linux-rtc@vger.kernel.org>; Wed, 23 Aug 2017 01:25:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823053825.19841-1-nikita.yoush@cogentembedded.com>
References: <20170823053825.19841-1-nikita.yoush@cogentembedded.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Aug 2017 10:25:57 +0200
Message-ID: <CACRpkda1kQkcVaChRcqg5z_b1TyWA=7FDB9aZvv_h5HAu5Fpbw@mail.gmail.com>
Subject: Re: [PATCH] rtc: ds1307: add basic support for ds1341 chip
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        David Lowe <dave-lowe@ntlworld.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Marek Vasut <marex@denx.de>, Tin Huynh <tnhuynh@apm.com>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Aug 23, 2017 at 7:38 AM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:

> This adds support for reading and writing date/time from/to ds1314 chip.
>
> Other functionality (alarms, inout clock, output clock) is not added
> yet, because availability of that depends on chip connections.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Overall this looks fine.

> ---
>  drivers/rtc/Kconfig      | 10 +++++-----
>  drivers/rtc/rtc-ds1307.c | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 5 deletions(-)
> ===
> DS1341/1342 chips have additional features, namely
> - alarms,
> - input clock (can be used instead of intercal oscillator for better
>   accuracy),
> - output clock ("square wave generation")

When you put all this useful information below the commit line
like this it gets lost and is not in the commit message in
git log.

Please live it into the commit blurb or even, if really useful,
as a comment in the driver itself.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
