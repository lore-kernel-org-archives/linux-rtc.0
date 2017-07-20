Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34598 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755615AbdGTR5d (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 20 Jul 2017 13:57:33 -0400
Received: by mail-pf0-f182.google.com with SMTP id q85so14892365pfq.1
        for <linux-rtc@vger.kernel.org>; Thu, 20 Jul 2017 10:57:33 -0700 (PDT)
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <1500400205.25934.27.camel@perches.com>
 <861fe353-eb95-615f-b1dc-3326501342af@android.com>
 <1500546822.29303.136.camel@linux.intel.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <0b7ab8a2-9ec9-8d0b-3e45-20610f3ab598@android.com>
Date: Thu, 20 Jul 2017 10:57:31 -0700
MIME-Version: 1.0
In-Reply-To: <1500546822.29303.136.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/20/2017 03:33 AM, Andy Shevchenko wrote:
> On Tue, 2017-07-18 at 12:57 -0700, Mark Salyzyn wrote:
>> On 07/18/2017 10:50 AM, Joe Perches wrote:
>>> On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
>>>> Recently I have noticed too many users of struct rtc_time that
>>>> printing
>>>> its content field by field.
>>>>
>>>> In this series I introduce %pt[dt][rv] specifier to make life a
>>>> bit
>>>> easier.
>>> Hey Andy.
>>>
>>> I just saw a patch with a printk for rtc time from Mark Salyzyn.
>>> https://lkml.org/lkml/2017/7/18/885
>>>
>>> Any idea if you want to push this extension?
>>>
>>> I like the concept and still think it could be extended a bit more.
>>>
>>> from: https://lkml.org/lkml/2017/6/8/1134
>>>
>>> My preference would be for %pt[type]<output style>
>>> where <type> is mandatory and could be:
>>>
>>>           r for struct rtc_time
>>>           6 for time64_t
>>>           k for ktime_t
>>>           T for struct timespec64
>>>           etc
>>>
>>> and <output style> has an unspecified default of
>>> YYYY-MM-DD:hh:mm:ss
>>>
>>> Perhaps use the "date" formats without the leading
>>> % uses for <output style> for additional styles.
>>>
>> YYYY-MM-DD hh:mm:ss.nnnnnnnnn ?
> As a separate modifier, yes.
>
> See my answer to subthread in patch 4.
>
It would probably need to take struct timespec64 as an argument. Pass by 
structure might be difficult to swallow, so pass by pointer?

As for my need for this in my suspend/resume/hibernate/restore patch 
set, we have already been told three times to _not_ report wall clock 
time. I could imagine being a consumer of it in the future if we have 
difficulty migrating the analysis tools ... so tepid support from me.

-- Mark
