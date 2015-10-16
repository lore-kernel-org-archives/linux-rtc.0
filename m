Return-Path: <rtc-linux+bncBDS7HNEFSALRBANPQOYQKGQEU2ADLGY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hs5si98288wib.1.2015.10.16.03.54.57
        for <rtc-linux@googlegroups.com>;
        Fri, 16 Oct 2015 03:54:57 -0700 (PDT)
Date: Fri, 16 Oct 2015 12:54:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf8563: add CLKOUT to common clock framework
Message-ID: <20151016105446.GK3421@piout.net>
References: <1444982369-26046-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444982369-26046-1-git-send-email-hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 16/10/2015 at 09:59:29 +0200, Heiko Schocher wrote :
> Add the clkout output clk to the common clock framework.
> Disable the CLKOUT of the RTC after power-up.
> After power-up/reset of the RTC, CLKOUT is enabled by default,
> with CLKOUT enabled the RTC chip has 2-3 times higher power
> consumption.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
> Changes in v2:
> - add comments from Alexandre Belloni
>   - remove the DT property, instead
>     register for the CLKOUT a clk in the common
>     clk framework. The clk is disabled by default.
> 
>  Documentation/devicetree/bindings/rtc/pcf8563.txt |  28 ++++
>  drivers/rtc/rtc-pcf8563.c                         | 164 +++++++++++++++++++++-
>  2 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
> new file mode 100644
> index 0000000..cdb81ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
> @@ -0,0 +1,28 @@
> +* Philips PCF8563/Epson RTC8564 Real Time Clock
> +
> +Philips PCF8563/Epson RTC8564 Real Time Clock
> +
> +Required properties:
> +see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +
> +Optional property:
> +- #clock-cells: Should be 1.
> +- clocks: Reference to the clock entry.
> +- clock-output-names:
> +  overwrite the default clock name "pcf8563-clkout"
> +
> +Example:
> +
> +rtcclk: rtcclk {
> +	compatible = "fixed-clock";
> +	#clock-cells = <1>;
> +	clock-frequency = <1>;
> +	clock-output-names = "rtcclk";
> +};
> +
> +pcf8563@51 {
> +	compatible = "nxp,pcf8563";
> +	reg = <0x51>;
> +	#clock-cells = <1>;
> +	clocks = <&rtcclk 0>;
> +};

You don't seem to be using rtcclk, I would remove it from the example.

> +static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
> +{
> +	struct i2c_client *client = pcf8563->client;
> +	struct device_node *node = client->dev.of_node;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	int ret;
> +	unsigned char buf;
> +
> +	/* disable the clkout output */
> +	buf = 0;
> +	ret = pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1, &buf);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +

Isn't that done automatically for an unused clock? However, I would do
that in the probe as you will have to sprinkle some #ifdef
CONFIG_COMMON_CLK after seeing the kbuild report.

>  
> +	/* register clk in common clk framework */
> +	pcf8563_clkout_register_clk(pcf8563);
> +
>  	/* the pcf8563 alarm only supports a minute accuracy */
>  	pcf8563->rtc->uie_unsupported = 1;
>  

You probably need to unregister the clock at some point. Maybe using
devm_clk_register() is the best thing to do.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
