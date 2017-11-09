Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46304 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdKIKiq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 9 Nov 2017 05:38:46 -0500
MIME-Version: 1.0
In-Reply-To: <672d468478f3f67ef22e027460c59918dc581818.1510211132.git.baolin.wang@linaro.org>
References: <672d468478f3f67ef22e027460c59918dc581818.1510211132.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Nov 2017 11:38:45 +0100
Message-ID: <CAK8P3a0tC53_5cdfd1N2LEg7Mjt6as923h9vbfBd_=k6MRo=Jw@mail.gmail.com>
Subject: Re: [PATCH] rtc: Use time64_t variables to set time/alarm from sysfs
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Nov 9, 2017 at 8:09 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Use time64_t variables and related APIs for sysfs interfaces to
> support setting time or alarm after the year 2038 on 32-bit system.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>


Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
