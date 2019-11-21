Return-Path: <SRS0=+M65=ZN=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02915C43215
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Nov 2019 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBFE206D7
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Nov 2019 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrBHiUoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUONi (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:13:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40998 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUONe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Nov 2019 09:13:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so915897lfp.8
        for <linux-rtc@vger.kernel.org>; Thu, 21 Nov 2019 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JyZcuxmnqH9o3l1XIsdo9JoDg6orfPAOo4vV+1ArwI=;
        b=rrBHiUoKWpM7JYxtbtpxA0m+4KENiEgkqrUsZmhr0SztUWa9GUvIt/JXaO0iFQRllZ
         t3wzjzr03SFpjcFQGnFj0y/UpVyUqyecuAW3vxE4lWRgvib88TaOl4LfTUkWVuMwstOc
         rVaLG+TK5EOxzs2vEIlhxL5ZIx/y9z9hGkS1GycaeyORQgAMz42kb38UDvW/4yFgHKwg
         mWjGFjw7UbrtvZtMwDsn43Fo5dHuTInhPJYUXXghPs2lxBPvZJceDwQaYZRs4EGrNi9c
         PVuTDWJPExc34WanbcJGVM0rfhNW78ycZ8o22Jb0KYITgABmMcdEUNWVksb8I1S9G1li
         junQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JyZcuxmnqH9o3l1XIsdo9JoDg6orfPAOo4vV+1ArwI=;
        b=R8p/FeMWO2rBVwgYF5U7y/i0CFyl9l1BJs1vTrRySQ8kryIT5hgh3s4tQgGOB7mh/m
         ZhIohBXhZBK6k6EQduq7QMJZD91Lp04EFOFn5Gza7vrw/GIW7hNlYad6GgcrVnK/Cdif
         nl/blOTaJjl636a+rIk+WdSzKqBoRNznEWz9S/DPTkJY9qqOlnCDvW6M4TjAL2z//K5a
         xJTHb+MJSbgrh5vMf+oi4Fep53kHVFNh4wx4f7xqRFx8padLd6kRl5vvNxhKPPa+lzgv
         D7cnOkepJ+GivPuzXweSBvJLr3R8JVrmnJbJqZF0ysacEHJ2/NieEPmRRuTl+E/hib1G
         Mzeg==
X-Gm-Message-State: APjAAAVRSjSbr9md9OCkUWPEaDiSyd9phBQfAT5/udqWLU2fM0ON893Y
        tmJblBJtNzOsBPHNpBpKiwusTPUroDTyL4aKZtIP/Q==
X-Google-Smtp-Source: APXvYqzimZuG3p1BLtFLAcUV8Mt4bdmTDeHVDJCNJZDdvOb/9aTIsO3K13nkITKtnZC6f5/fil79Hmb8rkLOz0NdB1U=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr7859980lfp.5.1574345612125;
 Thu, 21 Nov 2019 06:13:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574059625.git.matti.vaittinen@fi.rohmeurope.com>
 <8dd9dad2765d47fd6c6fec20566326d00e48a696.1574059625.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdY_2WzAnK01bQdMF69KsDvHHu9TXuyRoBcmiQMziux=eQ@mail.gmail.com> <ece1ab1418e237d6f4968fc4cf59202c35f02ba7.camel@fi.rohmeurope.com>
In-Reply-To: <ece1ab1418e237d6f4968fc4cf59202c35f02ba7.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 15:13:20 +0100
Message-ID: <CACRpkdZvED9He0gcCzYMs_q1=-RzEfUgoP11HEW-cNDg1fgnvg@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] gpio: devres: Add devm_gpiod_get_parent_array
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Nov 19, 2019 at 6:54 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> [Me]
> > So what is this? NULL?
>
> Here we don't have separate manager device - thus the manager is NULL
> -and the consumer device ("dev" here) is what we use to manage GPIO.
>
> >
> > Doesn't that mean you just removed all resource management for this
> > call?
>
> No :)
>
> >
> > Or am I reading it wrong?
>
> Either you are reading it wrong or I am writing it wrong xD. In any
> case this means I need to drop few comments in code :) Thanks.

I was reading it wrong, so not your bad. I guess lack of focus on
my side, this part is fine!

Yours,
Linus Walleij
