Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbeDRP6a (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 18 Apr 2018 11:58:30 -0400
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com [209.85.216.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17602170D
        for <linux-rtc@vger.kernel.org>; Wed, 18 Apr 2018 15:58:29 +0000 (UTC)
Received: by mail-qt0-f175.google.com with SMTP id f20-v6so2309334qtp.7
        for <linux-rtc@vger.kernel.org>; Wed, 18 Apr 2018 08:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418142308.GA13543@mwanda>
References: <20180418142308.GA13543@mwanda>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Apr 2018 10:58:08 -0500
Message-ID: <CAL_JsqJTstU6wkdXyvfga24oefRasL9MZig_ctdWMK49+55csg@mail.gmail.com>
Subject: Re: [bug report] rtc: pxa: convert to use shared sa1100 functions
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Apr 18, 2018 at 9:23 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> [ This code is several years old now.  - dan ]

Did I miss an earlier bug report?

> Hello Rob Herring,
>
> The patch 3cdf4ad9633e: "rtc: pxa: convert to use shared sa1100
> functions" from May 13, 2015, leads to the following static checker
> warning:
>
>         drivers/rtc/rtc-pxa.c:368 pxa_rtc_probe()
>         info: return a literal instead of 'ret'
>
> drivers/rtc/rtc-pxa.c
>    352          pxa_rtc->base = devm_ioremap(dev, pxa_rtc->ress->start,
>    353                                  resource_size(pxa_rtc->ress));
>    354          if (!pxa_rtc->base) {
>    355                  dev_err(dev, "Unable to map pxa RTC I/O memory\n");
>    356                  return -ENOMEM;
>    357          }
>    358
>    359          pxa_rtc_open(dev);
>    360
>    361          sa1100_rtc->rcnr = pxa_rtc->base + 0x0;
>    362          sa1100_rtc->rtsr = pxa_rtc->base + 0x8;
>    363          sa1100_rtc->rtar = pxa_rtc->base + 0x4;
>    364          sa1100_rtc->rttr = pxa_rtc->base + 0xc;
>    365          ret = sa1100_rtc_init(pdev, sa1100_rtc);
>    366          if (!ret) {
>                     ^^^^
> This test really looks like it's inverted to me.

Indeed. Nice to see no one seems to have noticed or care.

Rob
