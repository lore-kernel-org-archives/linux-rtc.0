Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50242 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbeGEIbO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 5 Jul 2018 04:31:14 -0400
Date: Thu, 5 Jul 2018 01:31:10 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, stable <stable@vger.kernel.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH 1/4] rtc: omap: fix potential crash on power off
Message-ID: <20180705083110.GX112168@atomide.com>
References: <20180704090558.16647-1-johan@kernel.org>
 <20180704090558.16647-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704090558.16647-2-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

* Johan Hovold <johan@kernel.org> [180704 09:09]:
> Do not set the system power-off callback and omap power-off rtc pointer
> until we're done setting up our device to avoid leaving stale pointers
> around after a late probe error.
> 
> Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
