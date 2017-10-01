Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:43130 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdJAPDz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 1 Oct 2017 11:03:55 -0400
Received: by mail-io0-f177.google.com with SMTP id k101so3055596iod.0
        for <linux-rtc@vger.kernel.org>; Sun, 01 Oct 2017 08:03:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 1 Oct 2017 17:03:54 +0200
Message-ID: <CACRpkdZ1-JFs0p-jO7YEb+A9MrxmLbkfu89G59VsaXvkvvu1xw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Make PL031 interrupt optional
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Sep 29, 2017 at 12:21 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> There are some boards out there which have a PL031 RTC, but its
> interrupt is not wired up.  To support these, we need the PL031
> to support the primecell without interrupts.
>
> When no interrupt is present, there's little point exposing the
> RTC's alarm capabilities, so we omit the alarm-related function
> calls - the RTC merely becomes a source of time-of-day.
>
> This patch series cleans up the pl031 driver a little, and adds
> support for this configuration.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
