Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47646 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933532AbeBUNTl (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 08:19:41 -0500
Message-ID: <1519219174.10722.21.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
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
Date: Wed, 21 Feb 2018 15:19:34 +0200
In-Reply-To: <1519170907.4326.17.camel@perches.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
         <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
         <1519170907.4326.17.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2018-02-20 at 15:55 -0800, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > There are users which print time and date represented by content of
> > struct rtc_time in human readable format.
> > 
> > Instead of open coding that each time introduce %ptR[dt][rv]
> > specifier.
> > 
> > Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Not sure this is a great option.
> Not just the name, the need to select it.

kbuildbot and some people complained about + text size.
https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html

I would really like to compile it always.

> > +	int year = tm->tm_year + (r ? 0 : 1900);
> > +	int mon = tm->tm_mon + (r ? 0 : 1);
> 
> What happens with negative values?

Same as before.

> Perhaps these temporaries should be unsigned int.

No, the type of them is int, so, I'll keep it int.

> > +	if (unlikely(v && (unsigned int)tm->tm_min > 59))
> 
> leap seconds are allowed in the struct

Alexandre answered already, but I would add that this is part of
existing ABI, so, I wouldn't go to change this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
