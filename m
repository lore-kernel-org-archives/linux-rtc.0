Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36125 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdFHOzN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 10:55:13 -0400
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-5-andriy.shevchenko@linux.intel.com> <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jun 2017 17:55:12 +0300
Message-ID: <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Arnd Bergmann <arnd@arndb.de>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jun 8, 2017 at 3:47 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> There are users which print time and date represented by content of
>> struct rtc_time in human readable format.
>>
>> Instead of open coding that each time introduce %pt[dt][rv] specifier.
>
> I really like the idea, and the implementation seems fine for this use case, but
> before we reserve %pt for rtc_time, could we discuss whether we want
> that for printing struct tm, struct timespec64, time64_t or ktime_t instead?

How many users? For struct tm it's somelike 4 (which want to print its content).

> I can see good reasons for pretty-printing any of them, but the namespace for
> format strings is rather limited.
>
> struct rtc_time is almost the same as struct tm (the former has one extra
> member), so maybe we can actually define them to be the same and
> use one format string for both?

The reason I decide to drop struct tm for now due to they are not
compatible and I have got an interesting bugs.
Verify tm_year member carefully.

-- 
With Best Regards,
Andy Shevchenko
