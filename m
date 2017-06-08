Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36714 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdFHU73 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 16:59:29 -0400
Received: by mail-wm0-f48.google.com with SMTP id 7so145275545wmo.1
        for <linux-rtc@vger.kernel.org>; Thu, 08 Jun 2017 13:59:28 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 01/25] lib/vsprintf: Remove useless NULL checks
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
        <20170608134811.60786-2-andriy.shevchenko@linux.intel.com>
Date: Thu, 08 Jun 2017 22:59:26 +0200
In-Reply-To: <20170608134811.60786-2-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Thu, 8 Jun 2017 16:47:47 +0300")
Message-ID: <87shjakxg1.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 08 2017, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The pointer can't be NULL since it's first what has been done in the
> pointer().
>
> Remove useless checks.
>
> Note when we print clock name or rate it is safe in case !CONFIG_HAVE_CLK.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 9f16406288c0..031c2cc5c1c0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -811,10 +811,6 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  		/* nothing to print */
>  		return buf;
>  
> -	if (ZERO_OR_NULL_PTR(addr))
> -		/* NULL pointer */
> -		return string(buf, end, NULL, spec);
> -
>  	switch (fmt[1]) {
>  	case 'C':
>  		separator = ':';
> @@ -1253,10 +1249,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	if (spec.field_width == 0)
>  		return buf;				/* nothing to print */
>  
> -	if (ZERO_OR_NULL_PTR(addr))
> -		return string(buf, end, NULL, spec);	/* NULL pointer */
> -
> -

Well, ZERO_OR_NULL_PTR checks for a little more than !addr, but I
suppose that if anyone passes the result from kmalloc(0) to %ph, they'd
better also pass 0 as the size, so the .field_width tests should be
sufficient.

>  	do {
>  		switch (fmt[count++]) {
>  		case 'a':
> @@ -1391,9 +1383,6 @@ static noinline_for_stack
>  char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>  	    const char *fmt)
>  {
> -	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> -		return string(buf, end, NULL, spec);
> -

Well, it may be safe, but removing the IS_ENABLED(CONFIG_HAVE_CLK) check
means that clock() becomes a much bigger function when
!IS_ENABLED(CONFIG_HAVE_CLK). You're right that the !clk check is
pointless.
