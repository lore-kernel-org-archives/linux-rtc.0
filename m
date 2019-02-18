Return-Path: <SRS0=BFTo=QZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE527C43381
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Feb 2019 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82AE2184A
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Feb 2019 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNAh/8Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfBRP5q (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:57:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44740 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfBRP5q (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Feb 2019 10:57:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so19635710qte.11;
        Mon, 18 Feb 2019 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsCe8gaHwKZCpenPYEnD2OugMIS3sY66jY+g5JLrzN0=;
        b=hNAh/8Q4XHddl2u1zi6hGAvaeBr0JwFCXwd3QOvJW2BNVWXNY87T97d1uEx2oS6Nr7
         uXWIbcH7MOlkpdXZbWjb4tQUMj3hgKZRUtCWCDN+jOS1pb3Fir6lZcSR09BezhFc0MqD
         PRQFp42Xdo+LCyc7XbkoDWL9Plwsblxff5Zg8pdisMNpitX9Dmt5NKzvTdUkXhRJSJ7F
         qVEi+bEOnzc5fY3cWLoeH/j8HLvBjvb1BaexyKT+y0w6H0QTmzOCmW1SN0a0Cw1L/yXA
         d8KwMnK31+1ymT3YMb+ptiSXABK3IMUPG2KniXl4SPJCqpvtwl0c1tYjfP0DOXW8xNo+
         +yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsCe8gaHwKZCpenPYEnD2OugMIS3sY66jY+g5JLrzN0=;
        b=Bzys8fH8YAA+v07OF4Nx7EtnxedSVlk++g6pn3kKP8NyFQ08b3/XTjTaNAv/0i1txN
         GqGdIz3oRvabF/SH5O4VY734SNKR3rnOMYGHMuNXfgdFcJiO6RaLGeB9Ys1RUeVF+XHA
         QZuxWQA+hS2InIRsfKdfA64HgnzE46ykeJYR0QuHepNWajaZP4JxLXZhQm9XYO0MWz/5
         UbIPZa+QMtF3WmKkTzncfIe3g/NHLJBjyTNmzR2mpMmvjVbxpA81vG54K2rn7fFpqPa/
         Xs3PvI6ZcXF2Eb9gZ91dB1YMnoMvMuDBS0Ke7QVumf+x0eqqATh5PtbDk6MFQNf+cWTF
         YpCw==
X-Gm-Message-State: AHQUAuZDWY6tMAxvyX83G2dRte+LvvkNh2s1d+Vu1UH77Siu+ozroIJe
        JdX7STv0mLLnLds9xtdIdiOhrmOhktd/PM/Pfm8=
X-Google-Smtp-Source: AHgI3IY1YWLu1QmVIZJAWQBi+7YYIlstOULTd+akUqsVIdVCnIpa6NO3Xx2BhiaU3yJcsnkgCPQ07W7NJHjrELr2Mqw=
X-Received: by 2002:ac8:2214:: with SMTP id o20mr19264382qto.170.1550505464646;
 Mon, 18 Feb 2019 07:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20190216013603.117969-1-weiyongjun1@huawei.com> <20190218144827.GU10129@piout.net>
In-Reply-To: <20190218144827.GU10129@piout.net>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 Feb 2019 16:57:33 +0100
Message-ID: <CAFqH_52DG+2=O5YQuOpJ3VMdAAu+UwjJ0_oyEthbbYZ9XgG8Zg@mail.gmail.com>
Subject: Re: [PATCH -next] rtc: wilco_ec: Make some functions static
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Nick Crews <ncrews@chromium.org>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Missatge de Alexandre Belloni <alexandre.belloni@bootlin.com> del dia
dl., 18 de febr. 2019 a les 15:48:
>
> Enric,
>
> You should take that one or squash it with the original commit.
>

Ok, thanks. If Wei doesn't mind I'd like to squash as this is still for-next.

> On 16/02/2019 01:36:03+0000, Wei Yongjun wrote:
> > Fixes the following sparse warnings:
> >
> > drivers/rtc/rtc-wilco-ec.c:72:5: warning:
> >  symbol 'wilco_ec_rtc_read' was not declared. Should it be static?
> > drivers/rtc/rtc-wilco-ec.c:106:5: warning:
> >  symbol 'wilco_ec_rtc_write' was not declared. Should it be static?
> >
> > Fixes: 79c4ec4869b5 ("platform/chrome: wilco_ec: Add RTC driver")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/rtc/rtc-wilco-ec.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > index 35cc56114c1c..e62bda0cb53e 100644
> > --- a/drivers/rtc/rtc-wilco-ec.c
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -69,7 +69,7 @@ struct ec_rtc_write {
> >       u8 weekday;
> >  } __packed;
> >
> > -int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> > +static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> >  {
> >       struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> >       u8 param = EC_CMOS_TOD_READ;
> > @@ -103,7 +103,7 @@ int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> >       return 0;
> >  }
> >
> > -int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
> > +static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
> >  {
> >       struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> >       struct ec_rtc_write rtc;
> >
> >
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
