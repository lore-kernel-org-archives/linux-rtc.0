Return-Path: <rtc-linux+bncBCMILY6JWQBBBPNWRPCAKGQE6OJA3AQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id r8si2387492pfa.5.2017.01.20.19.53.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jan 2017 19:53:32 -0800 (PST)
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com [209.85.223.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id C1795226B0
	for <rtc-linux@googlegroups.com>; Sat, 21 Jan 2017 11:53:30 +0800 (CST)
Received: by mail-io0-f179.google.com with SMTP id v96so12863354ioi.0
        for <rtc-linux@googlegroups.com>; Fri, 20 Jan 2017 19:53:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
 <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 21 Jan 2017 11:53:08 +0800
Message-ID: <CAGb2v650f-4RZ6RrRBGcmPz8mJ4KbJwTTj6=w3HeSWUZtLAKcw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 4/6] rtc: sun6i: Force the mux to the external oscillator
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Fri, Jan 20, 2017 at 11:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The internal oscillator is way too inaccurate to do something useful with
> it. Switch to the external oscillator if it is available.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index edd5627da10f..1695fae24cd5 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -493,6 +493,7 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
>  static int sun6i_rtc_probe(struct platform_device *pdev)
>  {
>         struct sun6i_rtc_dev *chip = sun6i_rtc;
> +       struct clk *parent;
>         int ret;
>
>         if (!chip)
> @@ -540,6 +541,17 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
>         /* disable alarm wakeup */
>         writel(0, chip->base + SUN6I_ALARM_CONFIG);
>
> +       parent = clk_get(&pdev->dev, NULL);
> +       if (!IS_ERR(parent)) {
> +               ret = clk_set_parent(chip->losc, parent);
> +               clk_put(parent);
> +
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "Failed to reparent the RTC to the external oscillator\n");
> +                       return ret;
> +               }
> +       }

Following what I mentioned in patch 1, maybe it is easier to force
the mux before the clocks are registered by writing directly to
the registers? We could also backport the changes to stable?

ChenYu

>         clk_prepare_enable(chip->losc);
>
>         chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
> --
> git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
