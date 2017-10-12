Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:53481 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdJLNbM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 09:31:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170608134811.60786-25-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com> <20170608134811.60786-25-andriy.shevchenko@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 12 Oct 2017 15:31:10 +0200
Message-ID: <CAK8P3a3RNAty5T8nR2F3JMJB2zYyeJQ0qvj0gJxa0QB57TcVuQ@mail.gmail.com>
Subject: Re: [PATCH v1 24/25] kdb: Switch to use %pt
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 3:48 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index c8146d53ca67..2a6f12be79d8 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2556,12 +2556,7 @@ static int kdb_summary(int argc, const char **argv)
>
>         now = __current_kernel_time();
>         kdb_gmtime(&now, &tm);
> -       kdb_printf("date       %04d-%02d-%02d %02d:%02d:%02d "
> -                  "tz_minuteswest %d\n",
> -               1900+tm.tm_year, tm.tm_mon+1, tm.tm_mday,
> -               tm.tm_hour, tm.tm_min, tm.tm_sec,
> -               sys_tz.tz_minuteswest);
> -

I just experimented with a similar change and noticed your version.

You forgot to remove the kdb_gmtime() function that is now completely
unneeded. My patch takes care of that now.

      Arnd
