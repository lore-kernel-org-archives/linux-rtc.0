Return-Path: <rtc-linux+bncBDJIP47K7MERBHXW2LCQKGQELBJI7ZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com. [74.125.82.196])
        by gmr-mx.google.com with ESMTPS id a17si1583119itd.1.2017.02.27.15.49.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 15:49:50 -0800 (PST)
Received: by mail-ot0-f196.google.com with SMTP id k4so10034116otc.0
        for <rtc-linux@googlegroups.com>; Mon, 27 Feb 2017 15:49:50 -0800 (PST)
Date: Mon, 27 Feb 2017 17:49:49 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv3 2/2] rtc: cpcap: new rtc driver
Message-ID: <20170227234949.ylaf2n3jrwtzoemy@rob-hp-laptop>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170223010353.24351-1-sre@kernel.org>
 <20170223010353.24351-2-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170223010353.24351-2-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Feb 23, 2017 at 02:03:53AM +0100, Sebastian Reichel wrote:
> This driver supports the Motorola CPCAP PMIC found on
> some of Motorola's mobile phones, such as the Droid 4.
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> 
> Changes since PATCHv2:
>  - checkpatch fixes
>  - add comment for update irq
>  - introduced vendor prefix patch
> Changes since PATCHv1:
>  - added device_init_wakeup() at the end of probe
>  - added Tested-by from Tony
> 
> ---
>  .../devicetree/bindings/rtc/cpcap-rtc.txt          |  13 +
>  drivers/rtc/Kconfig                                |   7 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-cpcap.c                            | 332 +++++++++++++++++++++
>  4 files changed, 353 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
>  create mode 100644 drivers/rtc/rtc-cpcap.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt b/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
> new file mode 100644
> index 000000000000..2709c32baf2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
> @@ -0,0 +1,13 @@
> +Motorola CPCAP PMIC RTC
> +------------------------------------

Need to state what this is a child of.

> +
> +Requires node properties:
> +- compatible: should contain "motorola,cpcap-rtc"
> +- interrupts: An interrupt specifier for alarm and 1 Hz irq
> +
> +Example:
> +
> +cpcap_rtc: rtc {
> +	compatible = "motorola,cpcap-rtc";
> +	interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
> +};

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
