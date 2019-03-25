Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36449C43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0739720872
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CmyVWRez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfCYK7d (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:59:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52048 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfCYK7d (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LD62qjJ8gD6vRiKk/wivq6I0bTSFuD8aTc/BlE1OlPs=; b=CmyVWRezC+I3IX4IOmhw13z/z
        UW0IA80zy7lUT3FS5xprsz2jJu3iHiqoS+Sfgs+Sool+j9vwKvGqOgC2gISjmsXlLRDqcaZ8Jg20A
        rkuyexsIijlqUCtRk0tc5KDEdI6fGcEKeOYJ3vb96mU1mq3FOUrLEArvUvMZA9XEmNcDwiRxBvNp4
        zXTwvR2fiaJ1A0YusNPCsFIMcjbIkB3zOE0yaabCcWnP9WVM5QeARqJM6awo6xwrPvEby3IXpm4yw
        UZb7Izd32HkRYUF6unTSBZyRUIP/OYvlUSA+t5THhI/lEla9a5f3O6lNbnxcp+4XFQVHmEaDqmf99
        dEel4lUAw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37512)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h8NK8-00024G-NG; Mon, 25 Mar 2019 10:59:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h8NK4-000330-NM; Mon, 25 Mar 2019 10:59:20 +0000
Date:   Mon, 25 Mar 2019 10:59:20 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, t-kristo@ti.com, linux-rtc@vger.kernel.org,
        d-gerlach@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] AM437x: Add rtc-only + DDR mode support
Message-ID: <20190325105920.4se5hjul2srkzre7@shell.armlinux.org.uk>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
 <1fadeed8-b091-43c8-e7ec-f29ad0fff82c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fadeed8-b091-43c8-e7ec-f29ad0fff82c@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, Mar 25, 2019 at 07:13:53AM +0530, keerthy wrote:
> 
> 
> On 3/23/2019 12:02 AM, Russell King - ARM Linux admin wrote:
> > On Fri, Mar 22, 2019 at 10:46:14PM +0530, Keerthy wrote:
> > > RTC plus DDR in self-refresh is power a saving mode where in the entire
> >                                   "a power" ?
> 
> Will correct the above typo.
> 
> > 
> > > system including the different voltage rails from PMIC are shutdown except
> > > the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
> 
> As explained above All the voltage rails of PMIC are shut off except for RTC
> and DDR Rails.

You seem to be replying to yourself there - the quote above your reply
there is what you wrote.

> 
> > > contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
> > > we the ALARM2 is triggered we enter the mode with DDR in self-refresh
> > 
> > Doesn't make sense.
> > 
> > > and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
> > > up the system.
> > 
> > Huh, you start off explaining the wiring above... how does RTC ALARM1
> > trigger waking up the system if RTC ALARM2 is connected to the PMIC
> > and all other power is shut down?
> The entire PMIC is shutdown but for RTC rail. RTC is a separate voltage
> domain and is powered up during this power save mode.
> 
> http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884.

I'm not asking for a reference, I'm asking for your cover letter to
make sense and actually be useful.  Right now, it's far from that.

Thanks.

> 
> > 
> > > The control goes to bootloader. The bootloader then checks
> > > RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
> > > a different path, configure bare minimal clocks for ddr and then jumps to
> > > the resume address in another RTC scratchpad registers and transfers the
> > > control to Kernel. Kernel then restores the saved context.
> > > 
> > > The patch series adds rtc-only + DDR mode support am am437x
> > > Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.
> > > 
> > > This mode works only with u-boot built with am43xx_evm_rtconly_defconfig
> > > 
> > > Additional patch is needed for omap-gpio save restore which will
> > > come as fixes later.
> > > 
> > > Keerthy (5):
> > >    rtc: OMAP: Add support for rtc-only mode
> > >    rtc: interface: Add power_off_program to rtc_class_ops
> > >    arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
> > >    soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
> > >    soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support
> > > 
> > >   arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
> > >   drivers/rtc/interface.c              |  12 ++
> > >   drivers/rtc/rtc-omap.c               |  49 ++++-
> > >   drivers/soc/ti/Kconfig               |   5 +-
> > >   drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
> > >   include/linux/platform_data/pm33xx.h |   5 +
> > >   include/linux/rtc.h                  |   2 +
> > >   7 files changed, 360 insertions(+), 61 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
