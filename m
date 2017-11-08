Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58351 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdKHDP1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 22:15:27 -0500
Date: Wed, 8 Nov 2017 04:15:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC
 documentation
Message-ID: <20171108031520.zx2ipqugiyypmpms@piout.net>
References: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 07/11/2017 at 19:34:07 +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27xx series
> RTC device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---
>  .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
> new file mode 100644
> index 0000000..971d3a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
> @@ -0,0 +1,16 @@
> +Spreadtrum SC27xx Real Time Clock
> +
> +Required properties:
> +- compatible: should be "sprd,sc27xx-rtc".

Don't use wildcards in a compatible, use a specific chip model. later
chips may or may not be compatible with that one.

> +- reg: address offset of rtc register.
> +- interrupt-parent: phandle for the interrupt controller.
> +- interrupts: rtc alarm interrupt.
> +
> +Example:
> +
> +	rtc: rtc@280 {

The rtc: alias is probably useless

> +		compatible = "sprd,sc27xx-rtc";
> +		reg = <0x280>;
> +		interrupt-parent = <&pmic>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +	};

I would include the parent MFD node too.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
