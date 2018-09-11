Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52198 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeIKUju (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Sep 2018 16:39:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so1508785wma.1
        for <linux-rtc@vger.kernel.org>; Tue, 11 Sep 2018 08:39:58 -0700 (PDT)
Date: Tue, 11 Sep 2018 16:39:54 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] mfd: menelaus: fix possible race condition and leak
Message-ID: <20180911153954.GA4185@dell>
References: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sun, 09 Sep 2018, Alexandre Belloni wrote:

> The IRQ work is added before the struct rtc is allocated and registered,
> but this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before calling menelaus_add_irq_work.
> 
> Also, this solves a possible leak as the RTC is never released.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Lee,
> 
> If that is ok with you, I would like to take this patch through the RTC
> tree. So I can have a follow up patch removing rtc_device_register().
> 
> Thanks
> 
>  drivers/mfd/menelaus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
