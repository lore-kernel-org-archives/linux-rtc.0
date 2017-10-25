Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48054 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYVXt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 17:23:49 -0400
Date: Wed, 25 Oct 2017 23:23:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: clarify the RTC offset correction
Message-ID: <20171025212347.ii4yvurhjf3mdwnp@piout.net>
References: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/09/2017 at 11:23:25 +0100, Russell King wrote:
> The RTC offset correction documentation is not very clear about the
> exact relationship between "offset" and the effect it has on the RTC.
> Supplement the documentation with an equation giving the relationship.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/interface.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
