Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34763 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdHBMdR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 08:33:17 -0400
Received: by mail-io0-f180.google.com with SMTP id o9so19917350iod.1
        for <linux-rtc@vger.kernel.org>; Wed, 02 Aug 2017 05:33:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1dYKiP-0001kg-BQ@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk> <E1dYKiP-0001kg-BQ@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 14:33:15 +0200
Message-ID: <CACRpkdY-FCH8Fhaoi_CTqDUNGYTtFy247Q6jwPh6omQrspkgvg@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: pl031: make interrupt optional
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

> On some platforms, the interrupt for the PL031 is optional.  Avoid
> trying to claim the interrupt if it's not specified.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
