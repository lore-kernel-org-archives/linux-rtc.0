Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:38121 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZNuS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 26 Sep 2018 09:50:18 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so22527019ioc.5
        for <linux-rtc@vger.kernel.org>; Wed, 26 Sep 2018 00:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Sep 2018 09:38:32 +0200
Message-ID: <CACRpkdYtU7J-0g8T9FzaGrbLkWEBPjn+xUZUq0AsJZcN=bvyXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: ab8500: use rtc_add_group
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use rtc_add_group to add the sysfs group in a race free manner.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
