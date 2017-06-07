Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33464 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdFGJVW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Jun 2017 05:21:22 -0400
Received: by mail-io0-f171.google.com with SMTP id b184so4356064ioe.0
        for <linux-rtc@vger.kernel.org>; Wed, 07 Jun 2017 02:21:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170605170003.uzkjihrbz2rbetjx@piout.net>
References: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
 <5b8af62b-24a4-0a05-26c7-6be893297f9c@gmail.com> <20170605170003.uzkjihrbz2rbetjx@piout.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Jun 2017 11:21:20 +0200
Message-ID: <CACRpkdbNKh5qZEEFssaWFTmuWqSehuS+a0FmGojhU7vm_j32Gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rtc: ds1307: make definition of ds1307_of_match
 more compact
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Jun 5, 2017 at 7:00 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 05/06/2017 at 17:57:22 +0200, Heiner Kallweit wrote:
>> Make the definition of ds1307_of_match more compact. This makes the
>> code better readable and more in line with the definition of
>> ds1307_id and ds1307_acpi_ids.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> v2:
>> - no changes
>> v3:
>> - add reviewed-by
>
> Well, I don't like it, and I don't think it actually improves
> readability. My experience shows that the opposite of this patch is
> quite often necessary.

The patch is certainly not important and should ideally be last in the
series.

Is it possible to apply patches 2-4 right off? They seem fairly orthogonal
to this one.

Yours,
Linus Walleij
