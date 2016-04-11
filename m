Return-Path: <rtc-linux+bncBDJIP47K7MERBZW2V24AKGQEQGOU4XY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id ph3si1403624pac.1.2016.04.11.06.57.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 06:57:58 -0700 (PDT)
Date: Mon, 11 Apr 2016 08:57:53 -0500
From: Rob Herring <robh@kernel.org>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160411135753.GA29858@rob-hp-laptop>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Apr 06, 2016 at 06:32:47PM +0200, Marcin Niestroj wrote:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup (and set it's polarity), depending on
> board configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup
> in SLEEP mode (RTC-only) to notify about power-button presses. Handling
> power-button presses enables to recover from RTC-only power states
> correctly.
> 
> Implementation uses gpiochip to utilize standard bindings. However,
> configuration is possible only using device-tree (no runtime changes).
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---

Why are you doing a cover letter for a single patch. Put any commentary 
and version history here instead.

>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  18 ++-
>  drivers/rtc/Kconfig                                |   2 +-
>  drivers/rtc/rtc-omap.c                             | 137 ++++++++++++++++++++-
>  3 files changed, 154 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index bf7d11a..4a7738e 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -18,8 +18,12 @@ Optional properties:
>    through pmic_power_en
>  - clocks: Any internal or external clocks feeding in to rtc
>  - clock-names: Corresponding names of the clocks
> +- gpio-controller: Mark as gpio controller when using ext_wakeup
> +- #gpio-cells: Should be set to 2
> +- ngpios: Number of ext_wakeup sources supported by processor (board)

This is not how this property is intended to be used.

> +- ext-wakeup-gpios: List of ext_wakeup sources to configure

This doesn't belong here. It should be in the PMIC node if that is where 
it is attached.

Rob

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
