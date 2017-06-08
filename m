Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34836 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdFHPCV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 11:02:21 -0400
MIME-Version: 1.0
In-Reply-To: <1496933554.1929.15.camel@perches.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com> <1496933554.1929.15.camel@perches.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jun 2017 18:02:19 +0300
Message-ID: <CAHp75VcCEO6yfd51n=g8tpWGBfwZrMuJO9aDGBY6ZXb5sQPd5g@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
To: Joe Perches <joe@perches.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 5:52 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
>> Recently I have noticed too many users of struct rtc_time that printing
>> its content field by field.
>>
>> In this series I introduce %pt[dt][rv] specifier to make life a bit
>> easier.
>>
>> There are still users of detailed output of the struct rtc_time, but we
>> can introduce an additional extension for them in the future if needed,
>> otherwise they might be converted to the proposed output format.
>>
>> Some of the changes slightly modify the output. In those cases we are on
>> the safe side since they are pure debug. Nevertheless I tried to leave
>> numbers to be the same or quite close: in some cases year is printed +
>> 1900, though month is left in the range [0,11] instead of [1,12].
>>
>> I didn't compile everything there, though I did a basic smoke test on
>> some x86 hardware. So, I rely on kbuild test robot as well :-)
>>
>> Most of the users currently are RTC drivers, thus the patch series is
>> assumed to go via RTC tree.
>
> What I wonder about this series is how much
> larger it makes a typical kernel and how
> often multiple rtc clocks are built for a
> single kernel?

We may hide it under CONFIG_RTC_??? if we want to reduce kernel for
non RTC cases.

> What is the size impact on an embedded kernel
> that uses a single rtc driver?

I would

> trivia:

Actually not. See my answer to Arnd. I have patches for 4 users of
struct tm, but it should be converted first to struct rtc_time first
(otherwise it might uglify the code due to endianess of tm_year
memeber)

>
> Aren't there also uses of struct tm that are
> nearly identical?
>
> e.g.: drivers/usb/host/xhci-tegra.c



-- 
With Best Regards,
Andy Shevchenko
