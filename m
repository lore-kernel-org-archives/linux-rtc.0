Return-Path: <rtc-linux+bncBDS7HNEFSALRBO6QROYQKGQERMJGO5I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hs5si308417wib.1.2015.10.17.17.30.51
        for <rtc-linux@googlegroups.com>;
        Sat, 17 Oct 2015 17:30:51 -0700 (PDT)
Date: Sun, 18 Oct 2015 02:30:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4] rtc: pcf8563: add CLKOUT to common clock framework
Message-ID: <20151018003050.GZ3421@piout.net>
References: <1444995089-14493-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444995089-14493-1-git-send-email-hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 16/10/2015 at 13:31:29 +0200, Heiko Schocher wrote :
> Add the clkout output clk to the common clock framework.
> Disable the CLKOUT of the RTC after power-up.
> After power-up/reset of the RTC, CLKOUT is enabled by default,
> with CLKOUT enabled the RTC chip has 2-3 times higher power
> consumption.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
> Changes in v4:
> - add comments from Alexandre Belloni
>   - use devm_clk_register() instead of clk_register()
>   - rework Documentation
> 
> Changes in v3:
> - use CONFIG_COMMON_CLK for common clk framework
>   changes
> 
> Changes in v2:
> - add comments from Alexandre Belloni
>   - remove the DT property, instead
>     register for the CLKOUT a clk in the common
>     clk framework. The clk is disabled by default.
> 
>  Documentation/devicetree/bindings/rtc/pcf8563.txt |  25 ++++
>  drivers/rtc/rtc-pcf8563.c                         | 170 +++++++++++++++++++++-
>  2 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt
> 
Applied, thanks.

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
