Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46601 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbdK2VLw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 29 Nov 2017 16:11:52 -0500
Date: Wed, 29 Nov 2017 22:11:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Brian Norris <computersforpeace@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        bcm-kernel-feedback-list@broadcom.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: fix error handling in
 brcmstb_waketmr_probe()
Message-ID: <20171129211141.GR21126@piout.net>
References: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/11/2017 at 00:15:58 +0300, Alexey Khoroshilov wrote:
> brcmstb_waketmr_probe() does not disable timer->clk on error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
