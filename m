Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36173 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdGRT5r (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 15:57:47 -0400
Received: by mail-pf0-f177.google.com with SMTP id o88so9840395pfk.3
        for <linux-rtc@vger.kernel.org>; Tue, 18 Jul 2017 12:57:47 -0700 (PDT)
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
To: Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <1500400205.25934.27.camel@perches.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <861fe353-eb95-615f-b1dc-3326501342af@android.com>
Date: Tue, 18 Jul 2017 12:57:45 -0700
MIME-Version: 1.0
In-Reply-To: <1500400205.25934.27.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/18/2017 10:50 AM, Joe Perches wrote:
> On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
>> Recently I have noticed too many users of struct rtc_time that printing
>> its content field by field.
>>
>> In this series I introduce %pt[dt][rv] specifier to make life a bit
>> easier.
> Hey Andy.
>
> I just saw a patch with a printk for rtc time from Mark Salyzyn.
> https://lkml.org/lkml/2017/7/18/885
>
> Any idea if you want to push this extension?
>
> I like the concept and still think it could be extended a bit more.
>
> from: https://lkml.org/lkml/2017/6/8/1134
>
> My preference would be for %pt[type]<output style>
> where <type> is mandatory and could be:
>
>          r for struct rtc_time
>          6 for time64_t
>          k for ktime_t
>          T for struct timespec64
>          etc
>
> and <output style> has an unspecified default of
> YYYY-MM-DD:hh:mm:ss
>
> Perhaps use the "date" formats without the leading
> % uses for <output style> for additional styles.
>
YYYY-MM-DD hh:mm:ss.nnnnnnnnn ?
