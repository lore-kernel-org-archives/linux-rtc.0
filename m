Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54222 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeBUJQt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 04:16:49 -0500
Date: Wed, 21 Feb 2018 10:16:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>,
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
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20180221091637.GK18058@piout.net>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <1519170907.4326.17.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519170907.4326.17.camel@perches.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/02/2018 at 15:55:07 -0800, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > +static noinline_for_stack
> > +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> > +{
> 
> Maybe use unsigned int temporaries here too for hour, min, sec
> 
> > +	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> > +		buf = string(buf, end, "**", default_str_spec);
> > +	else
> > +		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> > +
> > +	if (buf < end)
> > +		*buf = ':';
> > +	buf++;
> > +
> > +	if (unlikely(v && (unsigned int)tm->tm_min > 59))
> 
> leap seconds are allowed in the struct
> 

No, they are not:
https://elixir.bootlin.com/linux/v4.15.4/source/drivers/rtc/rtc-lib.c#L108


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
