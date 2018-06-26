Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19486 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeFZPvo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Jun 2018 11:51:44 -0400
Subject: Re: [GIT PULL] RTC for 4.18
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180610221645.GA26123@piout.net>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
Date: Tue, 26 Jun 2018 16:51:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180610221645.GA26123@piout.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 10/06/18 23:16, Alexandre Belloni wrote:
> Hi Linus,
> 
> Here is the pull-request for the RTC subsystem for 4.18.
> 
> Setting the supported range from drivers for RTCs failing soon has
> started. A few fixes are developed along the way.
> Some drivers have been switched to SPDX by their maintainers.
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.18
> 
> for you to fetch changes up to e4302aec8a0646828a701443e303eb5ef48b37f5:
> 
>   rtc: pxa: fix probe function (2018-06-07 20:11:08 +0200)
> 
> ----------------------------------------------------------------
> RTC for 4.18
> 
> Subsystem:
>  - rework of the rtc-test driver which allows to test the core more thoroughly
>  - rtc_set_alarm() now fails early when alarms are not supported
> 
> Drivers:
>  - mktime is now replaced by mktime64
>  - RTC range added for 88pm80x, ab-b5ze-s3, at91rm9200, brcmstb-waketimer,
>    ds1685, ftrtc010, ls1x, mxc_v2, rx8581, sprd, st-lpc, tps6586x, tps65910 and
>    vr41xx
>  - Fixed a possible race condition in probe functions
>  - pxa: fix the probe function that is broken since v4.3
>  - stm32: now supports stm32mp1
> 
> ----------------------------------------------------------------
> Alexandre Belloni (49):

...

>       rtc: tps6586x: let the core handle rtc range

Sorry I am missing the original mail with the above change, but I
have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
longer working on one of our Tegra boards. The bisect points to the
above change and reverting it fixes the problem. I have not had
chance to dig further, but if you have any thoughts, please let me
know.

Thanks!
Jon

-- 
nvpublic
