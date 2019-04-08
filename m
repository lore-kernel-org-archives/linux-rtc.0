Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37EC10F13
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0983A213F2
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDHR06 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:26:58 -0400
Received: from muru.com ([72.249.23.125]:44812 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfDHR06 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 8 Apr 2019 13:26:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7D2D680AA;
        Mon,  8 Apr 2019 17:27:12 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:26:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Message-ID: <20190408172654.GL49658@atomide.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403045742.2243-1-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190402 21:57]:
> RTC plus DDR in self-refresh is a power saving mode where in the entire
> system including the different voltage rails from PMIC are shutdown except
> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
> contents are preserved.
> 
> RTC ALARM2 is connected to PMIC_EN line. TPS65218 PMIC has granular voltage rail
> control. The voltage rail feeding RTC is kept on while the rest of the PMIC
> regulators are powered off.
> 
> Once the ALARM2 is triggered we enter the mode with DDR in self-refresh
> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers
> waking up the system. The control goes to bootloader. The bootloader then checks
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
> Hardware Description of this mode can be found here: 
> 
> http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884.
>
> Changes in v3:
> 
>   * Exported out omap_rtc_poweroff_program function & removed
>     the patch to add a generic rtc interface as it is specific
>     to am43 at the moment.

Thanks I'll be applying this series into omap-for-v5.2/am4-pm
today.

Regards,

Tony
