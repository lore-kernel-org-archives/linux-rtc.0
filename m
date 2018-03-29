Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37846 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2CSX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 28 Mar 2018 22:18:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id n11so2094324pgp.4
        for <linux-rtc@vger.kernel.org>; Wed, 28 Mar 2018 19:18:23 -0700 (PDT)
Date: Thu, 29 Mar 2018 10:18:06 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
        a.zummo@towertech.it, Pan Bian <bianpan2016@163.com>,
        Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Stefan Agner <stefan@agner.ch>,
        Frank Li <Frank.Li@freescale.com>, linux-rtc@vger.kernel.org,
        "# v3 . 16+" <stable@vger.kernel.org>
Subject: Re: [RESEND] [PATCH] rtc: snvs: Fix usage of snvs_rtc_enable
Message-ID: <20180329021803.GI27302@dragon>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Mar 28, 2018 at 08:14:05PM +0100, Bryan O'Donoghue wrote:
> commit 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver") introduces
> the SNVS RTC driver with a function snvs_rtc_enable().
> 
> snvs_rtc_enable() can return an error on the enable path however this
> driver does not currently trap that failure on the probe() path and
> consequently if enabling the RTC fails we encounter a later error spinning
> forever in rtc_write_sync_lp().
> 
> [   36.093481] [<c010d630>] (__irq_svc) from [<c0c2e9ec>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [   36.102122] [<c0c2e9ec>] (_raw_spin_unlock_irqrestore) from [<c072e32c>] (regmap_read+0x4c/0x5c)
> [   36.110938] [<c072e32c>] (regmap_read) from [<c085d0f4>] (rtc_write_sync_lp+0x6c/0x98)
> [   36.118881] [<c085d0f4>] (rtc_write_sync_lp) from [<c085d160>] (snvs_rtc_alarm_irq_enable+0x40/0x4c)
> [   36.128041] [<c085d160>] (snvs_rtc_alarm_irq_enable) from [<c08567b4>] (rtc_timer_do_work+0xd8/0x1a8)
> [   36.137291] [<c08567b4>] (rtc_timer_do_work) from [<c01441b8>] (process_one_work+0x28c/0x76c)
> [   36.145840] [<c01441b8>] (process_one_work) from [<c01446cc>] (worker_thread+0x34/0x58c)
> [   36.153961] [<c01446cc>] (worker_thread) from [<c014aee4>] (kthread+0x138/0x150)
> [   36.161388] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
> [   36.168635] rcu_sched kthread starved for 2602 jiffies! g496 c495 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
> [   36.178564] rcu_sched       R  running task        0     8      2 0x00000000
> [   36.185664] [<c0c288b0>] (__schedule) from [<c0c29134>] (schedule+0x3c/0xa0)
> [   36.192739] [<c0c29134>] (schedule) from [<c0c2db80>] (schedule_timeout+0x78/0x4e0)
> [   36.200422] [<c0c2db80>] (schedule_timeout) from [<c01a7ab0>] (rcu_gp_kthread+0x648/0x1864)
> [   36.208800] [<c01a7ab0>] (rcu_gp_kthread) from [<c014aee4>] (kthread+0x138/0x150)
> [   36.216309] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
> 
> This patch fixes by parsing the result of rtc_write_sync_lp() and
> propagating both in the probe and elsewhere. If the RTC doesn't start we
> don't proceed loading the driver and don't get into this loop mess later
> on.
> 
> Fixes: 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> Cc: a.zummo@towertech.it
> Cc: alexandre.belloni@free-electrons.com
> Cc: Pan Bian <bianpan2016@163.com>
> Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Frank Li <Frank.Li@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
