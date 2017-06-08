Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40494 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHSmC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 14:42:02 -0400
Date: Thu, 8 Jun 2017 20:41:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20170608184154.y7tqsv7ghpbcbf77@piout.net>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
 <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
 <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
 <20170608150540.rek7a4akuxm3k36l@piout.net>
 <CAHp75Vfem=tj3esGx+7_8_Ygx+v09uk77rF-RJ34Tt2kLTHvVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vfem=tj3esGx+7_8_Ygx+v09uk77rF-RJ34Tt2kLTHvVQ@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 08/06/2017 at 20:57:05 +0300, Andy Shevchenko wrote:
> On Thu, Jun 8, 2017 at 6:05 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 08/06/2017 at 17:55:12 +0300, Andy Shevchenko wrote:
> >> On Thu, Jun 8, 2017 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Thu, Jun 8, 2017 at 3:47 PM, Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> >> There are users which print time and date represented by content of
> >> >> struct rtc_time in human readable format.
> >> >>
> >> >> Instead of open coding that each time introduce %pt[dt][rv] specifier.
> >> >
> >> > I really like the idea, and the implementation seems fine for this use case, but
> >> > before we reserve %pt for rtc_time, could we discuss whether we want
> >> > that for printing struct tm, struct timespec64, time64_t or ktime_t instead?
> >>
> >> How many users? For struct tm it's somelike 4 (which want to print its content).
> >>
> >> > I can see good reasons for pretty-printing any of them, but the namespace for
> >> > format strings is rather limited.
> >> >
> >> > struct rtc_time is almost the same as struct tm (the former has one extra
> >> > member), so maybe we can actually define them to be the same and
> >> > use one format string for both?
> >>
> >> The reason I decide to drop struct tm for now due to they are not
> >> compatible and I have got an interesting bugs.
> >> Verify tm_year member carefully.
> >>
> >
> > I understand this may not fit your debugging needs but what about pretty
> > printing time64_t and using rtc_tm_to_time64?
> 
> There are two downsides as I can see:
> 1) conversion to and from just for that;

Those are almost all debug messages, I would be fine with that.

> 2) if you look closer to the patches rtc-* you may find cases where
> wday is also printed so, struct rtc_time still will be in use.
> 

(And you missed two in rtc-mcp795.c). Honestly, nobody cares about wday,
you may as well leave it out.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
