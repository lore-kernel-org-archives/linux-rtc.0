Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B9C282D8
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E608120869
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 21:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKT0O4T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfBAV3j (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:29:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38631 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAV3j (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 1 Feb 2019 16:29:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so6140965lfk.5
        for <linux-rtc@vger.kernel.org>; Fri, 01 Feb 2019 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtDWYmsxT4kwUM3LS8H9BUoDfHtJKV77JwRZlR/rdyw=;
        b=RKT0O4T9lxQfrQ2pHjyHWYXcuzrobtfomIiYylJxbg0aYqV7BNbSbeRGF5xkye/YI9
         G+I2rpdEDs9F0tcevmcH/In0WsJTht3VAHdETAF6Rkd6XL5/6tDJokRxnAI0Ir/6mEMC
         AEDw9bsLU+fjYDK4MXoIwWED1h4ZwOwtWMAVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtDWYmsxT4kwUM3LS8H9BUoDfHtJKV77JwRZlR/rdyw=;
        b=oeuK/dxDxovRx43PHYXKyEXnnpMcaL+7D8s0wumwvNMZw0GAhJLZE9djHz4SJ9dB97
         VbgkC0NAwy4pasimfrCe6ONRDfzOFwI3CnzbPbzZiyIvcmHCnpePKMV32Q+bcVCq8FTS
         OeHOFR15aTpd9WjeWlqywtisuPjEKvGo92d+eeG6EoxwoKntjBj4baWGvTKks1dNg2PO
         XbNhE2ruaPhSboRN2laVhUEZLbF2+mG0x5Ny5RxATXOFIsQFGDSKP2O3Kz/ytdLPR5O1
         OuWxo/KFnp5rvBpHeFqq0ZL6lt6Px8nrwF3sgsT/+4RS3cgIeK5rd69appIHIW7Hd0t3
         zkBg==
X-Gm-Message-State: AHQUAuaDrxLFQlisRNowp2yrhG1UkJxUXuZAmCE/N4dG6+dp0fXphyw5
        sFN8W4zezBhnAZQ7BiTEYsdsFV7k+LUxD+8lrqG74w==
X-Google-Smtp-Source: AHgI3IaY8T/kle5a7njLZ5A9F/irSnc6QzAL+Jahhx5CFMw9sj/6nPyN61nSCOdlEgaVjEjBrZfZcijd83BBatqV+ME=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr880002lfl.129.1549056575988;
 Fri, 01 Feb 2019 13:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20190131150642.26289-1-linus.walleij@linaro.org>
 <20190131150642.26289-2-linus.walleij@linaro.org> <20190131153012.GA15115@piout.net>
 <CACRpkdZY9jnJMx=oMnmG4Kj+kUmziiJ8D3M85awnAC=jNDt50g@mail.gmail.com> <20190201141306.GA3289@piout.net>
In-Reply-To: <20190201141306.GA3289@piout.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Feb 2019 22:29:23 +0100
Message-ID: <CACRpkdac8KUifhyvEqBMea974sM4kRmC8g_PJ-Z2zKkPsPTtEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: x1205: Add DT probing support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

On Fri, Feb 1, 2019 at 3:13 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 01/02/2019 13:22:57+0100, Linus Walleij wrote:

> > In the earlier implementations of device tree it was done
> > such that the device node would match the i2c name and
> > then the device would probe, such that if I in my device
> > tree name it:
> >
> > x1205@6f {
> >     reg = <>;
> > };
> >
> > Then the core will see match that node name to the i2c
> > device name. (I think this goes way back, possibly to the
> > earliest Open Firmware.)
> >
> > However the DT maintainers have more and more pushed
> > for DT nodes to have functional name, so this would then
> > be named:
> >
> > rtc@6f {
> >     reg = <>;
> > };
> >
> > And then it stops working.
> >
> > I think Lee Jones added the compatible probing to a bunch
> > of I2C devices for this reason.
> >
>
> Well, that is not what I was referring to.

Oh sorry for my ignorance, it's the only mechanism I ever
heard of...

> You could use:
>
> rtc@6f {
>      compatible = "xircom,x1205";
>      reg = <0x6f>;
> };
>
> And this would already probe without having an of_device_id table
> because the i2c core is matching the compatibles with the i2c_device_id
> table.

Oh interesting! There is some code in i2c-core-of.c that strips the "vendor,"
part and matches on the last part of the compatible, but it is named
i2c_of_match_device_sysfs() so one think it only apply to devices
added through sysfs. But indeed seems to be used for everything.

That's a neat trick!

Yours,
Linus Walleij
