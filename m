Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBRWLXS5QKGQETHDXFOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a186si158849wma.1.2016.06.25.17.45.57
        for <rtc-linux@googlegroups.com>;
        Sat, 25 Jun 2016 17:45:57 -0700 (PDT)
Date: Sun, 26 Jun 2016 02:45:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 5/8] rtc: ac100: Add clk output support
Message-ID: <20160626004557.GX5809@piout.net>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466391138-12862-6-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/06/2016 at 10:52:15 +0800, Chen-Yu Tsai wrote :
> +struct ac100_clk32k {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	u8 offset;
> +};
> +
> +#define to_ac100_clk32k(_hw) container_of(_hw, struct ac100_clk32k, hw)
> +
> +#define AC100_RTC_32K_NAME	"ac100-rtc-32k"
> +#define AC100_RTC_32K_RATE	32768
> +#define AC100_ADDA_4M_NAME	"ac100-adda-4M"
> +#define AC100_ADDA_4M_RATE	4000000
> +#define AC100_CLK32K_NUM	3
> +
> +static const char * const ac100_clk32k_names[] = {
> +	"ac100-clk32k-ap",
> +	"ac100-clk32k-bb",
> +	"ac100-clk32k-md",
> +};
> +

Well, naming things is hard but I don't feel ac100_clk32k and
ac100-clk32k are good prefixes for those clocks as they are actually
dividing a 32KHz or 4MHz clock (one configuration out of 128 is 32KHz).

Else, I don't have any objection.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
