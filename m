Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28616 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964888AbeBUOEG (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 09:04:06 -0500
Message-ID: <1519221841.10722.37.camel@linux.intel.com>
Subject: Re: [PATCH v2 20/21] mk68/mac: Switch to use %ptR
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>
Date: Wed, 21 Feb 2018 16:04:01 +0200
In-Reply-To: <CAMuHMdV9Ho3yh8e8z3N1awPj1ZjQu=7LtMetAY5TX=AVuXCVOQ@mail.gmail.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
         <20180220214400.66749-21-andriy.shevchenko@linux.intel.com>
         <CAMuHMdV9Ho3yh8e8z3N1awPj1ZjQu=7LtMetAY5TX=AVuXCVOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 2018-02-21 at 10:38 +0100, Geert Uytterhoeven wrote:

> > +       select PRINTK_PEXT_TIMEDATE
> 
> Yeah, now you have to track whatever code uses the new %p extension...

I don't like this. People had an opinion that 750+ bytes is way too much
for tiny kernel configuration.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
