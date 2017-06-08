Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:52944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751583AbdFHO7U (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 10:59:20 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 814701807A49B
        for <linux-rtc@vger.kernel.org>; Thu,  8 Jun 2017 14:52:38 +0000 (UTC)
Message-ID: <1496933554.1929.15.camel@perches.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Date: Thu, 08 Jun 2017 07:52:34 -0700
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-06-08 at 16:47 +0300, Andy Shevchenko wrote:
> Recently I have noticed too many users of struct rtc_time that printing
> its content field by field.
> 
> In this series I introduce %pt[dt][rv] specifier to make life a bit
> easier.
> 
> There are still users of detailed output of the struct rtc_time, but we
> can introduce an additional extension for them in the future if needed,
> otherwise they might be converted to the proposed output format.
> 
> Some of the changes slightly modify the output. In those cases we are on
> the safe side since they are pure debug. Nevertheless I tried to leave
> numbers to be the same or quite close: in some cases year is printed +
> 1900, though month is left in the range [0,11] instead of [1,12].
> 
> I didn't compile everything there, though I did a basic smoke test on
> some x86 hardware. So, I rely on kbuild test robot as well :-)
> 
> Most of the users currently are RTC drivers, thus the patch series is
> assumed to go via RTC tree.

What I wonder about this series is how much
larger it makes a typical kernel and how
often multiple rtc clocks are built for a
single kernel?

What is the size impact on an embedded kernel
that uses a single rtc driver?

trivia:

Aren't there also uses of struct tm that are
nearly identical?

e.g.: drivers/usb/host/xhci-tegra.c
