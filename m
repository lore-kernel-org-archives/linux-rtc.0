Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34493 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeHXA2G (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Aug 2018 20:28:06 -0400
Received: by mail-yb0-f194.google.com with SMTP id t10-v6so2667756ybb.1
        for <linux-rtc@vger.kernel.org>; Thu, 23 Aug 2018 13:56:40 -0700 (PDT)
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com. [209.85.213.169])
        by smtp.gmail.com with ESMTPSA id o74-v6sm7588327ywo.54.2018.08.23.13.56.37
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:56:38 -0700 (PDT)
Received: by mail-yb0-f169.google.com with SMTP id k5-v6so2654101ybo.10
        for <linux-rtc@vger.kernel.org>; Thu, 23 Aug 2018 13:56:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823185140.GA29028@embeddedor.com>
References: <20180823185140.GA29028@embeddedor.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 23 Aug 2018 13:56:35 -0700
Message-ID: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
Subject: Re: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Aug 23, 2018 at 11:51 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 2cd5a7b..fe07310 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -199,8 +199,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>         if (!rtc)
>                 return;
>
> -       clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
> -                          GFP_KERNEL);
> +       clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
>         if (!clk_data) {
>                 kfree(rtc);
>                 return;

This looks like entirely correct to me, but I'm surprised the
Coccinelle script didn't discover this. I guess the isomorphisms don't
cover the parenthesis?

-Kees

-- 
Kees Cook
Pixel Security
