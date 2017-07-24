Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:53250 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdGXDWv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 23 Jul 2017 23:22:51 -0400
MIME-Version: 1.0
In-Reply-To: <1499857190-30849-2-git-send-email-alexey.klimov@arm.com>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com> <1499857190-30849-2-git-send-email-alexey.klimov@arm.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 11:22:26 +0800
Message-ID: <CAGb2v65mqkSfy_ebgEz+VKrY05AvwXQ4Ei_fuFWYYW73Qs=PnA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: sun6i: fix memleaks and add error-path in sun6i_rtc_clk_init()
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 12, 2017 at 6:59 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
> The memory allocated for rtc and clk_data will never be freed in
> sun6i_rtc_clk_init() in case of error and return. This patch adds
> required error path with memory freeing.
>
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 7e7da60..77bc4d3 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -197,14 +197,14 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>         clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws),
>                            GFP_KERNEL);
>         if (!clk_data)
> -               return;
> +               goto out_rtc_free;
>
>         spin_lock_init(&rtc->lock);
>
>         rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
>         if (IS_ERR(rtc->base)) {
>                 pr_crit("Can't map RTC registers");
> -               return;
> +               goto out_clk_data_free;
>         }
>
>         /* Switch to the external, more precise, oscillator */
> @@ -216,7 +216,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>
>         /* Deal with old DTs */
>         if (!of_get_property(node, "clocks", NULL))
> -               return;
> +               goto out_clk_data_free;
>
>         rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
>                                                                 "rtc-int-osc",
> @@ -225,7 +225,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>                                                                 300000000);
>         if (IS_ERR(rtc->int_osc)) {
>                 pr_crit("Couldn't register the internal oscillator\n");
> -               return;
> +               goto out_clk_data_free;
>         }
>
>         parents[0] = clk_hw_get_name(rtc->int_osc);
> @@ -240,12 +240,19 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>         rtc->losc = clk_register(NULL, &rtc->hw);
>         if (IS_ERR(rtc->losc)) {
>                 pr_crit("Couldn't register the LOSC clock\n");
> -               return;
> +               goto out_clk_data_free;

You should also unregister the fixed rate clk above.

>         }
>
>         clk_data->num = 1;
>         clk_data->hws[0] = &rtc->hw;
>         of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +
> +       return;
> +
> +out_clk_data_free:
> +       kfree(clk_data);
> +out_rtc_free:
> +       kfree(rtc);

rtc can not be freed. It has already been assigned to sun6i_rtc, a static
variable within this module. It then gets used by the actual RTC driver
later in this file to get the register base pointer. This was done to
avoid issues with trying to map the same I/O addresses twice.


Regards
ChenYu

>  }
>  CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
>                       sun6i_rtc_clk_init);
> --
> 1.9.1
>
