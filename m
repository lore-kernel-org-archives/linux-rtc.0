Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 10 Sep 2014 14:14:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
Message-ID: <20140910121424.GG2974@localhost>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

On Wed, Sep 03, 2014 at 10:45:34AM +0200, Boris BREZILLON wrote:
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt   | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> new file mode 100644
> index 0000000..9ca455f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> @@ -0,0 +1,20 @@
> +Atmel AT91SAM9260 Real Time Timer
> +
> +Required properties:
> +- compatible: should be: "atmel,at91sam9260-rtt"
> +- reg: should contain 2 memory regions
> +  * the first one encodes the memory region of the RTT controller
> +  * the second one encodes the GPBR (General Purpose Backup Resgisters)
> +    memory region used to store the current time
> +- interrupts: rtc alarm/event interrupt
> +- clocks: should contain one clock pointing the the slow clk
> +
> +Example:
> +
> +rtc@fffffe00 {
> +	compatible = "atmel,at91sam9260-rtt";
> +	reg = <0xfffffd20 0x10
> +	       0xfffffd50 0x4>;
> +	interrupts = <1 4 7>;
> +	clocks = <&clk32k>;
> +};

This does not describe the hardware, but rather a specific software
configuration.

The RTT is first of all not an RTC (although it can be used as one in a
specific software configuration). And the second register resource above
is not an RTT register, but a general-purpose backup register could be
used for other purposes (which register to use is currently configurable
for legacy booting using CONFIG_RTC_DRV_AT91SAM9_GPBR).

This was discussed in the thread where I posted an RFC for this last
year (which you linked to in your original submission thread), but no
conclusion was reached:

	http://www.spinics.net/lists/arm-kernel/msg236292.html

Johan
