Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33835 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeBUJdw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 04:33:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com> <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 10:33:51 +0100
Message-ID: <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Andy,

On Tue, Feb 20, 2018 at 10:43 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There are users which print time and date represented by content of
> struct rtc_time in human readable format.
>
> Instead of open coding that each time introduce %ptR[dt][rv] specifier.

Thanks for your patch!

> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.

Is it worthwhile making this an option?

> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -412,6 +412,37 @@ Examples::
>
>  Passed by reference.
>
> +Time and date
> +-------------
> +
> +::
> +
> +       %pt[R]          YYYY-mm-dd HH:MM:SS
> +       %pt[R]d         YYYY-mm-dd
> +       %pt[R]t         HH:MM:SS

[R] suggests the "R" is optional?
But if it's missing, it prints the hex pointer value?

> +       %pt[R][dt]

What's the purpose of this?

> +
> +  R for struct rtc_time
> +
> +Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> +
> +struct rtc_time
> +~~~~~~~~~~~~~~~
> +
> +::
> +
> +       %ptR[dt][rv]

What's the purpose of this paragraph, compared to the previous one?

> +
> +For printing date and time as represented by struct rtc_time structure in
> +human readable format.

> @@ -1443,6 +1458,132 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
>         return special_hex_number(buf, end, num, size);
>  }
>
> +static noinline_for_stack
> +char *date_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +       int year = tm->tm_year + (r ? 0 : 1900);
> +       int mon = tm->tm_mon + (r ? 0 : 1);
> +
> +       if (unlikely(v && (unsigned int)tm->tm_year > 200))
> +               buf = string(buf, end, "****", default_str_spec);
> +       else
> +               buf = number(buf, end, year, default_dec04_spec);
> +
> +       if (buf < end)
> +               *buf = '-';

Instead of all these checks to avoid overflowing the passed buffer, it
may be simpler to format everything in a fixed-size buffer on the stack,
and copy whatever will fit in the target buffer at the end.

> +       buf++;
> +
> +       if (unlikely(v && (unsigned int)tm->tm_mon > 11))
> +               buf = string(buf, end, "**", default_str_spec);
> +       else
> +               buf = number(buf, end, mon, default_dec02_spec);
> +
> +       if (buf < end)
> +               *buf = '-';
> +       buf++;
> +
> +       if (unlikely(v && (unsigned int)tm->tm_mday > 31))
> +               buf = string(buf, end, "**", default_str_spec);
> +       else
> +               buf = number(buf, end, tm->tm_mday, default_dec02_spec);
> +
> +       return buf;
> +}
> +
> +static noinline_for_stack
> +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> +{
> +       if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> +               buf = string(buf, end, "**", default_str_spec);
> +       else
> +               buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> +
> +       if (buf < end)
> +               *buf = ':';

Likewise.

> +       buf++;
> +
> +       if (unlikely(v && (unsigned int)tm->tm_min > 59))
> +               buf = string(buf, end, "**", default_str_spec);
> +       else
> +               buf = number(buf, end, tm->tm_min, default_dec02_spec);
> +
> +       if (buf < end)
> +               *buf = ':';
> +       buf++;
> +
> +       if (unlikely(v && (unsigned int)tm->tm_sec > 59))
> +               buf = string(buf, end, "**", default_str_spec);
> +       else
> +               buf = number(buf, end, tm->tm_sec, default_dec02_spec);
> +
> +       return buf;
> +}
> +
> +static noinline_for_stack
> +char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
> +{
> +       bool have_t = true, have_d = true;
> +       bool validate = false;
> +       bool raw = false;
> +       int count = 1;
> +       bool found;
> +
> +       switch (fmt[++count]) {
> +       case 'd':
> +               have_t = false;
> +               break;
> +       case 't':
> +               have_d = false;
> +               break;
> +       }
> +
> +       /* No %pt[dt] supplied */
> +       if (have_d && have_t)
> +               --count;

First increment count, then rollback.
What about:

    switch (fmt[count]) {
    case 'd':
            have_t = false;
            count++;
            break;
    case 't':
            have_d = false;
            count++;
            break;
    }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
