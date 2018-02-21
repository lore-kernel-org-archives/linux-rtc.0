Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24927 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754225AbeBUNXk (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 08:23:40 -0500
Message-ID: <1519219410.10722.25.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 21 Feb 2018 15:23:30 +0200
In-Reply-To: <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
         <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
         <1519170907.4326.17.camel@perches.com>
         <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 2018-02-21 at 08:38 +0100, Rasmus Villemoes wrote:
> On 2018-02-21 00:55, Joe Perches wrote:
> > On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > > There are users which print time and date represented by content
> > > of
> > > struct rtc_time in human readable format.
> > > 
> > > Instead of open coding that each time introduce %ptR[dt][rv]
> > > specifier.
> > > 
> > > Note, users have to select PRINTK_PEXT_TIMEDATE option in a
> > > Kconfig.
> > 
> > Not sure this is a great option.
> > Not just the name, the need to select it.
> 
> Bikeshedding first: If you do keep the config option, please use
> PRINTF,
> not PRINTK - vsprintf can be and is used by lots of code other than
> printk.

OK.

> Well, on the one hand, I like to reduce the size of the kernel when
> possible and ideally make all new functionality guarded by config
> options, but OTOH, how much does compiling out the datetime formatters
> really save?

https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html

I understand that half a year time allows us to increase kernel text
size by 750+ bytes unconditionally.

I would really like to not use any option.

>  Also, I agree with Joe's concern about the need to select
> it.

So, what exactly you are proposing?

>  Maybe if we had a gcc plugin that did %pFOO validation it could also
> warn about %pBAR being used without a corresponding config option
> being
> set. But we don't have that currently...

We have not, so, it's out of scope. If it's a big impediment, then I'm
not the guy who will do the job.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
