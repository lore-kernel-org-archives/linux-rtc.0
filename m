Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:34905 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdHBMck (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 08:32:40 -0400
Received: by mail-it0-f48.google.com with SMTP id h199so22956133ith.0
        for <linux-rtc@vger.kernel.org>; Wed, 02 Aug 2017 05:32:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1dYKiK-0001kZ-6E@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk> <E1dYKiK-0001kZ-6E@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 14:32:38 +0200
Message-ID: <CACRpkdadsnmL2e5XPoE9LFs4azqemZ69FbY_-bzjJigJMCf-qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtc: pl031: avoid exposing alarm if no interrupt
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> If the RTC has no interrupt, there is little point in exposing the RTC
> alarm capabilities, as it can't be used as a wakeup source nor can it
> deliver an event to userspace.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This makes all kind of sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
