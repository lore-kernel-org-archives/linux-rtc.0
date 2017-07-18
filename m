Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32637 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdGRR45 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 18 Jul 2017 13:56:57 -0400
Message-ID: <1500400523.29303.92.camel@linux.intel.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>
Date: Tue, 18 Jul 2017 20:55:23 +0300
In-Reply-To: <1500400205.25934.27.camel@perches.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <1500400205.25934.27.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-07-18 at 10:50 -0700, Joe Perches wrote:
> On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
> > Recently I have noticed too many users of struct rtc_time that
> > printing
> > its content field by field.
> > 
> > In this series I introduce %pt[dt][rv] specifier to make life a bit
> > easier.
> 
> Hey Andy.
> 
> I just saw a patch with a printk for rtc time from Mark Salyzyn.
> https://lkml.org/lkml/2017/7/18/885

Same!

> Any idea if you want to push this extension?

Yes, just really lack of time for everything.

I like the idea to make it conditional (config BLABLABLA). It will
address some comments about footprint for no users.

> I like the concept and still think it could be extended a bit more.
> 
> from: https://lkml.org/lkml/2017/6/8/1134
> 
> My preference would be for %pt[type]<output style>
> where <type> is mandatory and could be:
> 
>         r for struct rtc_time
>         6 for time64_t
>         k for ktime_t
>         T for struct timespec64
>         etc

I dunno about this.

However, I like this more than do conversion in each case where input
reference has different type.

> and <output style> has an unspecified default of
> YYYY-MM-DD:hh:mm:ss

I'm against this, sorry. Too many variations for almost no use (users).

> Perhaps use the "date" formats without the leading
> % uses for <output style> for additional styles.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
