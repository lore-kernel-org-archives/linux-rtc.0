Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37173 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965676AbeBMUsZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Feb 2018 15:48:25 -0500
Date: Tue, 13 Feb 2018 21:48:14 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: goldfish: Add missing MODULE_LICENSE
Message-ID: <20180213204814.GE30929@piout.net>
References: <20180116144521.392-1-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180116144521.392-1-jhogan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 16/01/2018 at 14:45:21 +0000, James Hogan wrote:
> Fix the following warning in MIPS allmodconfig by adding a
> MODULE_LICENSE() at the end of rtc-goldfish.c, based on the file header
> comment which says GNU General Public License version 2:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/rtc/rtc-goldfish.o
> 
> Fixes: f22d9cdcb5eb ("rtc: goldfish: Add RTC driver for Android emulator")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Miodrag Dinic <miodrag.dinic@mips.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: linux-rtc@vger.kernel.org
> ---
>  drivers/rtc/rtc-goldfish.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
