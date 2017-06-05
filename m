Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38812 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdFEMoB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 08:44:01 -0400
Received: by mail-it0-f52.google.com with SMTP id r63so74316790itc.1
        for <linux-rtc@vger.kernel.org>; Mon, 05 Jun 2017 05:44:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <32e77bf2-ded8-5686-082a-d92db1a58a56@gmail.com>
References: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com> <32e77bf2-ded8-5686-082a-d92db1a58a56@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Jun 2017 14:43:59 +0200
Message-ID: <CACRpkdbnn-s14uG0Vj_p9qjSPZ8S_V1x1jCJw61aUdd5Mw57Tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rtc: ds1307: factor out century bit handling
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 1, 2017 at 9:09 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> The driver has lots of places with chip-specific code what doesn't
> necessarily facilitate maintenance.
>
> Let's describe chip-specific differences in century bit handling
> in struct chip_desc to improve this.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - no changes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
