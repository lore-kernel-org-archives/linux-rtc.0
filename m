Return-Path: <rtc-linux+bncBD2OLRXW4ABBB6X73C2AKGQEB4JSDLA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id jj4si88166pac.2.2016.01.13.04.15.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 04:15:54 -0800 (PST)
Message-ID: <56963D8D.9060908@nvidia.com>
Date: Wed, 13 Jan 2016 17:35:33 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 6/6] regulator: max77620: add regulator
 driver for max77620/max20024
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-7-git-send-email-ldewangan@nvidia.com> <5695A854.60108@samsung.com> <5696378B.6070704@nvidia.com> <20160113115736.GJ6588@sirena.org.uk>
In-Reply-To: <20160113115736.GJ6588@sirena.org.uk>
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


On Wednesday 13 January 2016 05:27 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Wed, Jan 13, 2016 at 05:09:55PM +0530, Laxman Dewangan wrote:
>
>> Yaah, this is something new and I think Mark also wanted to do this cleanup
>> on his comment. I did not understand it previously. Looks cool now.
> I did, please don't just ignore review comments.
Sure, I respect all comments and thanks for review.
Seems your mail got lost somewhere (still not seeing in my inbox).

>
>> However, I have requirement to configure PMIC with some inital setting based
>> on init_data (parsed) before regulator registration happened. Once I move to
>> this new mecahinsm, the inti_data parsing and regulator init happen in the
>> same function. So I need to have one callback from regulator_register to
>> driver.
>> Something below. This will do the pre configuration before
>> regulator_register happena dn machine constraint sets.
>> I can not use the init_data->regulator_init() as I need to have the init
>> data passed to the driver.
> Why do you have this requirement?

This is require to
- configure FPS_SRC based on platform data for each rail,
     - If FPS_SRC enabled then enable it always.
     - If FPS_SRC is disabled (NONE) then based on init data constraint,
       set it to desired state.
- Power mode and slew rate init based on default configuration from the 
register if platform does not want to set it.


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
