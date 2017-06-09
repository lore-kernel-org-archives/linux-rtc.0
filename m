Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34002 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdFINmF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 9 Jun 2017 09:42:05 -0400
Received: by mail-wr0-f174.google.com with SMTP id g76so33538736wrd.1
        for <linux-rtc@vger.kernel.org>; Fri, 09 Jun 2017 06:42:04 -0700 (PDT)
Subject: Re: [PATCH v1 24/25] kdb: Switch to use %pt
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Jason Wessel <jason.wessel@windriver.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-25-andriy.shevchenko@linux.intel.com>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <94f7a93e-8136-df53-b0f2-6ef8d630f74f@linaro.org>
Date: Fri, 9 Jun 2017 14:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170608134811.60786-25-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 08/06/17 14:48, Andy Shevchenko wrote:
> Use %pt instead of open coded variant to print content of
> struct rtc_time in human readable format.
> 
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>   kernel/debug/kdb/kdb_main.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index c8146d53ca67..2a6f12be79d8 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2556,12 +2556,7 @@ static int kdb_summary(int argc, const char **argv)
>   
>   	now = __current_kernel_time();
>   	kdb_gmtime(&now, &tm);
> -	kdb_printf("date       %04d-%02d-%02d %02d:%02d:%02d "
> -		   "tz_minuteswest %d\n",
> -		1900+tm.tm_year, tm.tm_mon+1, tm.tm_mday,
> -		tm.tm_hour, tm.tm_min, tm.tm_sec,
> -		sys_tz.tz_minuteswest);
> -
> +	kdb_printf("date       %pt tz_minuteswest %d\n", &tm, sys_tz.tz_minuteswest);
>   	kdb_sysinfo(&val);
>   	kdb_printf("uptime     ");
>   	if (val.uptime > (24*60*60)) {
> 
