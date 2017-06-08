Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33088 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdFHOtn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 10:49:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com> <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Jun 2017 16:49:42 +0200
Message-ID: <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
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

On Thu, Jun 8, 2017 at 3:47 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
>
> Instead of open coding that each time introduce %pt[dt][rv] specifier.

I really like the idea, and the implementation seems fine for this use case, but
before we reserve %pt for rtc_time, could we discuss whether we want
that for printing struct tm, struct timespec64, time64_t or ktime_t instead?

I can see good reasons for pretty-printing any of them, but the namespace for
format strings is rather limited.

struct rtc_time is almost the same as struct tm (the former has one extra
member), so maybe we can actually define them to be the same and
use one format string for both?

        Arnd
