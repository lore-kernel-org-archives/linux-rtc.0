Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:36732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751312AbeBUAAU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 20 Feb 2018 19:00:20 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 68A6018004A27
        for <linux-rtc@vger.kernel.org>; Tue, 20 Feb 2018 23:55:16 +0000 (UTC)
Message-ID: <1519170907.4326.17.camel@perches.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
Date: Tue, 20 Feb 2018 15:55:07 -0800
In-Reply-To: <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
         <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
> 
> Instead of open coding that each time introduce %ptR[dt][rv] specifier.
> 
> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.

Not sure this is a great option.
Not just the name, the need to select it.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> +static noinline_for_stack
> +char *date_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +	int year = tm->tm_year + (r ? 0 : 1900);
> +	int mon = tm->tm_mon + (r ? 0 : 1);

What happens with negative values?
Perhaps these temporaries should be unsigned int.

> +
> +	if (unlikely(v && (unsigned int)tm->tm_year > 200))
> +		buf = string(buf, end, "****", default_str_spec);
> +	else
> +		buf = number(buf, end, year, default_dec04_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mon > 11))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, mon, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = '-';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_mday > 31))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_mday, default_dec02_spec);
> +
> +	return buf;
> +}
> +
> +static noinline_for_stack
> +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{

Maybe use unsigned int temporaries here too for hour, min, sec

> +	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_min > 59))

leap seconds are allowed in the struct

> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_min, default_dec02_spec);
> +
> +	if (buf < end)
> +		*buf = ':';
> +	buf++;
> +
> +	if (unlikely(v && (unsigned int)tm->tm_sec > 59))
> +		buf = string(buf, end, "**", default_str_spec);
> +	else
> +		buf = number(buf, end, tm->tm_sec, default_dec02_spec);
> +
> +	return buf;
> +}
> 
