Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:33327 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751065AbdGUEHs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 21 Jul 2017 00:07:48 -0400
Message-ID: <1500610064.14415.20.camel@perches.com>
Subject: Re: [PATCH v1 00/25] lib, rtc: Print rtc_time via %pt[dt][rv]
From: Joe Perches <joe@perches.com>
To: Mark Salyzyn <salyzyn@android.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Date: Thu, 20 Jul 2017 21:07:44 -0700
In-Reply-To: <0b7ab8a2-9ec9-8d0b-3e45-20610f3ab598@android.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
         <1500400205.25934.27.camel@perches.com>
         <861fe353-eb95-615f-b1dc-3326501342af@android.com>
         <1500546822.29303.136.camel@linux.intel.com>
         <0b7ab8a2-9ec9-8d0b-3e45-20610f3ab598@android.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-07-20 at 10:57 -0700, Mark Salyzyn wrote:
> It would probably need to take struct timespec64 as an argument. Pass by 
> structure might be difficult to swallow, so pass by pointer?

Every %p<foo> extension is passed via a pointer.
