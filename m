Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76637C282D8
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEDD218F0
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 12:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACVTDDaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfBAMXM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:23:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40959 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfBAMXL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 1 Feb 2019 07:23:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so4900491lfe.7
        for <linux-rtc@vger.kernel.org>; Fri, 01 Feb 2019 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+O+qgXvEEWxsKX/e4PNl7wBRh6fKqx1G/yRp4dSHzwM=;
        b=ACVTDDaOzLFtQ9EiKV6MhwTb2W0ib4FvjRrsgrM/KrcWYU506pT2gGMzu0LSDZd+Mn
         YF7ihkmuE6a6bB7CxZeAxfJqZyaRFLho9cgaT0QiVif3TY2rGudwxs8z1h1LfkHzht4E
         LdG4aqvqhVNy5ijeuA97ufpvH6pWdUYGAhyPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+O+qgXvEEWxsKX/e4PNl7wBRh6fKqx1G/yRp4dSHzwM=;
        b=cgzA2hde2xzu7VW/kbRFevWAVLx44E9SiMWOMG3XzFAlGsKUxGgNDt/5nB0GVZZxJa
         BZz/WBgVCWb48T34fxlYA2f5/A3JPR+uyz+sO+XlnFkPrdxutKmX8rD7oLRZKDZm6wUc
         bIIWpD38XIJWf0CEx60TCSX9jPMi1aOun/8OT4ahGO5HW1LdsGksdNkPo0uN4N//XiSN
         UpmhmYsXXPRixjuVQzRKniECzK4LLi37WkaJMO+65hzxTztjXyOwFRkHYIlmPGiNUwlb
         UBd6Gy46UR1+CPzHKEUAOGga42uAOEcFxnHWxHxMyk3p81sSM5ROqA3eJM0ufU3tDV7R
         l1FQ==
X-Gm-Message-State: AJcUukfc0yMWke5l6LVpf18r7WY6ZM0f9ZipQM/KzG97gGps3EHjrb4M
        HzJC35gmajcit/mis0C2RkWQ3yqDhAuJvo+WEzSWq0Rt
X-Google-Smtp-Source: ALg8bN5ppFCM0K/d3EVuoTSZBn/+DSbiIiSrZ32LMlsde+1e9qQpkLgnGPzi3CTNCNCJCoKYMh53xxSZrPmtB9F+Gho=
X-Received: by 2002:a19:8096:: with SMTP id b144mr29679262lfd.8.1549023789552;
 Fri, 01 Feb 2019 04:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20190131150642.26289-1-linus.walleij@linaro.org>
 <20190131150642.26289-2-linus.walleij@linaro.org> <20190131153012.GA15115@piout.net>
In-Reply-To: <20190131153012.GA15115@piout.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Feb 2019 13:22:57 +0100
Message-ID: <CACRpkdZY9jnJMx=oMnmG4Kj+kUmziiJ8D3M85awnAC=jNDt50g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: x1205: Add DT probing support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Jan 31, 2019 at 4:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 31/01/2019 16:06:42+0100, Linus Walleij wrote:

> > This makes it possible to probe the X1205 RTC from the
> > device tree. This is needed when adding device tree boot
> > support for the IXP4xx-based NSLU2 which has this RTC.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/rtc/rtc-x1205.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
> > index f08f18e4fcdf..c2b64c9363da 100644
> > --- a/drivers/rtc/rtc-x1205.c
> > +++ b/drivers/rtc/rtc-x1205.c
> > @@ -673,9 +673,15 @@ static const struct i2c_device_id x1205_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, x1205_id);
> >
> > +static const struct of_device_id x1205_dt_ids[] = {
> > +     { .compatible = "xircom,x1205", },
> > +};
> > +MODULE_DEVICE_TABLE(of, x1205_dt_ids);
> > +
>
> I think this is not necessary and this will probe without the
> of_match_table but it doesn't hurt either.

In the earlier implementations of device tree it was done
such that the device node would match the i2c name and
then the device would probe, such that if I in my device
tree name it:

x1205@6f {
    reg = <>;
};

Then the core will see match that node name to the i2c
device name. (I think this goes way back, possibly to the
earliest Open Firmware.)

However the DT maintainers have more and more pushed
for DT nodes to have functional name, so this would then
be named:

rtc@6f {
    reg = <>;
};

And then it stops working.

I think Lee Jones added the compatible probing to a bunch
of I2C devices for this reason.

Yours,
Linus Walleij
