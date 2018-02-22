Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43200 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeBVIVs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 22 Feb 2018 03:21:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180221213724.810-1-alexandre.belloni@bootlin.com>
References: <20180221213724.810-1-alexandre.belloni@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 09:21:47 +0100
Message-ID: <CAMuHMdUPJEf6-7GZQBnScgF-Kounj_QNjjR-_JjJJK+EqrpG8A@mail.gmail.com>
Subject: Re: [PATCH] m68k: time: stop validating rtc_time in .read_time
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On Wed, Feb 21, 2018 at 10:37 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thank you, will apply and queue for v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
