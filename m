Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:38490 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751408AbdGRRuJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 13:50:09 -0400
Message-ID: <1500400205.25934.27.camel@perches.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>
Date: Tue, 18 Jul 2017 10:50:05 -0700
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
> Recently I have noticed too many users of struct rtc_time that printing
> its content field by field.
> 
> In this series I introduce %pt[dt][rv] specifier to make life a bit
> easier.

Hey Andy.

I just saw a patch with a printk for rtc time from Mark Salyzyn.
https://lkml.org/lkml/2017/7/18/885

Any idea if you want to push this extension?

I like the concept and still think it could be extended a bit more.

from: https://lkml.org/lkml/2017/6/8/1134

My preference would be for %pt[type]<output style>
where <type> is mandatory and could be:

        r for struct rtc_time
        6 for time64_t
        k for ktime_t
        T for struct timespec64
        etc

and <output style> has an unspecified default of
YYYY-MM-DD:hh:mm:ss

Perhaps use the "date" formats without the leading
% uses for <output style> for additional styles.
