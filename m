Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBJ7YSTBAKGQENKWTJWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id s128si316628wme.1.2016.12.05.02.06.31
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Dec 2016 02:06:31 -0800 (PST)
Date: Mon, 5 Dec 2016 11:06:30 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
	linux@armlinux.org.uk, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, gabriel.fernandez@st.com
Subject: [rtc-linux] Re: [PATCH 2/8] dt-bindings: document the STM32 RTC bindings
Message-ID: <20161205100630.n3gldznf524pucjm@piout.net>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1480687801-19525-4-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 02/12/2016 at 15:09:55 +0100, Amelie Delaunay wrote :
> This patch adds documentation of device tree bindings for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> new file mode 100644
> index 0000000..4578838
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> @@ -0,0 +1,31 @@
> +STM32 Real Time Clock
> +
> +Required properties:
> +- compatible: "st,stm32-rtc".
> +- reg: address range of rtc register set.
> +- clocks: reference to the clock entry ck_rtc.
> +- clock-names: name of the clock used. Should be "ck_rtc".

Is this name really useful?

> +- interrupt-parent: phandle for the interrupt controller.
> +- interrupts: rtc alarm interrupt.
> +- interrupt-names: rtc alarm interrupt name, should be "alarm".

Same comment, is this name really useful?


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
