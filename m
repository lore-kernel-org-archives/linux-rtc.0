Return-Path: <rtc-linux+bncBD2OLRXW4ABBBXVIXW2AKGQEVWMELXI@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id a76si164322pfj.2.2016.01.07.22.17.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2016 22:17:02 -0800 (PST)
Message-ID: <568F51FF.7000102@nvidia.com>
Date: Fri, 8 Jan 2016 11:36:55 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<swarren@nvidia.com>, <treding@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 1/6] DT: mfd: add device-tree binding doc fro
 PMIC max77620/max20024
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com> <1452177524-23192-2-git-send-email-ldewangan@nvidia.com> <20160107231249.GA17514@rob-hp-laptop>
In-Reply-To: <20160107231249.GA17514@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Thanks Rob for review.
I have taken care of all comment except following which I have query.

On Friday 08 January 2016 04:42 AM, Rob Herring wrote:
> +	- maxim,low-battery-reset-enable: Enable low battery reset.
> +	- maxim,low-battery-reset-disable: Disable low battery reset.
> Why not boolean? Not present means keep default value? I'd prefer
> boolean or tristate of not present, 0 to disable, or 1 to enable.
>
>
Here, the properties are boolean. I will add this on the description.

I like to enable or disable with the DT and properties are not there 
then left to default.
So added two properties for enable and disable. If properties are there, 
do the activity.

Here tristate is also possible:
maxim,low-battery-reset: tristate, low battery reset control. 0 for 
disable, 1 for enable and
                                  absence of this will leave 
configuration on default.

Does it look fine?

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
