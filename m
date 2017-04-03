Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZHERHDQKGQERATR66I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id k74si1340957wmd.1.2017.04.03.09.03.48
        for <rtc-linux@googlegroups.com>;
        Mon, 03 Apr 2017 09:03:48 -0700 (PDT)
Date: Mon, 3 Apr 2017 18:03:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 0/7] rtc: Reuse rtc-sh driver to support RZ/A1
Message-ID: <20170403160337.g3fzjbfhllnaoafz@piout.net>
References: <20170329173035.67477-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170329173035.67477-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 29/03/2017 at 10:30:28 -0700, Chris Brandt wrote:
> Basically, the same RTC that was used in SuperH devices is now used in
> RZ/A1 devices. Therefore with some slight changes, that driver can be
> reused.
> 
> Additionally, since ARM architectures require Device Tree configurations,
> device tree support has been added.
> 
> This was tested on RZ/A1H RSK board. Once the correct time was programmed
> into the RTC running off a 32.768kHz crystal, you can retain an accurate
> system clock between reboots (hard and soft) until power is finally removed
> from the board (there is no batter backup on the RSK board).
> 
> v3:
> * remove 'power-domains' from example in documentation
> * update commit message subject and body of dt-bindings
> 
> v2:
> * removed HAVE_CLK from Kconfig
> * when using DT, look for "fck" instead of "rtc0"
> * changed (res == NULL) to (!res)
> * added Reviewed-by for rtc-sh.c
> * added interrupt-names and clock-names
> * clocks now include counting sources
> * added clock-names "fck", "rtc_x1", "rtc_x3", "extal"
> * changed 'is a RTC' to 'is an RTC' in commit message
> * changed "rtc0" to "rtc"
> * Added clock nodes for RTC_X1 and RTC_X3 pin inputs
> * each commit now has a log message
> 
> 
> Chris Brandt (7):
>   rtc: rtc-sh: add support for rza series
>   dt-bindings: rtc: document the rtc-sh bindings

I applied those two, I'll let Simon take the device tree patches.

Thanks!

>   ARM: dts: r7s72100: add rtc clock to device tree
>   ARM: dts: r7s72100: add RTC_X clock inputs to device tree
>   ARM: dts: r7s72100: add rtc to device tree
>   ARM: dts: rskrza1: set rtc_x1 clock value
>   ARM: dts: rskrza1: add rtc DT support

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
