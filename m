Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36909 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeAZJYr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 26 Jan 2018 04:24:47 -0500
MIME-Version: 1.0
In-Reply-To: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
References: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Jan 2018 10:24:46 +0100
Message-ID: <CAK8P3a0HBYckf4eQUONg6yzai3emGYODAu6mTFpY+s6RUJ2NbA@mail.gmail.com>
Subject: Re: [RESEND PATCH] rtc: Fix overflow when converting time64_t to rtc_time
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Jan 26, 2018 at 6:06 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> If we convert one large time values to rtc_time, in the original formula
> 'days * 86400' can be overflowed in 'unsigned int' type to make the formula
> get one incorrect remain seconds value. Thus we can use div_s64_rem()
> function to avoid this situation.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
