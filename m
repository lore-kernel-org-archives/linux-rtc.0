Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:36187 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755723AbeDZUWH (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Apr 2018 16:22:07 -0400
Date: Thu, 26 Apr 2018 22:22:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Trent Piepho <tpiepho@impinj.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] rtc-snvs: Add timeouts to avoid kernel lockups
Message-ID: <20180426202206.GV4813@piout.net>
References: <20180316181202.14896-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316181202.14896-1-tpiepho@impinj.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Trent,

On 16/03/2018 11:12:02-0700, Trent Piepho wrote:
> In order to read correctly from asynchronously updated RTC registers, it's
> necessary to read repeatedly until their values do not change from read to
> read.  There is no timeout in this code and it could possibly loop
> forever.
> 
> It's also necessary to wait for three RTC clock ticks for certain
> operations to take effect and the driver might wait forever for this to
> happen.
> 
> To avoid kernel hangs, put in timeouts.
> 
> These hangs will happen when running under qemu, which doesn't emulate the
> SNVS RTC.  It could also happen if the RTC block where somehow placed into
> reset or the slow speed clock that drives the RTC counter (but not the
> CPU) were to stop.
> 
> The symptoms are a work queue hang on rtc_timer_do_work(), which
> eventually blocks a systemd fsnotify operation that triggers a work queue
> flush, causing systemd to hang and thus causing all services that should
> be started by systemd, like a console getty, to fail to start or stop.
> 
> Also optimize the wait code to wait less.  It only needs to wait for the
> clock to advance three ticks, not to see it change three times.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: linux-rtc@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>

Can you rebase that patch on top of rtc-next if you feel this is still
necessary? Also, it would be great to have Shawn or Fabio's ack.

Thanks!

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
