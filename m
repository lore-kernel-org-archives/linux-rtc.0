Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36087 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUCwJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 20 Aug 2018 22:52:09 -0400
MIME-Version: 1.0
References: <20180820212157.GA20956@piout.net>
In-Reply-To: <20180820212157.GA20956@piout.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Aug 2018 16:34:18 -0700
Message-ID: <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 4.19
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Aug 20, 2018 at 2:22 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Subsystem:
>  - struct rtc_task removal along with rtc_irq_register/rtc_irq_unregister

You can still find stale mentions of it by grepping for it:

 * @task: currently registered with rtc_irq_register()

which should presumably be fixed up too.

That's not holding me from doing the pull, but I thought I'd mention it.

               Linus
