Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:34656 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdFEMkE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 08:40:04 -0400
Received: by mail-it0-f53.google.com with SMTP id m47so15581980iti.1
        for <linux-rtc@vger.kernel.org>; Mon, 05 Jun 2017 05:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bbccfbd0-3890-4eff-be88-094a8006dc9d@gmail.com>
References: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com> <bbccfbd0-3890-4eff-be88-094a8006dc9d@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Jun 2017 14:40:02 +0200
Message-ID: <CACRpkdZPj0GBk-jroSz4x65QArvMSOJbRzLCFftuk=wSfsqu6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rtc: ds1307: make definition of ds1307_of_match
 more compact
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 1, 2017 at 9:09 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Make the definition of ds1307_of_match more compact. This makes the
> code better readable and more in line with the definition of
> ds1307_id and ds1307_acpi_ids.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
