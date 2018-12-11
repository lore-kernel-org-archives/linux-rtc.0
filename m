Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD097C07E85
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EA220811
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EA220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLKLGa (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:06:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38960 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeLKLGa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Dec 2018 06:06:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so8598135vsi.6;
        Tue, 11 Dec 2018 03:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgH0qSVgPES6O9AI3BZZnUjZMrJrNbM9MFUSIgO7L24=;
        b=sS/bvId7ybKLL5UQv1oj+WcClbpD/KHcTSsVyAI4WN3wIjohCCSS12mSt1Z+WzEQQ7
         sK/0YkGiVZxCdlpUlcBPptYIQHpH9c04Slf9gDfK6k2+uDM54sntmpFDRZuxRDOQykzv
         tJO6C5ott6ufhkSQpNXPPaGF090B/YZdyfRC+yj+FPtPcHUfMyMKNnCQdjg76H/28HH4
         mLZaANC4rOjrCrW0yxK+A2Geho6chKD8ZSv4KP3bH9+Y54mOqVE8axx37mt/UA7YgaYg
         i/L6U9TSsq/clF8KxFwig4ou+3n5eOwxB/1XDGMa2kojwTJ5PV+F3iCYG4po+mDvItbk
         YjHA==
X-Gm-Message-State: AA+aEWYpPDA/UVmpFBOteCAFLOhIpd+90TeE/wDMrRvOQ3RxQuA4T8pi
        auR+Jj5mc3NDzMs6yvA6yG9CjGz884Fe2tiNzyI=
X-Google-Smtp-Source: AFSGD/WimesFOTQFHSF4DEQGLHtTNs9W+sQiGH3YZbj0ttzF4QIfcmG+/CCEYssLIlX5fHkmdFmrIsxzlBvYNlftJ3c=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr7207216vsm.152.1544526389481;
 Tue, 11 Dec 2018 03:06:29 -0800 (PST)
MIME-Version: 1.0
References: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
 <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org> <OSBPR01MB210338DE328981500C6992F8B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB210338DE328981500C6992F8B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 12:06:17 +0100
Message-ID: <CAMuHMdXraSz4dtBi0hzZ-w_goKiy_fObE0S-Vi6xQhSxHNnhqQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvmem: check invalid number of bytes in nvmem_{read,write}()
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-rtc@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

On Tue, Dec 11, 2018 at 11:55 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3] nvmem: check invalid number of bytes in
> > nvmem_{read,write}()
> >
> > After applying this patch I get below errors with W=1 C=1
> >
> > On 11/12/18 09:24, Biju Das wrote:
> > > +if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
> > > +return -EOVERFLOW;
> > >   drivers/nvmem/core.c:82:13: error: incompatible types in comparison
> > expression (different type sizes)
> > drivers/nvmem/core.c:82:13: error: incompatible types in comparison
> > expression (different type sizes)
> > drivers/nvmem/core.c:113:13: error: incompatible types in comparison
> > expression (different type sizes)
> > drivers/nvmem/core.c:113:13: error: incompatible types in comparison
> > expression (different type sizes)
>
> I was trying with arm32 toolchain and compiler happy. Now tried with Arm64 toolchain, it provides a warning and the below typecast fixed the issue.
> if (unlikely(check_add_overflow(bytes, (size_t)offset, &new_bytes)))
>
> Does typecasting to (size_t)  fixed the issue in your environment? Please let  me know.

That's a side-effect of offset not being loff_t...
I think that should be fixed first, else you will forget about
removing the cast later
("casts are evil").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
