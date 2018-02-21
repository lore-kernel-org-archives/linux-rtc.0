Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:15165 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeBUHi5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 02:38:57 -0500
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <1519170907.4326.17.camel@perches.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
Date: Wed, 21 Feb 2018 08:38:54 +0100
MIME-Version: 1.0
In-Reply-To: <1519170907.4326.17.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 2018-02-21 00:55, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
>> There are users which print time and date represented by content of
>> struct rtc_time in human readable format.
>>
>> Instead of open coding that each time introduce %ptR[dt][rv] specifier.
>>
>> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Not sure this is a great option.
> Not just the name, the need to select it.

Bikeshedding first: If you do keep the config option, please use PRINTF,
not PRINTK - vsprintf can be and is used by lots of code other than printk.

Well, on the one hand, I like to reduce the size of the kernel when
possible and ideally make all new functionality guarded by config
options, but OTOH, how much does compiling out the datetime formatters
really save? Also, I agree with Joe's concern about the need to select
it. Maybe if we had a gcc plugin that did %pFOO validation it could also
warn about %pBAR being used without a corresponding config option being
set. But we don't have that currently...

Rasmus
