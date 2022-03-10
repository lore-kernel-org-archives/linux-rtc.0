Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65672C433F5
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Mar 2022 12:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiCJMTj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiCJMTj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 10 Mar 2022 07:19:39 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EB31206;
        Thu, 10 Mar 2022 04:18:36 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id z66so4161453qke.10;
        Thu, 10 Mar 2022 04:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxEoIGn264sRGsg/HhT4YP64PVzy4oCfplaz7ZY6sjU=;
        b=dXa5AU/tirvXdCQwFhdfoDiFMa4R8yfFzie20/k+jBYnhTvL1zzETtK+Y8zR2rP3ma
         EjYjhRqCTmTFT5NAG21hpg5XSCFTPobCsYBMSBNAiJzb5lVeFWFz9f3W+/v/dLR6VPXx
         z/QJ0gN2XXVdzVOzSh+2xxsVM2XMlY5RA4RvYnkOckqNTkIWF1tYsrH1KWDsE9KrD+T9
         KqDXxJATmn1zpSCMeenhwIzXnNalVFXUIaU4hiAfzHr5pu8MwcVUHzUqfeiXEfZpzJwd
         Yl1j+ExFG+iX44nkiQ7jnzXMTba0JMrznDLinVyCprXRO9tv4hiRKsEya5XQQuxWThzm
         hAgg==
X-Gm-Message-State: AOAM5319RVbMuJX7q7jvRMQl0cPoO/F/YETh/qcYzYwV12nwC0GoIi7D
        9RVBvzVVNrQKXbifipX93VCz6Q2hrpclAA==
X-Google-Smtp-Source: ABdhPJxyvXJR7lz1gqD1TOuirSzLwNgwDmCCk6wCujypzVHS+UCXc6KkeEZJXqwQSkSXvuUQPFCDSw==
X-Received: by 2002:a37:9346:0:b0:67b:128f:4696 with SMTP id v67-20020a379346000000b0067b128f4696mr2735006qkd.442.1646914714702;
        Thu, 10 Mar 2022 04:18:34 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 13-20020ac84e8d000000b002e068382bf8sm3056848qtp.63.2022.03.10.04.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:18:34 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dc0364d2ceso55474357b3.7;
        Thu, 10 Mar 2022 04:18:33 -0800 (PST)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr3691051ywb.132.1646914713434; Thu, 10
 Mar 2022 04:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20220310090048.1933020-1-laurent@vivier.eu> <20220310090048.1933020-6-laurent@vivier.eu>
In-Reply-To: <20220310090048.1933020-6-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 13:18:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGa8JAB4HZ303qy6BSadV0NVy-ZvhxMtj8ENavM8sHLw@mail.gmail.com>
Message-ID: <CAMuHMdUGa8JAB4HZ303qy6BSadV0NVy-ZvhxMtj8ENavM8sHLw@mail.gmail.com>
Subject: Re: [PATCH v15 5/5] m68k: introduce a virtual m68k machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Mar 10, 2022 at 10:01 AM Laurent Vivier <laurent@vivier.eu> wrote:
> This machine allows to have up to 3.2 GiB and 128 Virtio devices.
>
> It is based on android goldfish devices.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Please include tags given on previous versions:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
