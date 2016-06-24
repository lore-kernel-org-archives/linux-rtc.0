Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYWLWO5QKGQEFBS2UEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a186si75323wma.1.2016.06.24.00.48.49
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Jun 2016 00:48:49 -0700 (PDT)
Date: Fri, 24 Jun 2016 09:48:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dirk Behme <dirk.behme@de.bosch.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: Re: [rtc-linux] [PATCH v2 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
Message-ID: <20160624074849.GK5809@piout.net>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
 <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/06/2016 at 08:42:20 +0200, Dirk Behme wrote :
> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> 
> ... and Epson RX8900 real time clock
> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.txt b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> new file mode 100644
> index 0000000..3f61e51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> @@ -0,0 +1,22 @@
> +Real Time Clock driver for:
> +  - Epson RX8900
> +  - Micro Crystal rv8803
> +
> +Required properties:
> +- compatible: should be: "microcrystal,rv8803" or "epson,rx8900"
> +- reg : the I2C address of the device for I2C
> +
> +Optional properties:
> +- epson,vdet-disable : boolean, if present will disable voltage detector.
> +  Should be set if no backup battery is used.

I guess we need to make that one generic. I would use
voltage-detection-disable.

Andrey, can you use that one instead of
dallas,disable-oscillator-stop-flag ?

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
