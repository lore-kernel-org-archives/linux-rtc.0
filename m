Return-Path: <rtc-linux+bncBD2OLRXW4ABBBT6L2W3AKGQE4CVA4GQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si4240593pab.0.2016.03.01.01.50.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 01:50:07 -0800 (PST)
Message-ID: <56D562DB.6020008@nvidia.com>
Date: Tue, 1 Mar 2016 15:07:31 +0530
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
Subject: [rtc-linux] Re: [PATCH V8 3/8] pinctrl: add DT binding doc for
 pincontrol of PMIC max77620/max20024
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>	<1455191794-6065-4-git-send-email-ldewangan@nvidia.com> <CACRpkdZGNRJK4okMFdVS0JFyWC+Rnwpi8ms06oXrbtAe1MjR=g@mail.gmail.com>
In-Reply-To: <CACRpkdZGNRJK4okMFdVS0JFyWC+Rnwpi8ms06oXrbtAe1MjR=g@mail.gmail.com>
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

Hi Linus,

On Tuesday 16 February 2016 04:46 AM, Linus Walleij wrote:
> On Thu, Feb 11, 2016 at 12:56 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>> Maxim Semiconductor's PMIC MAX77620/MAX20024 has 8 GPIO pins
>> which act as GPIO as well as special function mode.
>>
>> Add DT binding document to configure pins in function mode as
>> well as pin configuration parameters.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
>
I saw that regulator driver is merged in regulator subsystem by Mark 
Brown. So I think  patches can go on their individual subsystem. The 
config for these driver depends on the MFD and hence it will not build.

Also the common header file is part of mfd subsystem and other patches 
will not touch this so no conflict on the drivers.

Same for max77620 GPIO patch also.

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
