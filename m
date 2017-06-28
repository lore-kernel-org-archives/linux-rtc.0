Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdF1XPE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 28 Jun 2017 19:15:04 -0400
Subject: Re: [PATCH] rtc: brcmstb-waketimer: fix settime function
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20170628200839.3114345-1-arnd@arndb.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e8c1c77c-dd16-afa8-509a-417e0ab7535c@gmail.com>
Date: Wed, 28 Jun 2017 16:14:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170628200839.3114345-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/28/2017 01:07 PM, Arnd Bergmann wrote:
> gcc warns about an unused variable in the new driver:
> 
> drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
> drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]
> 
> The same function also doesn't handle overflow correctly, this makes
> it return -EINVAL when passed a time that doesn't fit within the
> range of the register.

Yes, thanks for doing that.

> 
> Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
