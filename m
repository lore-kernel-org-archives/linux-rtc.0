Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586D92083D
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 10:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586D92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLGKTE (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:19:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38761 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKTD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 05:19:03 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so2141906vsa.5;
        Fri, 07 Dec 2018 02:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+ggU0aODdLCyyGDUufV+wSqPiPefp5EkbLYasaRUEk=;
        b=UI8py0eIIZ/KbgIc8lZ7VSrIvlF1rsPD0D41c8mGI3qddu4fGzmrTbjQbzwjrAb3ly
         qb5Yu+WEIi0M6gTEQBifuuc/iRi2hPld93T0KNWpJl/CaxKAmKqVEIyCvmX/92aegSDW
         +hmFw2Y5PPN0CAA17gkbLP3rHKL2a4TdEdFlju/NRYnf1rNNB7Q86MeMZUz6Rs0hSebg
         +vdDGWQkgTxiAWJ/eu1CAczIY99vqSljjmOKR4JAEssj7xUWi3TBULFek80rvVbkN/ba
         on255N+KNpMSPr/ymmPE4PMEwHuYOTPdMfpSU8hL0pFOia9EMFzxekLDI/zmXFd2UKDH
         kqlw==
X-Gm-Message-State: AA+aEWYaofyGVn+TWmTAxnrg7XJrUuJ1q1XXVm7Hh0P9uzYk3PvTEiVx
        7qRoam/h/ntuMlhePE7WCejMoo4yMaFMkRafMkw=
X-Google-Smtp-Source: AFSGD/WCJYe5sFssoLYbEtJbycZaV1jgfZZeAsTN9NYLlr/mvGYI8oEuNfO9RbAxQhoefEcEkBM08HU0QhZfO4t3C3Y=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr668404vsm.152.1544177942324;
 Fri, 07 Dec 2018 02:19:02 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
 <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
 <OSBPR01MB2103A13E75634AD81CFD1628B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20181206165202.GC8952@piout.net> <OSBPR01MB2103D626F5A58D86D726E721B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdUXPPEqKiXC6reGkEUUAMUEK5Ku+zbDv0BS7KMVUYQGhQ@mail.gmail.com> <OSBPR01MB21030916075015094519D0F2B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB21030916075015094519D0F2B8AA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Dec 2018 11:18:50 +0100
Message-ID: <CAMuHMdVkWw-nrnTB-v8788fT74q9xU3EQAcma3zzZ57aL4HNVg@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 11:16 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
> > On Fri, Dec 7, 2018 at 10:34 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > > > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP
> > > > pcf85263 rtc
> > > > I think it is probably better to ensure the nvmem core never passes
> > > > an invalid number of bytes. All the ther RTC drivers make that
> > assumption.
> > >
> > > In that case, I will do following checks in
> > > nvmem_device_{read,write}() before calling nvmem_reg_{read,write}(),
> > >
> > > nvmem_device_read
> > >
> > > /* Stop the user from reading */
> > > if (offset  >= nvmem->size)
> > > return 0;
> > >
> > > if (bytes == 0)
> > > return -EINVAL;
> >
> > Why not 0?
>
> Ok. Will merge with above check.
>
> if ((offset  >= nvmem->size)  && (bytes == 0))

"||" ;-)

>         return 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
