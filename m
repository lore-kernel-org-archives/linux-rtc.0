Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42389 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdJLPHH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 11:07:07 -0400
Date: Thu, 12 Oct 2017 17:07:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Make PL031 interrupt optional
Message-ID: <20171012150705.zwpkvjhxigcd2puj@piout.net>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/09/2017 at 11:21:16 +0100, Russell King - ARM Linux wrote:
> There are some boards out there which have a PL031 RTC, but its
> interrupt is not wired up.  To support these, we need the PL031
> to support the primecell without interrupts.
> 
> When no interrupt is present, there's little point exposing the
> RTC's alarm capabilities, so we omit the alarm-related function
> calls - the RTC merely becomes a source of time-of-day.
> 
> This patch series cleans up the pl031 driver a little, and adds
> support for this configuration.
> 
>  drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> v2: update patch 2 & 3 for review comment on v1.
> 

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
