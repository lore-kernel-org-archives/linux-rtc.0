Return-Path: <rtc-linux+bncBDAMN6NI5EERB2WEZCVAKGQEDE6EORY@googlegroups.com>
Received: from Galois.linutronix.de (Galois.linutronix.de. [2001:470:1f0b:db:abcd:42:0:1])
        by gmr-mx.google.com with ESMTPS id p9si117214wiz.3.2015.05.12.08.55.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 08:55:22 -0700 (PDT)
Date: Tue, 12 May 2015 17:55:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lee Jones <lee.jones@linaro.org>
cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
    devicetree@vger.kernel.org, daniel.lezcano@linaro.org, wim@iguana.be,
    a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
    rtc-linux@googlegroups.com, linux@roeck-us.net, kernel@stlinux.com
Subject: [rtc-linux] Re: [PATCH v2 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
In-Reply-To: <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
Message-ID: <alpine.DEB.2.11.1505121751560.4225@nanos>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org> <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 12 May 2015, Lee Jones wrote:
> +static void st_clksrc_reset(void)

__init

> +static int st_clksrc_setup_clk(struct device_node *np)

__init

> +static void __init st_clksrc_of_register(struct device_node *np)
> +{
> +	int ret;
> +	uint32_t mode;
> +
> +	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> +	if (ret) {
> +		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
> +		return;
> +	}
> +
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> +	if (mode != ST_LPC_MODE_CLKSRC)
> +		return;
> +
> +	ddata.base = of_iomap(np, 0);
> +	if (!ddata.base) {
> +		pr_err("clksrc-st-lpc: Unable to map iomem\n");
> +		return;
> +	}
> +
> +	if (st_clksrc_setup_clk(np)) {
> +		iounmap(ddata.base);
> +		return;
> +	}
> +
> +	if (st_clksrc_init()) {

Keeps the clock enabled.

> +		iounmap(ddata.base);
> +		return;

Thanks,

	tglx
