Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35560 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdFHUmo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 16:42:44 -0400
Received: by mail-wm0-f53.google.com with SMTP id x70so84637472wme.0
        for <linux-rtc@vger.kernel.org>; Thu, 08 Jun 2017 13:42:43 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human readable format via %pt
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
        <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
        <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
        <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
        <20170608150540.rek7a4akuxm3k36l@piout.net>
        <CAHp75Vfem=tj3esGx+7_8_Ygx+v09uk77rF-RJ34Tt2kLTHvVQ@mail.gmail.com>
        <20170608184154.y7tqsv7ghpbcbf77@piout.net>
        <CAHp75VcJZS+x8KdBs0nQj_sq9yx23gx3NBP_AqGi0xU+AqEDwQ@mail.gmail.com>
Date: Thu, 08 Jun 2017 22:42:40 +0200
In-Reply-To: <CAHp75VcJZS+x8KdBs0nQj_sq9yx23gx3NBP_AqGi0xU+AqEDwQ@mail.gmail.com>
        (Andy Shevchenko's message of "Thu, 8 Jun 2017 21:49:33 +0300")
Message-ID: <87wp8mky7z.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 08 2017, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 8, 2017 at 9:41 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 08/06/2017 at 20:57:05 +0300, Andy Shevchenko wrote:
>>> On Thu, Jun 8, 2017 at 6:05 PM, Alexandre Belloni
>>> <alexandre.belloni@free-electrons.com> wrote:
>
>>> > I understand this may not fit your debugging needs but what about pretty
>>> > printing time64_t and using rtc_tm_to_time64?
>>>
>>> There are two downsides as I can see:
>>> 1) conversion to and from just for that;
>>
>> Those are almost all debug messages, I would be fine with that.
>
> Yeah, but the problem is to pass the reference. All dances around will
> uglify the code.
> (Obviously we can't pass timespec64/time64_t or anything longer than
> 32 bits as is in %p extension)
>

I like that this gets rid of some mm/dd/yy and other more or less random
format and ends up standardizing yyyy-mm-dd HH:MM:SS. However, I do
think %pt should take either ktime_t or timespec64 (obviously by
reference), with fx these options

[ir] ISO (yyyy-mm-dd HH:MM:SS) or raw (seconds since epoch)
[n] append nanoseconds (.%09ld).

Please don't give people the option of eliding either the time or the
date; I've spent too much time dealing with syslog files that don't
include the year in the timestamps.

Getting a timespec64* or ktime_t* from <something else> is not that
bad. There's the compound literal option

#define rtc_tm2timespec64p(tm) \
 (&(struct timespec64){ .tv_sec = rtc_tm_to_time64(tm), .tv_nsec = 0 })

printk("%pt", rtc_tm2timespec64p(tm))

or the two-extra-lines per call-site

struct timespec64 ts;
rtc_tm2time64(tm, &ts)
printk("%pt", &ts)


Rasmus
