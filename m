Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55132 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbdKIASH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 19:18:07 -0500
Date: Thu, 9 Nov 2017 01:17:57 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Loc Ho <lho@apm.com>,
        Mark Brown <broonie@linaro.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: x-gene: mark PM functions as __maybe_unused
Message-ID: <20171109001757.ejakbizypi4sbgmh@piout.net>
References: <20171108120815.3175571-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108120815.3175571-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 08/11/2017 at 13:08:10 +0100, Arnd Bergmann wrote:
> The new xgene_rtc_alarm_irq_enabled() function is only accessed
> from PM code, which is inside of an #ifdef; this causes a harmless
> build warning when CONFIG_PM is disabled:
> 
> drivers/rtc/rtc-xgene.c:108:12: error: 'xgene_rtc_alarm_irq_enabled' defined but not used [-Werror=unused-function]
> 
> Just remove the #ifdef and use __maybe_unused annotations instead,
> to make the code more robust here.
> 
> Fixes: 9f8f1c8b727d ("rtc: Fix suspend/resume for APM X-Gene SoC RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-xgene.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
