Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:39155 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750934AbdFIFIH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 9 Jun 2017 01:08:07 -0400
Message-ID: <1496984883.1929.29.camel@perches.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Date: Thu, 08 Jun 2017 22:08:03 -0700
In-Reply-To: <CAHp75VcCEO6yfd51n=g8tpWGBfwZrMuJO9aDGBY6ZXb5sQPd5g@mail.gmail.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <1496933554.1929.15.camel@perches.com>
         <CAHp75VcCEO6yfd51n=g8tpWGBfwZrMuJO9aDGBY6ZXb5sQPd5g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-06-08 at 18:02 +0300, Andy Shevchenko wrote:
> On Thu, Jun 8, 2017 at 5:52 PM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
> > > Recently I have noticed too many users of struct rtc_time that printing
> > > its content field by field.
> > > 
> > > In this series I introduce %pt[dt][rv] specifier to make life a bit
> > > easier.
[]
> > > Most of the users currently are RTC drivers, thus the patch series is
> > > assumed to go via RTC tree.
> > 
> > What I wonder about this series is how much
> > larger it makes a typical kernel and how
> > often multiple rtc clocks are built for a
> > single kernel?
> 
> We may hide it under CONFIG_RTC_??? if we want to reduce kernel for
> non RTC cases.

Depends whether it is for rtc_time only

> > What is the size impact on an embedded kernel
> > that uses a single rtc driver?
> 
> I would

You would what?
