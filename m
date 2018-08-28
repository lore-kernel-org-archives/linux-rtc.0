Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23424
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbeH1UcP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 28 Aug 2018 16:32:15 -0400
Date: Tue, 28 Aug 2018 09:39:41 -0700
From: Paul Burton <paul.burton@mips.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, keguang.zhang@gmail.com,
        y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rtc: mips: default to rtc-cmos on mips
Message-ID: <20180828163941.ztftznl7q4745u7f@pburton-laptop>
References: <20180828142724.4067857-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180828142724.4067857-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Arnd,

On Tue, Aug 28, 2018 at 04:26:30PM +0200, Arnd Bergmann wrote:
> The old rtc driver is getting in the way of some compat_ioctl
> simplification. Looking up the loongson64 git history, it seems
> that everyone uses the more modern but compatible RTC_CMOS driver
> anyway, so let's remove the special case for loongson64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/Kconfig    | 2 +-
>  drivers/char/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks good to me - history suggests Loongson's RTC needs to use binary
mode for some reason but we've had that support for a while.

Presuming you want this to go through the RTC tree:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
