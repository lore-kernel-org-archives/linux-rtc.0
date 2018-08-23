Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37573 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeHXB2l (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Aug 2018 21:28:41 -0400
Received: by mail-yb0-f195.google.com with SMTP id f145-v6so2778265ybg.4
        for <linux-rtc@vger.kernel.org>; Thu, 23 Aug 2018 14:57:01 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 138-v6sm1823526ywj.30.2018.08.23.14.56.59
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 14:56:59 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id 14-v6so2389372ywe.2
        for <linux-rtc@vger.kernel.org>; Thu, 23 Aug 2018 14:56:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823185140.GA29028@embeddedor.com>
References: <20180823185140.GA29028@embeddedor.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 23 Aug 2018 14:56:57 -0700
Message-ID: <CAGXu5jLOg-uB3wsyRNJd2rFEoT9_u2Q0YQXVWv38Z946S_t6xw@mail.gmail.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
