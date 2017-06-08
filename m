Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36305 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFHSi0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 14:38:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170608140000.GA21298@kroah.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-7-andriy.shevchenko@linux.intel.com> <20170608140000.GA21298@kroah.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jun 2017 21:38:24 +0300
Message-ID: <CAHp75Ve1abFYh7TM7a41LohOeAvwYvc+pGF3=3T-fe3hJB=Tsw@mail.gmail.com>
Subject: Re: [PATCH v1 06/25] rtc: Switch to use %pt
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 8, 2017 at 5:00 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 08, 2017 at 04:47:52PM +0300, Andy Shevchenko wrote:
>> Use %pt instead of open coded variant to print content of
>> struct rtc_time in human readable format.
>>
>> Arnd Bergmann <arnd@arndb.de>
>
>  Cc: ?

Yep!
Fixed locally, will be in next version of the series.

>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
