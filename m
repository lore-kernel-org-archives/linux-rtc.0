Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7UK6XAAKGQEI5FMHBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id g142si675197wmd.2.2016.11.04.19.35.41
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Nov 2016 19:35:41 -0700 (PDT)
Date: Sat, 5 Nov 2016 03:35:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	lokeshvutla@ti.com, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: omap: Fix selecting external osc
Message-ID: <20161105023541.udo27ehloo22mtlq@piout.net>
References: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27/10/2016 at 11:27:25 +0530, Keerthy wrote :
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> RTC can be clocked from an external 32KHz oscillator, or from the
> Peripheral PLL. The RTC has an internal oscillator buffer to support
> direct operation with a crystal.
> 
>             ----------------------------------------
>             |       Device          ---------       |
>             |                       |       |       |
>             |                       | RTCSS |       |
>             |       ---------       |       |       |
>     OSC     |<------| RTC   |       |       |       |
>             |------>| OSC   |---    |       |       |
>             |       --------   |    |       |       |
>             |                   ----|clk    |       |
>             |       --------   |    |       |       |
>             |       | PRCM  |---    |       |       |
>             |       --------        --------        |
>             ----------------------------------------
> 
> The RTC functional clock is sourced by default from the clock derived
> from the Peripheral PLL. In order to select source as external osc clk
> the following changes needs to be done:
> - Enable the RTC OSC (RTC_OSC_REG[4]OSC32K_GZ = 0)
> - Enable the clock mux(RTC_OSC_REG[6]K32CLK_EN = 1)
> - Select the external clock source (RTC_OSC_REG[3]32KCLK_SEL = 1)
> 
> Fixes: 399cf0f63f6f2 ("rtc: omap: Add external clock enabling support")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> 
> Boot tested and checked for rtc ticking on am335x-boneblack, am335x-bone
> am437x-gp-evm, dra7-evm, dra72-evm.
> 
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
Both applied, thanks.

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
