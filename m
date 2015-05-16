Return-Path: <rtc-linux+bncBDS7HNEFSALRBCUY3WVAKGQEZIWOI3Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si87558wif.0.2015.05.16.06.54.18
        for <rtc-linux@googlegroups.com>;
        Sat, 16 May 2015 06:54:18 -0700 (PDT)
Date: Sat, 16 May 2015 15:54:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com,
	robh+dt@kernel.org, a.zummo@towertech.it, sachin.kamat@linaro.org,
	p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/7] arm: imx: power-off: change to syscon to
 access register
Message-ID: <20150516135417.GK3338@piout.net>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
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

On 15/05/2015 at 21:36:24 +0800, Frank.Li@freescale.com wrote :
>  static int imx_poweroff_probe(struct platform_device *pdev)
>  {
> -	snvs_base = of_iomap(pdev->dev.of_node, 0);
> -	if (!snvs_base) {
> +	struct device_node *nd;
> +
> +	nd = of_get_parent(pdev->dev.of_node);
> +	if (!nd)
> +		return -ENODEV;
> +	snvs = syscon_node_to_regmap (nd);
You should remove that space ---^


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
