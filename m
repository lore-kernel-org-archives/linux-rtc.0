Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB2PE2XBQKGQEHZCVU2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f193si274964wmg.2.2017.01.10.15.46.49
        for <rtc-linux@googlegroups.com>;
        Tue, 10 Jan 2017 15:46:49 -0800 (PST)
Date: Wed, 11 Jan 2017 00:46:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [rtc-linux] Re: [PATCH 1/3 v4] rtc: imxdi: use the security violation interrupt
Message-ID: <20170110234638.nm2xveibo4bpyiup@piout.net>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
 <1483469390-7500-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1483469390-7500-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/01/2017 at 19:49:50 +0100, Martin Kaiser wrote :
> The DryIce chipset has a dedicated security violation interrupt that is
> triggered for security violations (if configured to do so).  According
> to the publicly available imx258 reference manual, irq 56 is used for
> this interrupt.
> 
> If an irq number is provided for the security violation interrupt,
> install the same handler that we're already using for the "normal"
> interrupt.
> 
> imxdi->irq is used only in the probe function, make it a local variable.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v4:
>   - separate patches for imx25.dtsi and documentation of the new dt binding
> 
> v3:
>   - add the device tree changes to this patch series
>   - install the same interrupt handler for normal and sec irq, rename
>     the handler function accordingly
>   - make imxdi->irq and imxdi->sec_irq local variables in the probe
>     function
> 
> v2:
>   - make sec_irq optional to avoid breaking the Device Tree ABI
>   - removed the Device Tree bindings, I'll prepare a separate patch for them
> 
> 
>  drivers/rtc/rtc-imxdi.c |   28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
Applied after fixing the multiline comment, thanks.

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
