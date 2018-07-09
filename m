Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:48708 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754317AbeGIJtg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 9 Jul 2018 05:49:36 -0400
Subject: Re: [PATCH 1/4] rtc: omap: fix potential crash on power off
To: Johan Hovold <johan@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, stable <stable@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
References: <20180704090558.16647-1-johan@kernel.org>
 <20180704090558.16647-2-johan@kernel.org>
From: Marcin Niestroj <m.niestroj@grinn-global.com>
Message-ID: <19327b80-3f3e-0c23-b191-b6f0e823ca51@grinn-global.com>
Date: Mon, 9 Jul 2018 11:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180704090558.16647-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 04.07.2018 11:05, Johan Hovold wrote:
> Do not set the system power-off callback and omap power-off rtc pointer
> until we're done setting up our device to avoid leaving stale pointers
> around after a late probe error.
> 
> Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.or

Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>

-- 
Marcin Niestroj
