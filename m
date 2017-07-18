Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58620 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751997AbdGRWdU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 18:33:20 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/4] PM: Print wall time at suspend entry and exit
Date: Wed, 19 Jul 2017 00:25:29 +0200
Message-ID: <214360396.4sfZrYBT7N@aspire.rjw.lan>
In-Reply-To: <20170718172600.114761-1-salyzyn@android.com>
References: <20170718172600.114761-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tuesday, July 18, 2017 10:25:58 AM Mark Salyzyn wrote:
> Permits power state and battery life diagnosis.
> 
> Feature activated by CONFIG_RTC_SHOW_TIME.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>

Please fold the [4/4] into this one and I have a patch series that you'd
want to rebase this on I guess.  I'll send it shortly.

Thanks,
Rafael
