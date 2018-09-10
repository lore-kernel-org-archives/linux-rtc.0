Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:43660 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeIJLhY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Sep 2018 07:37:24 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so6131903ioa.10
        for <linux-rtc@vger.kernel.org>; Sun, 09 Sep 2018 23:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com> <20180909203848.3470-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180909203848.3470-3-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Sep 2018 08:44:42 +0200
Message-ID: <CACRpkdaVH7_eVGC+CRQqsA1Y1+oMkkVhVPJmpiE=k90qa23SQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: pl031: switch to devm_rtc_allocate_device/rtc_register_device
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sun, Sep 9, 2018 at 10:38 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Switch to devm_rtc_allocate_device to simplify the erro and driver removal
> paths.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
