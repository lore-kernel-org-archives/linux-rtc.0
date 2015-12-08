Return-Path: <rtc-linux+bncBDUKXHHSSIJBBDXCTKZQKGQESCRHLGQ@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id e201si104228wma.3.2015.12.08.02.29.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 02:29:34 -0800 (PST)
Message-ID: <1449570566.3691.31.camel@pengutronix.de>
Subject: [rtc-linux] Re: [PATCH v3 1/2] Documentation: devicetree: add epson
 rx6110 binding
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Mark Rutland
 <mark.rutland@arm.com>,  devicetree@vger.kernel.org,
 rtc-linux@googlegroups.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>,
 kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
Date: Tue, 08 Dec 2015 11:29:26 +0100
In-Reply-To: <1449568461-26016-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1449568461-26016-1-git-send-email-s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Am Dienstag, den 08.12.2015, 10:54 +0100 schrieb Steffen Trumtrar:
> Add the binding documentation for the Epson RX6110 RTC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

although I'd like a small change to be made below:

> ---
> Changes since v2:
> 	- removed the size field in i2c binding
> 
>  .../devicetree/bindings/rtc/epson,rx6110.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> new file mode 100644
> index 000000000000..71353542a59d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> @@ -0,0 +1,39 @@
> +Epson RX6110 Real Time Clock
> +============================
> +
> +The Epson RX6110 can be used with SPI or I2C busses. The kind of
> +bus depends on the SPISEL pin and can not be configured via software.
> +
> +I2C mode
> +--------
> +
> +Required properties:
> +  - compatible: should be: "epson,rx6110"
> +  - reg : offset of the register set of the device

That should be the I2C address of the device, as in:
	git grep "reg.*I2C address" Documentation/

regards
Philipp

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
