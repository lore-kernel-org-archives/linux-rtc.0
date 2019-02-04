Return-Path: <SRS0=BbLS=QL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F33C282C4
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Feb 2019 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6491217F9
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Feb 2019 12:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QFoI8zUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfBDMxY (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:53:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36417 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfBDMxY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Feb 2019 07:53:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so12731420otk.3
        for <linux-rtc@vger.kernel.org>; Mon, 04 Feb 2019 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c+J7dprR/p6h3cne06HEZhzVzP5Q9j+bcCHkd43MRJ0=;
        b=QFoI8zUz+j3wZAihuvZ0WDFI6M7Frwh0yVTKmQoltuhC2DscA20GclVrV3eWC5NECk
         75Tjinfd/6aO/rO742P60q8Ucwh0rd79CXT3G0QekHxZxL58jYsq5PdjZvhnnjMh6g0T
         QZ8xWXxGwNwOKacDv+4PlpkzLpquKD3NbjctNytzdsXRUg/YkHGRspmpE77krIRDT/ht
         4NF6aQb+d801rVSCxHcdbF1mUOfqPdNoWDosRXh8+/3Jq5+RVFcDnn/74NMH1PYTlXT3
         zeyRs06fl7lJwt0gN/qLA/u05J/sIu2KFJGu/Jr5g68yUERs+lIOmQYQ4mvS0PXn1h4p
         0F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+J7dprR/p6h3cne06HEZhzVzP5Q9j+bcCHkd43MRJ0=;
        b=MX6XNfNYf2BE3l/4zoDH7x76XQPQeT69KnF/kvm9imY7RAeGSXnx8qmMj6K8NCpJc6
         ZJ8ON/BIFKHyiX2N0Mi3YNDMgBRH1eLI7wtITmM+xW/Wj5tsptWreH/U4nvWWN+JN+fa
         oOS0p8mCvIzoAG+TOc0DPQ0VAXb7Qi/sOQ8iGBcbeOhSW+Tz7I0PdMYt00TJISYNmY/D
         LY81l0pisExdyturoj4tOUK3zVqYwjx40vKtEKCB+GOCtVyQfnKHstZIO3AuFRuPQ2tR
         RkRncoU5WzYuB36PLUgQnXnh6rGfVpdj+lfhLEngKgndltq5TvSvV/FUA13YfnXTHLYn
         qcPg==
X-Gm-Message-State: AJcUukdSGgjZRMay1xyivMqOTmXqi0oiQvwUQhRuCzyp5JdSMOwwae13
        TmL1+MY2bKvynX04A2Klo3WGhwCI8varCal/vMB1Sw==
X-Google-Smtp-Source: AHgI3IaWmrdtexpHS/+Up5op8bPq/PaP+a/PmEpsyuO6cp0RhS2ZW0peMz7k+6/oOOlvLBsMlBJN5TIkKaUw/GctAgg=
X-Received: by 2002:aca:57d7:: with SMTP id l206mr26770403oib.277.1549284803540;
 Mon, 04 Feb 2019 04:53:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <5f63684b62c7a320c514088bcf9091ed7efbd2cc.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
In-Reply-To: <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Feb 2019 13:53:12 +0100
Message-ID: <CAMpxmJXKmq29misG_zx9qeaQ11qzYSvWqNwcNpRGc3cv4AK8eg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/10] gpio: Initial support for ROHM bd70528 GPIO block
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

pon., 4 lut 2019 o 12:30 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Thu, Jan 31, 2019 at 1:08 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
>
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> (...)
> > I dropped the review-by from Linus Walleij because I would like to
> > get a comment on if locking is required when we check the direction
> > in order to detect the correct register for getting the pin state.
>
> I don't know that. You isn't regmap locking inherently?
>

FYI you can disable regmap locking by setting the disable_locking
field in regmap_config to true.

Bart

> > My initial feeling is that locking makes no sense.
>
> Mine too.
>
> > +       bdgpio->gpio.get_direction =3D &bd70528_get_direction;
> > +       bdgpio->gpio.direction_input =3D &bd70528_direction_input;
> > +       bdgpio->gpio.direction_output =3D &bd70528_direction_output;
> > +       bdgpio->gpio.set_config =3D &bd70528_gpio_set_config;
> > +       bdgpio->gpio.can_sleep =3D true;
> > +       bdgpio->gpio.get =3D &bd70528_gpio_get;
> > +       bdgpio->gpio.set =3D &bd70528_gpio_set;
>
> Drop the &ampersand in from of the functions. All functions
> are pointers.
>
> With that:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
