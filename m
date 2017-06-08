Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36653 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHSte (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 14:49:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170608184154.y7tqsv7ghpbcbf77@piout.net>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
 <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
 <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
 <20170608150540.rek7a4akuxm3k36l@piout.net> <CAHp75Vfem=tj3esGx+7_8_Ygx+v09uk77rF-RJ34Tt2kLTHvVQ@mail.gmail.com>
 <20170608184154.y7tqsv7ghpbcbf77@piout.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jun 2017 21:49:33 +0300
Message-ID: <CAHp75VcJZS+x8KdBs0nQj_sq9yx23gx3NBP_AqGi0xU+AqEDwQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 9:41 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 08/06/2017 at 20:57:05 +0300, Andy Shevchenko wrote:
>> On Thu, Jun 8, 2017 at 6:05 PM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:

>> > I understand this may not fit your debugging needs but what about pretty
>> > printing time64_t and using rtc_tm_to_time64?
>>
>> There are two downsides as I can see:
>> 1) conversion to and from just for that;
>
> Those are almost all debug messages, I would be fine with that.

Yeah, but the problem is to pass the reference. All dances around will
uglify the code.
(Obviously we can't pass timespec64/time64_t or anything longer than
32 bits as is in %p extension)

>> 2) if you look closer to the patches rtc-* you may find cases where
>> wday is also printed so, struct rtc_time still will be in use.

> (And you missed two in rtc-mcp795.c). Honestly, nobody cares about wday,
> you may as well leave it out.

Oops, thanks, indeed. Okay, I will leave it for now with dropped wday
until someone comes with strong opinion why it should be there.

-- 
With Best Regards,
Andy Shevchenko
