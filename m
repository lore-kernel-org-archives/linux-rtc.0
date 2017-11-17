Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44053 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162025AbdKQXvr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 17 Nov 2017 18:51:47 -0500
Subject: Re: [PATCH] rtc: brcmstb-waketimer: fix error handling in
 brcmstb_waketmr_probe()
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Brian Norris <computersforpeace@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ec00086a-1e5d-a72e-77ea-a93f27f7244e@gmail.com>
Date: Fri, 17 Nov 2017 15:51:40 -0800
MIME-Version: 1.0
In-Reply-To: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 11/17/2017 01:15 PM, Alexey Khoroshilov wrote:
> brcmstb_waketmr_probe() does not disable timer->clk on error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
