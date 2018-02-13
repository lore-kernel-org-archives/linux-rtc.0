Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36909 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965611AbeBMUc2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Feb 2018 15:32:28 -0500
Date: Tue, 13 Feb 2018 21:32:16 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, arnd@arndb.de, broonie@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] rtc: Fix overflow when converting time64_t to
 rtc_time
Message-ID: <20180213203216.GC30929@piout.net>
References: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 26/01/2018 at 13:06:01 +0800, Baolin Wang wrote:
> If we convert one large time values to rtc_time, in the original formula
> 'days * 86400' can be overflowed in 'unsigned int' type to make the formula
> get one incorrect remain seconds value. Thus we can use div_s64_rem()
> function to avoid this situation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-lib.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
