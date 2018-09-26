Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:40145 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZNvN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 26 Sep 2018 09:51:13 -0400
Received: by mail-it1-f196.google.com with SMTP id h23-v6so1573158ita.5
        for <linux-rtc@vger.kernel.org>; Wed, 26 Sep 2018 00:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180924144902.607-1-alexandre.belloni@bootlin.com> <20180924144902.607-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924144902.607-2-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Sep 2018 09:39:26 +0200
Message-ID: <CACRpkdYsuh2rXsW9KJz7Vaj_nH4ierpOE+G7tbrzkN2NDhgiuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: ab8500: let the core handle range
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Let the core handle offsetting and windowing the RTC range.
> The RTC has a 24 bit counter for minutes plus a seconds counter.
> Keep the epoch at the beginning of 2000.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
