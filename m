Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48066 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYVYD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 17:24:03 -0400
Date: Wed, 25 Oct 2017 23:24:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: armada38x: add support for trimming the RTC
Message-ID: <20171025212401.bjcydrc6mg3jpoe5@piout.net>
References: <E1dxsSB-0006RM-08@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1dxsSB-0006RM-08@rmk-PC.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/09/2017 at 11:23:31 +0100, Russell King wrote:
> Add support for trimming the RTC using the offset mechanism.  This RTC
> supports two modes: low update mode and high update mode.  Low update
> mode has finer precision than high update mode, so we use the low mode
> where possible.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/rtc-armada38x.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
