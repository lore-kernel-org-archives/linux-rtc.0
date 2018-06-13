Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37805 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMJHv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Jun 2018 05:07:51 -0400
Received: by mail-it0-f68.google.com with SMTP id l6-v6so2876318iti.2
        for <linux-rtc@vger.kernel.org>; Wed, 13 Jun 2018 02:07:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Jun 2018 11:07:49 +0200
Message-ID: <CACRpkdZkXQj9xxN-wBjT_Y4Q5Se-Ts488bZzunYyecTau1pOEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: ftrtc010: switch to devm_rtc_allocate_device
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

> Switch to devm_rtc_allocate_device/rtc_register_device. This allow or
> further improvement and simplifies ftrtc010_rtc_remove().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
