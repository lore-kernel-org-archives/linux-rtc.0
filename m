Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.46]:32504 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932523AbeCMDmt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 12 Mar 2018 23:42:49 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7568D36539
        for <linux-rtc@vger.kernel.org>; Mon, 12 Mar 2018 22:22:13 -0500 (CDT)
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com>
 <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
 <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <44a4a527-1756-e3de-92e4-c47a8a0c433b@embeddedor.com>
Date: Mon, 12 Mar 2018 22:22:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 03/11/2018 11:39 AM, Krzysztof Kozlowski wrote:
> On Sat, Mar 10, 2018 at 7:27 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
>>
>> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
> 
> Instead of external link (which might or might not work soon) you can
> just put "Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>".
> 

I got it.
I'll do that next time.

> Anyway:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Thanks for reviewing it.
--
Gustavo
