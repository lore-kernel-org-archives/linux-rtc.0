Return-Path: <rtc-linux+bncBDJIP47K7MERBNPMU25QKGQE366VUFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com. [209.85.218.66])
        by gmr-mx.google.com with ESMTPS id f63si294042ith.2.2016.06.21.14.48.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 14:48:37 -0700 (PDT)
Received: by mail-oi0-f66.google.com with SMTP id s17so889669oih.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 14:48:37 -0700 (PDT)
Date: Tue, 21 Jun 2016 16:48:36 -0500
From: Rob Herring <robh@kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
Message-ID: <20160621214836.GA10197@rob-hp-laptop>
References: <1466492240-5528-1-git-send-email-dirk.behme@de.bosch.com>
 <1466492240-5528-2-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466492240-5528-2-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 21, 2016 at 08:57:18AM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> 
> ... and Epson RX8900 real time clock
> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/rtc/epson,rx8900.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.txt b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> new file mode 100644
> index 0000000..51959de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> @@ -0,0 +1,21 @@
> +Real Time Clock driver for:
> +  - Epson RX8900
> +  - Micro Crystal rv8803
> +
> +Required properties:
> +- compatible: should be: "mc,rv8803" or "epson,rx8900"
> +- reg : the I2C address of the device for I2C
> +
> +Optional properties:
> +- epson,vdetoff : Disable Voltage Detector. Should be set if no
> +  backup battery is used.

set to no? Looks like a boolean to me.

How about epson,vdet-disable to be consistent.

> +- trickle-diode-disable : Disable internal trickle charger diode

boolean?

Needs a vendor prefix.

> +
> +Example:
> +
> +	rtc: rtc@32 {
> +		compatible = "epson,rx8900"
> +		reg = <0x32>;
> +		epson,vdetoff;
> +		trickle-diode-disable;
> +	};
> -- 
> 2.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
