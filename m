Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33285 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdITUwX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Sep 2017 16:52:23 -0400
Date: Wed, 20 Sep 2017 15:52:20 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: RTC: merge ds1339 in ds1307 documentation
Message-ID: <20170920205220.ykkxsqrxu5t47px5@rob-hp-laptop>
References: <20170915014551.22664-1-alexandre.belloni@free-electrons.com>
 <20170915014551.22664-2-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915014551.22664-2-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Sep 15, 2017 at 03:45:51AM +0200, Alexandre Belloni wrote:
> Now that there is documentation for the ds1307 and compatible RTCs, merge
> the ds1339 documentation in it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/dallas,ds1339.txt          | 18 ------------------
>  Documentation/devicetree/bindings/rtc/rtc-ds1307.txt   |  6 ++++++
>  2 files changed, 6 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
> deleted file mode 100644
> index 916f57601a8f..000000000000
> --- a/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Dallas DS1339		I2C Serial Real-Time Clock
> -
> -Required properties:
> -- compatible: Should contain "dallas,ds1339".
> -- reg: I2C address for chip
> -
> -Optional properties:
> -- trickle-resistor-ohms : Selected resistor for trickle charger
> -	Values usable for ds1339 are 250, 2000, 4000
> -	Should be given if trickle charger should be enabled
> -- trickle-diode-disable : Do not use internal trickle charger diode
> -	Should be given if internal trickle charger diode should be disabled
> -Example:
> -	ds1339: rtc@68 {
> -		compatible = "dallas,ds1339";
> -		trickle-resistor-ohms = <250>;
> -		reg = <0x68>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> index d1a820e25cb9..2eacc17a9b8d 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> @@ -26,6 +26,11 @@ Optional properties:
>  - clock-output-names: From common clock binding to override the default output
>                        clock name
>  - wakeup-source: Enables wake up of host system on alarm
> +- trickle-resistor-ohms : Selected resistor for trickle charger
> +	Values usable for ds1339 are 250, 2000, 4000
> +	Should be given if trickle charger should be enabled
> +- trickle-diode-disable : Do not use internal trickle charger diode
> +	Should be given if internal trickle charger diode should be disabled

Do these apply to all compatibles or just 1339?

Rob
