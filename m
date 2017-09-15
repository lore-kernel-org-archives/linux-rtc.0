Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:48697 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdIOHNP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Sep 2017 03:13:15 -0400
Received: by mail-io0-f181.google.com with SMTP id n69so6252609ioi.5
        for <linux-rtc@vger.kernel.org>; Fri, 15 Sep 2017 00:13:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915001952.13170-1-alexandre.belloni@free-electrons.com>
References: <20170915001952.13170-1-alexandre.belloni@free-electrons.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Sep 2017 09:13:13 +0200
Message-ID: <CACRpkda_nFtEqRiciJ-fytbEpBB2NkChpNDb4GKcaYO-MjoXEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: RTC: add stericsson,coh901331 bindings
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Sep 15, 2017 at 2:19 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Add device tree bindings for the ST-Ericsson COH 901 331 Real Time Clock
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Oh this was merged so far back in the day that we were even lax
about adding bindings properly. Too bad, sorry about it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Linus Walleij
