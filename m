Return-Path: <rtc-linux+bncBDS7HNEFSALRBENRXCWQKGQE63MZS4A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si513777wiz.2.2015.07.21.03.01.53
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jul 2015 03:01:53 -0700 (PDT)
Date: Tue, 21 Jul 2015 12:01:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V2 3/3] rtc: da9063: Add DA9062 RTC capability
 to DA9063 RTC driver
Message-ID: <20150721100151.GC2853@piout.net>
References: <cover.1437471790.git.stwiss.opensource@diasemi.com>
 <93f0906ed7db18b893385b60a43b02f248dfe9a6.1437471790.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <93f0906ed7db18b893385b60a43b02f248dfe9a6.1437471790.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Steve,

it looks mostly good, a few more comments:

On 21/07/2015 at 10:43:10 +0100, S Twiss wrote :
> -	if (val & (DA9063_E_ALARM))
> +	if (val & (config->rtc_event_alarm_mask))
unneeded parenthesis here

> +	if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
> +		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +		if (chip->variant_code == PMIC_DA9063_AD)
> +			rtc->config = &da9063_ad_regs;
> +	} else
> +		rtc->config = match->data;

Both arms of the if should use braces.

Also, what happens if it is a da9063, BB variant? I guess rtc->config
will not be set.

maybe you should write:

rtc->config = match->data;
if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
     struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);

     if (chip->variant_code == PMIC_DA9063_AD)
         rtc->config = &da9063_ad_regs;
}


> @@ -348,5 +515,5 @@ module_platform_driver(da9063_rtc_driver);
>  
>  MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
>  MODULE_DESCRIPTION("Real time clock device driver for Dialog DA9063");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

This should be part of the license change.

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
