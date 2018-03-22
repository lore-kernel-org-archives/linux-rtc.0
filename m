Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeCVPWV (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:21 -0400
Date: Thu, 22 Mar 2018 16:22:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver/rtc: remove a warning during scripts/kernel-doc
 step
Message-ID: <20180322152208.GV3417@piout.net>
References: <20180201164714.25709-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180201164714.25709-1-malat@debian.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 01/02/2018 at 17:47:14 +0100, Mathieu Malaterre wrote:
> During compilation using W=1 one would get:
> 
> drivers/rtc/systohc.c:11: info: Scanning doc for rtc_set_ntp_time
> drivers/rtc/systohc.c:23: warning: bad line:  (
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/systohc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
