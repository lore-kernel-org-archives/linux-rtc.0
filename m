Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47992 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYVV7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 17:21:59 -0400
Date: Wed, 25 Oct 2017 23:21:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8523: add support for trimming the RTC oscillator
Message-ID: <20171025212157.iwuw6rknrcue2wq2@piout.net>
References: <E1dxsSG-0006RT-3r@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1dxsSG-0006RT-3r@rmk-PC.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/09/2017 at 11:23:36 +0100, Russell King wrote:
> Add support for reading and writing the RTC offset register, converting
> it to the corresponding parts-per-billion value.
> 
> When setting the drift, the PCF8523 has two modes: one applies the
> adjustment every two hours, the other applies the adjustment every
> minute.  We select between these two modes according to which ever
> gives the closest PPB value to the one requested.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/rtc-pcf8523.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
