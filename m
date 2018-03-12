Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39581 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLIyN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 12 Mar 2018 04:54:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id r66so7193399wrb.6
        for <linux-rtc@vger.kernel.org>; Mon, 12 Mar 2018 01:54:12 -0700 (PDT)
Date: Mon, 12 Mar 2018 08:54:08 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
Message-ID: <20180312085408.juqhh5pvgno5zag6@dell>
References: <cover.1520660422.git.gustavo@embeddedor.com>
 <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, 10 Mar 2018, Gustavo A. R. Silva wrote:

> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
> 
> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-s5m.c           | 11 +++++++++++
>  include/linux/mfd/samsung/rtc.h | 11 -----------

I don't think this will conflict with anything (unless some major
works are carried out within the next few weeks - in which case I'll
need a pull-request, but for now ...)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
