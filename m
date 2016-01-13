Return-Path: <rtc-linux+bncBDJIP47K7MERBBXD222AKGQEVUGHGII@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id dz2si7608734pab.1.2016.01.12.18.08.06
        for <rtc-linux@googlegroups.com>;
        Tue, 12 Jan 2016 18:08:06 -0800 (PST)
Date: Tue, 12 Jan 2016 20:07:59 -0600
From: Rob Herring <robh@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com, k.kozlowski@samsung.com
Subject: [rtc-linux] Re: [PATCH V2 1/6] DT: mfd: add device-tree binding doc
 fro PMIC max77620/max20024
Message-ID: <20160113020759.GA16193@rob-hp-laptop>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1452590273-16421-2-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 12, 2016 at 02:47:48PM +0530, Laxman Dewangan wrote:
> The MAXIM PMIC MAX77620 and MAX20024 are power management IC
> which supports RTC, GPIO, DCDC/LDO regulators, interrupt,
> watchdog etc.
> 
> Add DT binding document for the different functionality of
> this device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Added units in some of properties.
> - Change the boolean property to tristate type and detail some of
>   properties.

[...]

> +Flexible power sequence configuration
> +====================================
> +This sub-node configures the Flexible Power Sequnece(FPS) for power ON slot,
> +power OFF slot and slot period of the device. Device has 3 FPS as FPS0,
> +FPS1 and FPS2. The details of FPS configuration is provided through
> +subnode "fps". The details of FPS0, FPS1, FPS2 are provided through the
> +child node under this subnodes. The FPS number is provided via reg property.
> +
> +The property for fps child nodes as:
> +Required properties:
> +	-reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.
> +Optinal properties:
> +	-maxim,active-fps-time-period: Active state FPS time period in
> +		microseconds.
> +	-maxim,suspend-fps-time-period: Suspend state FPS time period in
> +		microseconds.

These property names need units, too. IOW, append with '-us', so 
something like "maxim,suspend-fps-time-us".

Otherwise, looks fine to me.

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
