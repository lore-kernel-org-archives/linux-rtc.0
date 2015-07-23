Return-Path: <rtc-linux+bncBDRMFBMIXEGBBZVMYOWQKGQESVA6LSY@googlegroups.com>
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id b64si243042ywc.0.2015.07.23.04.56.22
        for <rtc-linux@googlegroups.com>;
        Thu, 23 Jul 2015 04:56:22 -0700 (PDT)
Date: Thu, 23 Jul 2015 12:55:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Suneel Garapati <suneel.garapati@xilinx.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"michals@xilinx.com" <michals@xilinx.com>,
	"sorenb@xilinx.com" <sorenb@xilinx.com>
Subject: [rtc-linux] Re: [PATCH 1/2] devicetree: bindings: rtc: add bindings
 for xilinx zynqmp rtc
Message-ID: <20150723115555.GC12330@leverpostej>
References: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jul 23, 2015 at 11:51:49AM +0100, Suneel Garapati wrote:
> adds file for description on device node bindings for RTC
> found on Xilinx Zynq Ultrascale+ MPSoC.
> 
> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> ---
>  Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> new file mode 100644
> index 0000000..2b05243
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> @@ -0,0 +1,25 @@
> +* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
> +
> +RTC controller for the Xilinx Zynq MPSoC Real Time Clock
> +Separate IRQ lines for seconds and alarm
> +
> +Required properties:
> +- compatible: Should be "xlnx,zynqmp-rtc"
> +- reg: Physical base address of the controller and length
> +       of memory mapped region.
> +- interrupts: IRQ lines for the RTC.
> +- interrupt names: Names for interrupt lines

interrupt-names has a '-', and you need to state which names are
expected.

> +
> +Optional:
> +- calibration: calibration value for 1 sec period which will
> +		be programmed directly to calibration register

When and why would I set this?

Mark.

> +
> +Example:
> +rtc: rtc@ffa60000 {
> +	compatible = "xlnx,zynqmp-rtc";
> +	reg = <0x0 0xffa60000 0x100>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 26 4>, <0 27 4>;
> +	interrupt-names = "alm", "sec";
> +	calibration = <0x198233>;
> +};
> --
> 2.1.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

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
