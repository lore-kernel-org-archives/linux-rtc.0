Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40192 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHWQh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 8 Sep 2018 18:16:37 -0400
MIME-Version: 1.0
References: <20180828142724.4067857-1-arnd@arndb.de> <20180828142724.4067857-2-arnd@arndb.de>
 <20180908081710.GA2598@piout.net>
In-Reply-To: <20180908081710.GA2598@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 8 Sep 2018 19:29:50 +0200
Message-ID: <CAK8P3a3V64f1QTOJ0qk3gOnMk=VkHPQBJZmhVsOUNDPGVrmUOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: move compat_ioctl handling into rtc-dev.c
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, Sep 8, 2018 at 10:17 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 28/08/2018 16:26:31+0200, Arnd Bergmann wrote:
> > We no longer need the rtc compat handling to be in common code, now that
> > all drivers are either moved to the rtc-class framework, or (rarely)
> > exist in drivers/char for architectures without compat mode (m68k,
> > alpha and ia64, respectively).
> This doesn't apply on v4.19-rc1, can you rebase?

I must have based it  on top of another compat_ioctl.c change that I sent.

Independently, I also sent a longer series of changes to Al now, which also
need to be rebased. I'd suggest that you just keep the Kconfig change for
MIPS then (or offload that to its arch maintainers), and I'll add the RTC patch
to the series for Al instead.

        Arnd
