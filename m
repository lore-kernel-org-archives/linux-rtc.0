Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:54810 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeHUC5C (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 20 Aug 2018 22:57:02 -0400
Date: Tue, 21 Aug 2018 01:39:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTC for 4.19
Message-ID: <20180820233909.GY21707@piout.net>
References: <20180820212157.GA20956@piout.net>
 <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/08/2018 16:34:18-0700, Linus Torvalds wrote:
> On Mon, Aug 20, 2018 at 2:22 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Subsystem:
> >  - struct rtc_task removal along with rtc_irq_register/rtc_irq_unregister
> 
> You can still find stale mentions of it by grepping for it:
> 
>  * @task: currently registered with rtc_irq_register()
> 
> which should presumably be fixed up too.
> 

Ah right, I'll clean that up along with another suggestion from Arnd.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
