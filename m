Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42892 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754613AbeFMJIL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Jun 2018 05:08:11 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so2662123ioh.9
        for <linux-rtc@vger.kernel.org>; Wed, 13 Jun 2018 02:08:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604141528.15635-2-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-2-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Jun 2018 11:08:10 +0200
Message-ID: <CACRpkdbt=2diDRueUqdEnHxViG-Nr0Rcs-aW67hjgrQnxQUaAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: ftrtc010: handle dates after 2106
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

> Use correct types for offset and time and use
> rtc_time64_to_tm/rtc_tm_to_time64 to handle dates after 2106 properly.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
