Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36820 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdHBMa7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 08:30:59 -0400
Received: by mail-io0-f172.google.com with SMTP id g35so19804360ioi.3
        for <linux-rtc@vger.kernel.org>; Wed, 02 Aug 2017 05:30:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1dYKi9-0001kK-RQ@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk> <E1dYKi9-0001kK-RQ@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 14:30:57 +0200
Message-ID: <CACRpkda1kSAFJZHqGAPWiFckGJ5AoJG4htB0+r56gDFKmxubrg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rtc: pl031: constify amba_ids
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

> The AMBA device IDs should be marked const.  Make that so.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
