Return-Path: <rtc-linux+bncBD2OLRXW4ABBBC4P3G2AKGQEIDWL5FY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id jj4si99659pac.2.2016.01.13.04.48.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 04:48:11 -0800 (PST)
Message-ID: <5696451F.3000707@nvidia.com>
Date: Wed, 13 Jan 2016 18:07:51 +0530
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
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-7-git-send-email-ldewangan@nvidia.com> <5695A854.60108@samsung.com> <5696378B.6070704@nvidia.com> <20160113115736.GJ6588@sirena.org.uk> <56963D8D.9060908@nvidia.com> <20160113123133.GK6588@sirena.org.uk>
In-Reply-To: <20160113123133.GK6588@sirena.org.uk>
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


On Wednesday 13 January 2016 06:01 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Wed, Jan 13, 2016 at 05:35:33PM +0530, Laxman Dewangan wrote:
>> On Wednesday 13 January 2016 05:27 PM, Mark Brown wrote:
>> This is require to
>> - configure FPS_SRC based on platform data for each rail,
>>      - If FPS_SRC enabled then enable it always.
>>      - If FPS_SRC is disabled (NONE) then based on init data constraint,
>>        set it to desired state.
> What is FPS_SRC and why is it set from init_data?  A driver should never
> be looking at init_data.
FPS: Flexible Power Sequence.
Max77620 has three FPS source configuration FPS0,1 2 and can be 
configured with different digital input signals EN0, EN1 and EN2.
Then rails and few GPIOs can configured with these FPS SRC with 
different slots so that it can be controlled externally.

When FPS_SRC is set to NONE (this is needed from platform data) then 
based on constraint like boot enable/always enable, it need to be on 
desired state. Otherwise we may endup with disabling the rail when 
setting to NONE and create issue.

I need to set the FPS src properly for each rails before callback happen 
from regulator init so that enable/disable/is_enable can handle it properly.


>> - Power mode and slew rate init based on default configuration from the
>> register if platform does not want to set it.
> Same here, why is init_data needed here?
>
Here, init data is not needed. I was thinking to configure slew rate in 
preinit but can be done later also through regulator->ops.
But I will need the driver specific DT data (customized flag) to 
configure the PMIC like slots.



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
