Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:55249 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbeGLJmi (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Jul 2018 05:42:38 -0400
Date: Thu, 12 Jul 2018 11:33:40 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Trent Piepho <tpiepho@impinj.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v2] rtc-snvs: Add timeouts to avoid kernel lockups
Message-ID: <20180712093340.GC16084@piout.net>
References: <20180516234551.24954-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516234551.24954-1-tpiepho@impinj.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 16/05/2018 16:45:51-0700, Trent Piepho wrote:
> In order to read correctly from asynchronously updated RTC registers,
> it's necessary to read repeatedly until their values do not change from
> read to read.  It's also necessary to wait for three RTC clock ticks for
> certain operations.  There are no timeouts in this code and these
> operations could possibly loop forever.
> 
> To avoid kernel hangs, put in timeouts.
> 
> The iMX7d can be configured to stop the SRTC on a tamper event, which
> will lockup the kernel inside this driver as described above.
> 
> These hangs can happen when running under qemu, which doesn't emulate
> the SNVS RTC, though currently the driver will refuse to load on qemu
> due to a timeout in the driver probe method.
> 
> It could also happen if the SRTC block where somehow placed into reset
> or the slow speed clock that drives the SRTC counter (but not the CPU)
> were to stop.
> 
> The symptoms on a two core iMX7d are a work queue hang on
> rtc_timer_do_work(), which eventually blocks a systemd fsnotify
> operation that triggers a work queue flush, causing systemd to hang and
> thus causing all services that should be started by systemd, like a
> console getty, to fail to start or stop.
> 
> Also optimize the wait code to wait less.  It only needs to wait for the
> clock to advance three ticks, not to see it change three times.
> 
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-snvs.c | 105 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 35 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
