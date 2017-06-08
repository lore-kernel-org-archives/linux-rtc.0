Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:35200 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751392AbdFHXJ3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 19:09:29 -0400
Message-ID: <1496963363.1929.22.camel@perches.com>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
Date: Thu, 08 Jun 2017 16:09:23 -0700
In-Reply-To: <CAHp75VfeyGH9wHmvcmJN9M8GNfG0iXTNO_wacsr+9SZ2CUJxYA@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
         <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
         <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
         <CAK8P3a3P4rDqQaNmBR9C9nF3VCqcQOH06Nq8RyDHsNfc0Ms13g@mail.gmail.com>
         <CAHp75VfeyGH9wHmvcmJN9M8GNfG0iXTNO_wacsr+9SZ2CUJxYA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-06-08 at 21:02 +0300, Andy Shevchenko wrote:
> On Thu, Jun 8, 2017 at 6:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jun 8, 2017 at 4:55 PM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jun 8, 2017 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Jun 8, 2017 at 3:47 PM, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > I really like the idea, and the implementation seems fine for this use case, but
> > > > before we reserve %pt for rtc_time, could we discuss whether we want
> > > > that for printing struct tm, struct timespec64, time64_t or ktime_t instead?
> > > 
> > > How many users?
> > 
> > It's hard to predict, I would assume we get more users once there is an
> > easy way to print the time.
> 
> So, at least for now we can guess using existing users, right?
> 
> I don't check yet how to calculate those cases of time64_t,
> timespec64, ktime_t and alike if they are about pretty ptintong time
> and date.
> I'm speculating that there are (almost) none.
> 
> > > For struct tm it's somelike 4 (which want to print its content).
> > 
> > Good point. I notice that they all convert from time64_t or time_t into
> > struct tm immediately before printing it, so we can scratch that one
> > as long as there is a way to pretty-print a time64_t. We also don't
> > need to print a time_t as we want to kill that one off anyway.
> > 
> > If we only care about printing time64_t and rtc_time, we can easily
> > use %pT for one and %pt for the other, but there may still be good
> > reasons to print a timespec64 or ktime_t.
> 
> No need, we may still use 3rd/4th letter in the format for that.
> 
> %pt(t/d) time/date + whatever modifications, like raw, validate, timespec, etc.
> 
> 's' for timespec64, for example.

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
