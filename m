Return-Path: <rtc-linux+bncBD2OLRXW4ABBB6PIT63AKGQEXUQRGLY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id ui7si2071117pab.0.2016.02.19.21.07.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 21:07:05 -0800 (PST)
Message-ID: <56C7F1A3.70404@nvidia.com>
Date: Sat, 20 Feb 2016 10:24:59 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?UGF3ZcWCIE1vbGw=?=
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Lee Jones
	<lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alessandro Zummo
	<a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Stephen Warren
	<swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
	=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dzaw==?= =?UTF-8?B?aQ==?=
	<k.kozlowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH V8 6/8] gpio: max77620: add gpio driver for MAX77620/MAX20024
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>	<1455191794-6065-7-git-send-email-ldewangan@nvidia.com> <CACRpkdbA+pHHpjT-HMr8FS8DehRZE=G2m5s6=MRoqR4n_RrHEQ@mail.gmail.com>
In-Reply-To: <CACRpkdbA+pHHpjT-HMr8FS8DehRZE=G2m5s6=MRoqR4n_RrHEQ@mail.gmail.com>
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


On Tuesday 16 February 2016 04:48 AM, Linus Walleij wrote:
> On Thu, Feb 11, 2016 at 12:56 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>> MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO
>> pins. It also supports interrupts from these pins.
>>
>> Add GPIO driver for these pins to control via GPIO APIs.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> (...)
> Nit and no big deal:
>
>> +#include <linux/gpio.h>
> <linux/gpio/driver.h>
>
> should be enough.

Yaah, this is better.

Lee,
Should I respin the patch series for this change?




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
