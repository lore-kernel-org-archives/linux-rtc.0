Return-Path: <SRS0=JUId=RY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC21C43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655120850
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCUJwH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:52:07 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46628 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfCUJwH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Mar 2019 05:52:07 -0400
Received: by mail-vk1-f196.google.com with SMTP id x2so1213473vkx.13;
        Thu, 21 Mar 2019 02:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfXC97scgE5/WSTfWZCZ+LptrPYQs6I5IlaeA1QxGo8=;
        b=oX1qc5OjsGpMhLd2NtSo1Ah7rziqnQ2uyrb7McfmfqMsA0NeByf6TatvmS3u0PIpwU
         mQV/DpfMkH+xizUYdFCt4W34g4wd0lSHARMlAs+yCWO/rRNnka01q7HyywLnSd3hhi+q
         4OF774UEooVfh4brDy1BV5OMCyaRuhKqnEsIsKB5GtqP/MTFm5SvwS5lW6+Cjy8OHklF
         ID1Od1NcPV8uAadLgJ+/v00WYqbXvV76st65xYhtS75BnuohhL0Uqnx6AAceFHjEW+br
         EA0xH70zskcttG2Btgw89GV0e52/mrn9SZ9PobGIsbCWpYAa0+YHH3mQ4qP1Yin+CzLS
         wbkg==
X-Gm-Message-State: APjAAAUBTDujwMCBE9WPL2TQlbcBBGKdZLjbUar8hn9ZNYQ/j0QmTPFD
        pujk1nmbke/QgXEkDkTV+CPMtMAugco0WpT6V5lM5i6j
X-Google-Smtp-Source: APXvYqypV501n3ej3LaNzKxFwflLxYx3Q5/ghUEw9KgiFawhSPEAT21owLSVpTTHjJ9ULyOdC43FIPeUwPKzUMMkxPk=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr1573355vke.40.1553161925699;
 Thu, 21 Mar 2019 02:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com> <20190320113010.8955-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190320113010.8955-2-alexandre.belloni@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Mar 2019 10:51:53 +0100
Message-ID: <CAMuHMdUR5kHvENvVFTup33Mrz28Yxdr9XxUcOHrXg4ZC7R8Maw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: sh: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Mar 20, 2019 at 12:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The IRQ is requested before the struct rtc is allocated and registered, but
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
>
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> struct before requesting the IRQ.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
