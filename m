Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934938AbdGTKWh (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 20 Jul 2017 06:22:37 -0400
Message-ID: <1500546142.29303.133.camel@linux.intel.com>
Subject: Re: [PATCH v1 01/25] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Date: Thu, 20 Jul 2017 13:22:22 +0300
In-Reply-To: <87shjakxg1.fsf@rasmusvillemoes.dk>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <20170608134811.60786-2-andriy.shevchenko@linux.intel.com>
         <87shjakxg1.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-06-08 at 22:59 +0200, Rasmus Villemoes wrote:
> On Thu, Jun 08 2017, Andy Shevchenko <andriy.shevchenko@linux.intel.co
> m> wrote:
> > The pointer can't be NULL since it's first what has been done in the
> > pointer().
 
> > -	if (ZERO_OR_NULL_PTR(addr))
> > -		return string(buf, end, NULL, spec);	/* NULL
> > pointer */
> > -
> > -
> 
> Well, ZERO_OR_NULL_PTR checks for a little more than !addr, but I
> suppose that if anyone passes the result from kmalloc(0) to %ph,
> they'd
> better also pass 0 as the size, so the .field_width tests should be
> sufficient.

If we care about kmalloc(0) check we better to do this in pointer()?

> > -	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> > -		return string(buf, end, NULL, spec);
> > -
> 
> Well, it may be safe, but removing the IS_ENABLED(CONFIG_HAVE_CLK)
> check
> means that clock() becomes a much bigger function when
> !IS_ENABLED(CONFIG_HAVE_CLK).

I return back this in v2.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
