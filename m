Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F50C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB2D208E7
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 09:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB2D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLGJpx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:45:53 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36151 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJpw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 04:45:52 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so1190845uap.3;
        Fri, 07 Dec 2018 01:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1dpH5I6y+rx7cUgcpMyKTVoH8JfxE6o7hsrxgMTNsI=;
        b=cVUPe1/Y+l/g5TS6xiWxHOAqOVyBJ4sRwLOcXXK1blt3WQTz5RRrvF66UW+PI9zJ2M
         pBOnet/aycBd9ZLHHuxFBW7p5FLDAsFzN9XL+/P3izLQtU3z2aOQ07qDeI0HK3kQ7s1S
         0NiI2/h73+QBQf0zO5CdKroKfSOS/VIgDxjaoejldmIHsqeLrfq2VfQWMsEnhc48A81B
         ViFJNLgsRYG1Rt5Q/nq1uKvTAFh5yQCQZJkDJXOrp4kWHOdO412lM+74zKyku+DQEWrs
         vX60TWDKeSkx6RWLpzMvfrHrFq0JDw0Gix6w5PJ9FFW2z8MaxAVnJ5oeFznCcymVMo9b
         BBdA==
X-Gm-Message-State: AA+aEWZQNYguwa5CWYPXriLl8MbACdJwMd34hVDwnSDjWqPZ/ThuYZGC
        vog0uH7c25GsMxkeJ9bqRr8JLOp1g29uXRUI3/k=
X-Google-Smtp-Source: AFSGD/XpwnzwOIoAKeFp/VQNzB/7lA27+lawnHlBLMOkUJ2VXGLo8pVZpDxDWTdfUEmJGWihWKP7ZK/2oHv2Op8YZO8=
X-Received: by 2002:ab0:465:: with SMTP id 92mr627871uav.28.1544175951390;
 Fri, 07 Dec 2018 01:45:51 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
 <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
 <OSBPR01MB2103A13E75634AD81CFD1628B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20181206165202.GC8952@piout.net> <OSBPR01MB2103D626F5A58D86D726E721B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2103D626F5A58D86D726E721B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Dec 2018 10:45:38 +0100
Message-ID: <CAMuHMdUXPPEqKiXC6reGkEUUAMUEK5Ku+zbDv0BS7KMVUYQGhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

On Fri, Dec 7, 2018 at 10:34 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
> >
> > On 06/12/2018 15:49:57+0000, Biju Das wrote:

> > > > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP
> > > > pcf85263 rtc

> > > > On Thu, Dec 6, 2018 at 4:24 PM Biju Das <biju.das@bp.renesas.com>
> > wrote:
> > > > > > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP
> > > > > > pcf85263 rtc CC nvmem maintainer
> > > > > > Given bytes should be 1, val should be a pointer to a single byte...
> > > > > > What if bytes == 0?
> > > > >
> > > > > I doubt we get "bytes==0" because of the checks in "
> > > > drivers/nvmem/core.c"
> > > > > Function " bin_attr_nvmem_read/ bin_attr_nvmem_write".
> > > >
> > > > Depends. There are other functions calling nvmem_reg_{read,write}(),
> > e.g.
> > > > nvmem_device_{read,write}().
> > >
> > > OK. In that case, I will return (-EINVAL)  for "bytes !=1"
> >
> > I think it is probably better to ensure the nvmem core never passes an invalid
> > number of bytes. All the ther RTC drivers make that assumption.
>
> In that case, I will do following checks in nvmem_device_{read,write}() before calling nvmem_reg_{read,write}(),
>
> nvmem_device_read
>
> /* Stop the user from reading */
> if (offset  >= nvmem->size)
> return 0;
>
> if (bytes == 0)
> return -EINVAL;

Why not 0?

>
> if (offset + bytes > nvmem->size)

This might overflow, please use check_add_overflow().

> bytes = nvmem->size - offset;
>
> nvmem_device_write
>
> /* Stop the user from writing */
> if (offset  >= nvmem->size)
> return -EFBIG;

ENOSPC?

+ same comments as for read.

Oh, and offset is unsigned int instead of loff_t.
Nobody's envisioning nvmem devices larger than 4 GiB?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
