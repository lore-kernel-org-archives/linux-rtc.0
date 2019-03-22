Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D2C10F03
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2C21900
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 18:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iz00YmRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfCVSdM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:33:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38616 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfCVSdL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 14:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KqXN5O/SZIXg6irWcn05SYJu+QOU2tBTjmq0sKF5fVE=; b=iz00YmRK128LkNEt/CuECtdon
        DcZcY/yswkI3u9Fppg+37G7TE+EffNwXEwFU+m4hnB9TxBvkZmKVJYDrRhc/mjPka37Kr3tAd95Dw
        9wr467k8afJKY0LyGMiFGistNlMf+U38VS0iNX8LA1P54/ee25Fm8R+UH0reG1T6hxOnmqsj9MPsG
        BYFS+PA+4g/Zen5lN8QZApJ3Rj3k+kmDp5jC/0AMsphanh1zBnXvJHsz8j66E+kcHKcLkLCAsok6N
        Zp5S1ZXGTXDpR6OWEHmbf7NG2sgBRG66GMnVWfdEJb6Clstk/Elzi2rC5gsIbcoFuh9Uu9VL1HsCh
        Ww2JS5Ohw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37488)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h7OyP-0002fM-US; Fri, 22 Mar 2019 18:32:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h7OyL-0000nT-Ul; Fri, 22 Mar 2019 18:32:53 +0000
Date:   Fri, 22 Mar 2019 18:32:53 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, t-kristo@ti.com, linux-rtc@vger.kernel.org,
        d-gerlach@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5]  AM437x: Add rtc-only + DDR mode support
Message-ID: <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
References: <20190322171619.4180-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322171619.4180-1-j-keerthy@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Mar 22, 2019 at 10:46:14PM +0530, Keerthy wrote:
> RTC plus DDR in self-refresh is power a saving mode where in the entire
                                 "a power" ?

> system including the different voltage rails from PMIC are shutdown except
> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
> contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
> we the ALARM2 is triggered we enter the mode with DDR in self-refresh

Doesn't make sense.

> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
> up the system.

Huh, you start off explaining the wiring above... how does RTC ALARM1
trigger waking up the system if RTC ALARM2 is connected to the PMIC
and all other power is shut down?

> The control goes to bootloader. The bootloader then checks
> RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
> a different path, configure bare minimal clocks for ddr and then jumps to
> the resume address in another RTC scratchpad registers and transfers the
> control to Kernel. Kernel then restores the saved context.
> 
> The patch series adds rtc-only + DDR mode support am am437x
> Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.
> 
> This mode works only with u-boot built with am43xx_evm_rtconly_defconfig
> 
> Additional patch is needed for omap-gpio save restore which will
> come as fixes later.
> 
> Keerthy (5):
>   rtc: OMAP: Add support for rtc-only mode
>   rtc: interface: Add power_off_program to rtc_class_ops
>   arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
>   soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
>   soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support
> 
>  arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
>  drivers/rtc/interface.c              |  12 ++
>  drivers/rtc/rtc-omap.c               |  49 ++++-
>  drivers/soc/ti/Kconfig               |   5 +-
>  drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
>  include/linux/platform_data/pm33xx.h |   5 +
>  include/linux/rtc.h                  |   2 +
>  7 files changed, 360 insertions(+), 61 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
