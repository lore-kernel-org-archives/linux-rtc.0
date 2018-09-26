Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:56027 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZNvw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 26 Sep 2018 09:51:52 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so1664090itd.5
        for <linux-rtc@vger.kernel.org>; Wed, 26 Sep 2018 00:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180924144902.607-1-alexandre.belloni@bootlin.com> <20180924144902.607-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924144902.607-3-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Sep 2018 09:40:05 +0200
Message-ID: <CACRpkdZ97txAe+Nm_AKTQsBEfcq8ShVZOwv_fcHBk4w4t2bgSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: ab8500: remove useless check
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> rtc_time_to_tm always rturns a valid tm, there is no need to validate it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
