Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:56847 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933186AbeBUOCf (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 09:02:35 -0500
Message-ID: <1519221748.10722.34.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 21 Feb 2018 16:02:28 +0200
In-Reply-To: <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
         <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
         <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 2018-02-21 at 10:33 +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Tue, Feb 20, 2018 at 10:43 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > There are users which print time and date represented by content of
> > struct rtc_time in human readable format.
> > 
> > Instead of open coding that each time introduce %ptR[dt][rv]
> > specifier.
> 
> Thanks for your patch!
> 
> > Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Is it worthwhile making this an option?

People were complaining before

https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html

> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -412,6 +412,37 @@ Examples::
> > 
> >  Passed by reference.
> > 
> > +Time and date
> > +-------------
> > +
> > +::
> > +
> > +       %pt[R]          YYYY-mm-dd HH:MM:SS
> > +       %pt[R]d         YYYY-mm-dd
> > +       %pt[R]t         HH:MM:SS
> 
> [R] suggests the "R" is optional?
> But if it's missing, it prints the hex pointer value?

Yes.

> > +       %pt[R][dt]
> 
> What's the purpose of this?

A place holder to extend.

> > +
> > +  R for struct rtc_time
> > +
> > +Note, users have to select PRINTK_PEXT_TIMEDATE option in a
> > Kconfig.
> > +
> > +struct rtc_time
> > +~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +       %ptR[dt][rv]
> 
> What's the purpose of this paragraph, compared to the previous one?

This is first batch to make it working for struct rtc_time. We have
several users (and I have some local patches WIP) to print time64_t /
timespec64 which would use different letters and paragraphs to explain.

I could remove it and return like it was in v1 (with the exception for
new R letter added).

TBH, I don't see much consensus among developers on this topic.
I wouldn't like to send a new version until it would be a consensus.

> > +static noinline_for_stack
> > +char *date_str(char *buf, char *end, const struct rtc_time *tm,
> > bool v, bool r)
> > +{
> > +       int year = tm->tm_year + (r ? 0 : 1900);
> > +       int mon = tm->tm_mon + (r ? 0 : 1);
> > +
> > +       if (unlikely(v && (unsigned int)tm->tm_year > 200))
> > +               buf = string(buf, end, "****", default_str_spec);
> > +       else
> > +               buf = number(buf, end, year, default_dec04_spec);
> > +
> > +       if (buf < end)
> > +               *buf = '-';
> 
> Instead of all these checks to avoid overflowing the passed buffer, it
> may be simpler to format everything in a fixed-size buffer on the
> stack,
> and copy whatever will fit in the target buffer at the end.

I dropped that idea since the most heavier call is number().
We still need to do several of them one way or the other.

So, I really don't see much benefit of doing your way.

> > +static noinline_for_stack
> > +char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
> > const char *fmt)
> > +{
> > +       bool have_t = true, have_d = true;
> > +       bool validate = false;
> > +       bool raw = false;
> > +       int count = 1;
> > +       bool found;
> > +
> > +       switch (fmt[++count]) {
> > +       case 'd':
> > +               have_t = false;
> > +               break;
> > +       case 't':
> > +               have_d = false;
> > +               break;
> > +       }
> > +
> > +       /* No %pt[dt] supplied */
> > +       if (have_d && have_t)
> > +               --count;
> 
> First increment count, then rollback.
> What about:
> 
>     switch (fmt[count]) {
>     case 'd':
>             have_t = false;
>             count++;
>             break;
>     case 't':
>             have_d = false;
>             count++;
>             break;
>     }

Or simple:

 default:
  --count;
  break;

?

I really need to come up with the next pile for time64_t which I suppose
will require rethinking of format parsing and printing functions here.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
