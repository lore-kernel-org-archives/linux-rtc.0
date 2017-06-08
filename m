Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36486 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdFHVpZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 17:45:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VdVV6i8SD6=z5Bt=UCsDB7mYTnxpZqP5=pWiob1CVPSaA@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
 <CAK8P3a0JDvd-frxQvOe7RVPBgA6M-RBiw=Tt1dP1EJa+L4qQoQ@mail.gmail.com>
 <CAHp75VfUU9fO-jnY32caKywf8h3bdst9zBf66Wjz6C5+4z1okA@mail.gmail.com>
 <20170608150540.rek7a4akuxm3k36l@piout.net> <CAHp75Vfem=tj3esGx+7_8_Ygx+v09uk77rF-RJ34Tt2kLTHvVQ@mail.gmail.com>
 <20170608184154.y7tqsv7ghpbcbf77@piout.net> <CAHp75VcJZS+x8KdBs0nQj_sq9yx23gx3NBP_AqGi0xU+AqEDwQ@mail.gmail.com>
 <87wp8mky7z.fsf@rasmusvillemoes.dk> <CAHp75VdVV6i8SD6=z5Bt=UCsDB7mYTnxpZqP5=pWiob1CVPSaA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Jun 2017 23:45:23 +0200
Message-ID: <CAK8P3a36FYzExs4UxB=dJ_rvEmvamq=__O9PXKgtpN=OqF6VSQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/25] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 11:25 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 8, 2017 at 11:42 PM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On Thu, Jun 08 2017, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Jun 8, 2017 at 9:41 PM, Alexandre Belloni
>>> <alexandre.belloni@free-electrons.com> wrote:
>>>> On 08/06/2017 at 20:57:05 +0300, Andy Shevchenko wrote:
>>>>> On Thu, Jun 8, 2017 at 6:05 PM, Alexandre Belloni
>>>>> <alexandre.belloni@free-electrons.com> wrote:
>
>>> Yeah, but the problem is to pass the reference. All dances around will
>>> uglify the code.
>>> (Obviously we can't pass timespec64/time64_t or anything longer than
>>> 32 bits as is in %p extension)
>
>> I like that this gets rid of some mm/dd/yy and other more or less random
>> format and ends up standardizing yyyy-mm-dd HH:MM:SS. However, I do
>> think %pt should take either ktime_t or timespec64 (obviously by
>> reference),
>
> I will try to look in this direction.

sounds good.

>> Please don't give people the option of eliding either the time or the
>> date; I've spent too much time dealing with syslog files that don't
>> include the year in the timestamps.
>
> I understand that, but see above.

When we pretty-print a ktime_t, we probably want to leave out the high
fields as well, as this often refers to a time interval, e.g. a few seconds.
Even for absolute values, the start of ktime_t is usually not the 1970
epoch but system boot, so we may not necessarily want the higher
fields. I hoped to find some inspiration in the 'date' man page, which
contains a lot of formatting options, but it's hard to translate that into
a useful format string within the constraints of %p flags in printk.

     Arnd
