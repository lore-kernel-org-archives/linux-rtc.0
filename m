Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54661 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdJZJec (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 26 Oct 2017 05:34:32 -0400
Date: Thu, 26 Oct 2017 11:34:30 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: sean.wang@mediatek.com
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] rtc: mediatek: add support for SoC based RTC on
 MT7622
Message-ID: <20171026093430.aw4rpjffrvrzycga@piout.net>
References: <cover.1508741262.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1508741262.git.sean.wang@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 23/10/2017 at 15:16:43 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v2:
> - Remove time extension with yr_base 
> - Add fixup that ensures all time fields in hardware keeping consistency
> inside the mtk_rtc_get_alarm_or_time call
> - Add validity for time range should be between 2001 to 2099
> - Enhance comments with aligned style and explanation for certain limiation in
> hardware
> - Rename dt-binding naming from rtc-mediatek.txt to rtc-mt7622.txt
> - Rename config naming from RTC_DRV_MEDIATEK to RTC_DRV_MT7622
> 
> Changes since v1:
> - Rename to rtc-mt7622.c from rtc-mediatek.c
> - Use [readl,writel]_relaxed instead of __raw_* version
> - Remove redundant register reading in mtk_rtc_get_alarm_or_time()
> - Stop alarm when alarm is really expired in mtk_rtc_alarmirq()
> - Extend the maximum year the RTC/Alarm can count/support using year rebasing
> - Remove unnesscary log which is already done in core layer
> 
> This patchset introduces support for MediaTek SoC based real time clock
> (RTC) Currently, the driver is already tested successfully with hwclock
> and wakealarm on MT7622 SoC. And it should also be workable on other
> similar MediaTek SoCs. And patch 3 is a distinct patch used to distinguish
> between either SoC based or PMIC based RTC to avoid confusion for the RTC
> selection for the target SoC.
> 
> Sean Wang (4):
>   dt-bindings: rtc: mediatek: add bindings for MediaTek SoC based RTC
>   rtc: mediatek: add driver for RTC on MT7622 SoC
>   rtc: mediatek: enhance the description for MediaTek PMIC based RTC
>   rtc: mediatek: update MAINTAINERS entry with MediaTek RTC driver
> 

All applied, thanks. (I've alphabetically ordered Kconfig and Makefile
entries in patch 2)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
