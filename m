Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdJLRLU (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Oct 2017 13:11:20 -0400
Message-ID: <1507827914.16112.449.camel@linux.intel.com>
Subject: Re: [PATCH v1 24/25] kdb: Switch to use %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Ingo Molnar <mingo@kernel.org>
Date: Thu, 12 Oct 2017 20:05:14 +0300
In-Reply-To: <CAK8P3a3RNAty5T8nR2F3JMJB2zYyeJQ0qvj0gJxa0QB57TcVuQ@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <20170608134811.60786-25-andriy.shevchenko@linux.intel.com>
         <CAK8P3a3RNAty5T8nR2F3JMJB2zYyeJQ0qvj0gJxa0QB57TcVuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-10-12 at 15:31 +0200, Arnd Bergmann wrote:
> On Thu, Jun 8, 2017 at 3:48 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > diff --git a/kernel/debug/kdb/kdb_main.c
> > b/kernel/debug/kdb/kdb_main.c
> > index c8146d53ca67..2a6f12be79d8 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -2556,12 +2556,7 @@ static int kdb_summary(int argc, const char
> > **argv)
> > 
> >         now = __current_kernel_time();
> >         kdb_gmtime(&now, &tm);
> > -       kdb_printf("date       %04d-%02d-%02d %02d:%02d:%02d "
> > -                  "tz_minuteswest %d\n",
> > -               1900+tm.tm_year, tm.tm_mon+1, tm.tm_mday,
> > -               tm.tm_hour, tm.tm_min, tm.tm_sec,
> > -               sys_tz.tz_minuteswest);
> > -
> 
> I just experimented with a similar change and noticed your version.
> 
> You forgot to remove the kdb_gmtime() function that is now completely
> unneeded. My patch takes care of that now.

So, are you going to substitute entire series by your variant?

What did you choose to be format for the %p extension?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
