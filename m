Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:53429 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdKHR0m (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 12:26:42 -0500
Received: by mail-io0-f193.google.com with SMTP id 189so6747278iow.10
        for <linux-rtc@vger.kernel.org>; Wed, 08 Nov 2017 09:26:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108120815.3175571-1-arnd@arndb.de>
References: <20171108120815.3175571-1-arnd@arndb.de>
From: Loc Ho <lho@apm.com>
Date: Wed, 8 Nov 2017 09:26:41 -0800
Message-ID: <CAPw-ZT=dryHW9i4v=U-te7BEfhD-_0zUy40Uei8mLh2sY1gcOg@mail.gmail.com>
Subject: Re: [PATCH] rtc: x-gene: mark PM functions as __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Brown <broonie@linaro.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

> The new xgene_rtc_alarm_irq_enabled() function is only accessed
> from PM code, which is inside of an #ifdef; this causes a harmless
> build warning when CONFIG_PM is disabled:
>
> drivers/rtc/rtc-xgene.c:108:12: error: 'xgene_rtc_alarm_irq_enabled' defined but not used [-Werror=unused-function]
>
> Just remove the #ifdef and use __maybe_unused annotations instead,
> to make the code more robust here.

It sounds like desire to merge in the suspend/resume support as this
is in linux-next 14 hours ago.

Reviewed-by: Loc Ho <lho@apm.com>

-Loc
