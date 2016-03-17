Return-Path: <rtc-linux+bncBDS7HNEFSALRBK6CVK3QKGQEYFSED3I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g81si351021wmi.3.2016.03.17.05.20.59
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 05:20:59 -0700 (PDT)
Date: Thu, 17 Mar 2016 13:20:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Burton <paul.burton@imgtec.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/5] rtc: jz4740_rtc: Add support for acting
 as the system power controller
Message-ID: <20160317122058.GE3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-4-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457217531-26064-4-git-send-email-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/03/2016 at 23:38:50 +0100, Paul Cercueil wrote :
> +	if (of_device_is_system_power_controller(pdev->dev.of_node)) {
> +		if (!pm_power_off) {
> +			/* Default: 60ms */
> +			rtc->reset_pin_assert_time = 60;
> +			device_property_read_u32(&pdev->dev,

It is probably more efficient to use of_property_read_u32 directly. Any
particular reason to use device_property_read_u32?

> +		} else {
> +			dev_err(&pdev->dev,
> +					"Poweroff handler already present!\n");

I'm not found of that alignement, it is probably better to let the
string go over 80 chars. checkpatch will not complain.

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
