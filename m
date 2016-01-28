Return-Path: <rtc-linux+bncBD2OLRXW4ABBBWOYU62QKGQE7QPAPNY@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si1404107pac.1.2016.01.28.02.24.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 02:24:25 -0800 (PST)
Message-ID: <56A9E9C3.4040809@nvidia.com>
Date: Thu, 28 Jan 2016 15:43:23 +0530
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
	<k.kozlowski@samsung.com>, <vreddytalla@nvidia.com>, Chaitanya Bandi
	<bandik@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V4 3/5] pinctrl: max77620: add pincontrol
 driver for MAX77620/MAX20024
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>	<1453198783-28383-4-git-send-email-ldewangan@nvidia.com> <CACRpkdZEYw2aADQDNSi0kKns17nKZQZKY+harLhc0j3pA-5FuA@mail.gmail.com>
In-Reply-To: <CACRpkdZEYw2aADQDNSi0kKns17nKZQZKY+harLhc0j3pA-5FuA@mail.gmail.com>
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


On Thursday 28 January 2016 03:34 PM, Linus Walleij wrote:
> On Tue, Jan 19, 2016 at 11:19 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>> MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO pins
>> which also act as the special function in alternate mode. Also
>> there is configuration like push-pull, open drain, FPS timing
>> etc for these pins.
>>
>> Add pincontrol driver to configure these parameters through
>> pincontrol APIs.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> Nice. This driver looks like a lot of hard work, but I think
> it's worth it.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you very much for acknowledgement.

> I guess Lee will be merging this into the MTD tree.
>
> (I still had those comments on the DT bindings but this driver
> part looks fine.)
>
>
I have posted patch V5 for enhancing DT binding doc as suggested by you 
and Lee. Request you to help on review.

I am going to send V6 to separate out DT binding doc patch with the 
driver file which I did in V5 and so want to correct if there is any 
more pending on document enhancement.


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
