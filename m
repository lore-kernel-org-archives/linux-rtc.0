Return-Path: <rtc-linux+bncBDJIP47K7MERBBW6THCAKGQEV2BMLTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com. [74.125.82.195])
        by gmr-mx.google.com with ESMTPS id d20si1204455itc.1.2017.01.23.13.00.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2017 13:00:54 -0800 (PST)
Received: by mail-ot0-f195.google.com with SMTP id 36so16959592otx.3
        for <rtc-linux@googlegroups.com>; Mon, 23 Jan 2017 13:00:54 -0800 (PST)
Date: Mon, 23 Jan 2017 15:00:52 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 4/7] rtc: sun6i: Expose the 32kHz oscillator
Message-ID: <20170123210052.rek7fma5gjukq2ld@rob-hp-laptop>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
 <f244737aa43965e5510e8173b5653deb484a94f0.1485168100.git-series.maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f244737aa43965e5510e8173b5653deb484a94f0.1485168100.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jan 23, 2017 at 11:41:49AM +0100, Maxime Ripard wrote:
> The RTC controls the input source of the main 32kHz oscillator in the
> system, feeding it to the clock unit too.
> 
> By default, this is using an internal, very inaccurate (+/- 30%)
> oscillator with a divider to make it roughly around 32kHz. This is however
> quite impractical for the RTC, since our time will not be tracked properly.
> 
> Since this oscillator is an input of the main clock unit, and since that
> clock unit will be probed using CLK_OF_DECLARE, we have to use it as well,
> leading to a two stage probe: one to enable the clock, the other one to
> enable the RTC.
> 
> There is also a slight change in the binding that is required (and should
> have been from the beginning), since we'll need a phandle to the external
> oscillator used on that board. We support the old binding by not allowing
> to switch to the external oscillator and only using the internal one (which
> was the previous behaviour) in the case where we're missing that phandle.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |  10 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/rtc-sun6i.c                             | 146 +++++++++++--
>  2 files changed, 143 insertions(+), 13 deletions(-)

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
