Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.148.2]:33937 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeHXCSi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Aug 2018 22:18:38 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 5CF74D886
        for <linux-rtc@vger.kernel.org>; Thu, 23 Aug 2018 17:01:26 -0500 (CDT)
Subject: Re: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
To: Kees Cook <keescook@chromium.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180823185140.GA29028@embeddedor.com>
 <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7a213f7c-354c-06d5-7b14-fc69e9bb8a31@embeddedor.com>
Date: Thu, 23 Aug 2018 17:01:11 -0500
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 8/23/18 3:56 PM, Kees Cook wrote:

>>
>> -       clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
>> -                          GFP_KERNEL);
>> +       clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
>>         if (!clk_data) {
>>                 kfree(rtc);
>>                 return;
> 
> This looks like entirely correct to me, but I'm surprised the
> Coccinelle script didn't discover this. I guess the isomorphisms don't
> cover the parenthesis?
> 

Apparently.

If I manually remove the ()s, the cocci script successfully generates a patch.

--
Gustavo
