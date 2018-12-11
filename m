Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97131C07E85
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A73A2082F
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A73A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLKL2E (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:28:04 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46216 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeLKL2D (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Dec 2018 06:28:03 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so8627008vso.13;
        Tue, 11 Dec 2018 03:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PJC4Kudy9FFa/MVjT6iuOO0jPtxgCeHgVDgaZVrvUs=;
        b=S8CIoLLYLFCRZXU84/A3K0A23pe0H9EXp/T+nWRwwft8R6xEIywrLbpeYSmwtHoggh
         rTk/356/yzLXcniyTbhmkK93XK/QI+xjQ+hZH0LxXqkYcsk5IK6kSJfEYw3SRPoqXOL0
         GAed7QGFT8fmlT6H66eWC/lMYaZq/i7wJijjJmgzqT8S7G0nWeSTPV01hRZ4k67lmWaO
         FRneZ7hMaKq9+rOMr4ywo61XJkgcrrzZeG73ZRw4TamMxj2lvqRjyP4UPIVU9xWP5tnK
         3FcvczlakGUDxwsb/XgF38qCTmSbUG4pSSnOB4Ux6yiDkgMxWHR0AEhALFISLiWRihv0
         k2dw==
X-Gm-Message-State: AA+aEWaq3MkAvj/NdZZ/ryhbl03A8yxNiEMeyaK0Tg6tohFXrhmBYSGg
        B1+h6y+QT3QEN222BkXFrEshIym+IX1uCX1Gbsqemw==
X-Google-Smtp-Source: AFSGD/W4srn1vqRX1kPjiFU01SbRamRtcFQrE3pY7GoEt53o35QbGgvScNjZGmpld7CZ1Av/ltxuLqjmqgzN4G+Cm0o=
X-Received: by 2002:a67:d119:: with SMTP id u25mr6532410vsi.63.1544527682156;
 Tue, 11 Dec 2018 03:28:02 -0800 (PST)
MIME-Version: 1.0
References: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
 <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org> <OSBPR01MB210338DE328981500C6992F8B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdXraSz4dtBi0hzZ-w_goKiy_fObE0S-Vi6xQhSxHNnhqQ@mail.gmail.com> <43b3a03c-3739-94d2-c97d-c36999f04a9b@linaro.org>
In-Reply-To: <43b3a03c-3739-94d2-c97d-c36999f04a9b@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 12:27:49 +0100
Message-ID: <CAMuHMdWjRBCeNq7ZiCPd3xWC=S9gLO=-EfQ1WWN711LT+w=CzQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvmem: check invalid number of bytes in nvmem_{read,write}()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
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

Hi Srinivas,

On Tue, Dec 11, 2018 at 12:10 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> On 11/12/18 11:06, Geert Uytterhoeven wrote:
> >> I was trying with arm32 toolchain and compiler happy. Now tried with Arm64 toolchain, it provides a warning and the below typecast fixed the issue.
> >> if (unlikely(check_add_overflow(bytes, (size_t)offset, &new_bytes)))
> >>
> >> Does typecasting to (size_t)  fixed the issue in your environment? Please let  me know.
> > That's a side-effect of offset not being loff_t...
> check_add_overflow will expect all the params to be of same type, so
> changing to loff_t will not help too.

Right, it has separate checks for signed/unsigned additions, but
both parameter types must have the same signedness, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
