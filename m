Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdFHOAN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 8 Jun 2017 10:00:13 -0400
Date: Thu, 8 Jun 2017 16:00:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 06/25] rtc: Switch to use %pt
Message-ID: <20170608140000.GA21298@kroah.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
 <20170608134811.60786-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608134811.60786-7-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 08, 2017 at 04:47:52PM +0300, Andy Shevchenko wrote:
> Use %pt instead of open coded variant to print content of
> struct rtc_time in human readable format.
> 
> Arnd Bergmann <arnd@arndb.de>

 Cc: ?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
