Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35483 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNQyq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Mar 2018 12:54:46 -0400
Date: Wed, 14 Mar 2018 09:54:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20180314165442.GB74407@dtor-ws>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
 <1519221748.10722.34.camel@linux.intel.com>
 <1519221953.10722.38.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519221953.10722.38.camel@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Feb 21, 2018 at 04:05:53PM +0200, Andy Shevchenko wrote:
> > TBH, I don't see much consensus among developers on this topic.
> > I wouldn't like to send a new version until it would be a consensus.
> 
> I would love to see the comments followed by an agreement from majority
> of people who are in Cc list here.

Not sure why I am on the CC list, but if we add it at all I do not think
this should be guarded by a config option. Otherwise let's add options
for %d and %s as well.

Thanks.

-- 
Dmitry
