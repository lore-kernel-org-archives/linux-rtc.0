Return-Path: <rtc-linux+bncBCYKZMUQ7QBBBI7F765QKGQEDNOXJCQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id c11si649370pfc.2.2016.07.08.11.36.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 11:36:19 -0700 (PDT)
Received: by mail-pa0-x22d.google.com with SMTP id b13so14543011pat.0
        for <rtc-linux@googlegroups.com>; Fri, 08 Jul 2016 11:36:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>, "Lee Jones" <lee.jones@linaro.org>,
 "Alessandro Zummo" <a.zummo@towertech.it>,
 "Alexandre Belloni" <alexandre.belloni@free-electrons.com>,
 "Rob Herring" <robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Maxime Ripard" <maxime.ripard@free-electrons.com>,
 "Stephen Boyd" <sboyd@codeaurora.org>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1467302331-9663-5-git-send-email-wens@csie.org>
Cc: "Chen-Yu Tsai" <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
 rtc-linux@googlegroups.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-5-git-send-email-wens@csie.org>
Message-ID: <146800297598.73491.13472152266331488346@resonance>
Subject: [rtc-linux] Re: [PATCH v4 4/7] rtc: ac100: Add clk output support
Date: Fri, 08 Jul 2016 11:36:16 -0700
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Quoting Chen-Yu Tsai (2016-06-30 08:58:48)
> +static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long prate)
> +{
> +       unsigned long best_rate = 0, tmp_rate, tmp_prate;
> +       int i;
> +
> +       if (prate == AC100_RTC_32K_RATE)
> +               return divider_round_rate(hw, rate, &prate, NULL,
> +                                         AC100_CLKOUT_DIV_WIDTH,
> +                                         CLK_DIVIDER_POWER_OF_TWO);
> +
> +       for (i = 0; ac100_clkout_prediv[i].div; i++) {
> +               tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
> +               tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
> +                                             AC100_CLKOUT_DIV_WIDTH,
> +                                             CLK_DIVIDER_POWER_OF_TWO);
> +
> +               if (tmp_rate > rate)
> +                       continue;
> +               if (rate - tmp_rate < best_rate - tmp_rate)
> +                       best_rate = tmp_rate;
> +       }
> +
> +       return best_rate;
> +}
> +
> +static int ac100_clkout_determine_rate(struct clk_hw *hw,
> +                                      struct clk_rate_request *req)
> +{
> +       struct clk_hw *best_parent;
> +       unsigned long best = 0;
> +       int i, num_parents = clk_hw_get_num_parents(hw);
> +
> +       for (i = 0; i < num_parents; i++) {
> +               struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +               unsigned long tmp, prate = clk_hw_get_rate(parent);
> +
> +               tmp = ac100_clkout_round_rate(hw, req->rate, prate);
> +
> +               if (tmp > req->rate)
> +                       continue;
> +               if (req->rate - tmp < req->rate - best) {
> +                       best = tmp;
> +                       best_parent = parent;
> +               }
> +       }
> +
> +       if (!best)
> +               return -EINVAL;
> +
> +       req->best_parent_hw = best_parent;
> +       req->best_parent_rate = best;
> +       req->rate = best;
> +
> +       return 0;
> +}

You only need one of the two functions above. Keep the .determine_rate
callback and drop .round_rate.

Otherwise the rest of the clk support looks great to me. Feel free to
add:

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

Regards,
Mike

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
