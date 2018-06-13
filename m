Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36021 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeFMJKg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Jun 2018 05:10:36 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so2898782itj.1
        for <linux-rtc@vger.kernel.org>; Wed, 13 Jun 2018 02:10:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604141528.15635-3-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-3-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Jun 2018 11:10:35 +0200
Message-ID: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: ftrtc010: let the core handle range
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The current range handling is highly suspicious. Anyway, let the core
> handle it.

Hmmm. I have datasheets, do you need some input about the hardware?
Something I should patch?

> The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
