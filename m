Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070AAC10F05
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 06:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AEA20830
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 06:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfCTGIw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:08:52 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54823 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTGIw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 02:08:52 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E4D80FF805;
        Wed, 20 Mar 2019 06:08:49 +0000 (UTC)
Date:   Wed, 20 Mar 2019 07:08:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rtc: omap: let the core handle range
Message-ID: <20190320060845.GL29054@piout.net>
References: <20190318124438.26327-1-alexandre.belloni@bootlin.com>
 <20190318124438.26327-2-alexandre.belloni@bootlin.com>
 <c9079ac1-0155-f5d8-2fce-3c94e99b7b3a@ti.com>
 <20190320051051.GJ29054@piout.net>
 <11d60e1a-a884-80e7-f206-ccf8cb58692e@ti.com>
 <6f9ff9e5-abb0-4aa4-5697-02799943bd25@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9ff9e5-abb0-4aa4-5697-02799943bd25@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 20/03/2019 11:25:31+0530, Keerthy wrote:
> Hi Alexandre,
> 
> https://pastebin.ubuntu.com/p/8w6HXKV6St/
> 
> I applied this patch on top of linux-next. I am able to wake up from rtc
> from suspend to memory on am33-bbb.
> 
> Also i tried your commands:
> 
> echo +5 > /sys/class/rtc/rtc0/wakealarm ; echo mem > /sys/power/state
> [  147.046018] PM: suspend entry (deep)
> [  147.049675] PM: Syncing filesystems ... done.
> [  147.071869] Freezing user space processes ... (elapsed 0.001 seconds)
> done.
> [  147.080658] OOM killer disabled.
> [  147.083974] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [  147.092830] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [  147.233280] cpsw 4a100000.ethernet eth0: Link is Down
> [  147.248012] Disabling non-boot CPUs ...
> [  147.248048] pm33xx pm33xx: PM: Successfully put all powerdomains to
> target state
> [  147.270934] net eth0: initializing cpsw version 1.12 (0)
> [  147.374824] SMSC LAN8710/LAN8720 4a101000.mdio:00: attached PHY driver
> [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=4a101000.mdio:00, irq=POLL)
> [  147.562211] OOM killer enabled.
> [  147.565489] Restarting tasks ... done.
> [  147.616203] PM: suspend exit
> 
> That also worked fine.
> 
> For am335x-boneblack as well this patch works.
> 

Ok, thanks a lot for confirming, I'll try to fix my setup, I'm probably
just missing the m3 firmware.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
