Return-Path: <rtc-linux+bncBD2OLRXW4ABBBXHNU22QKGQEM7YVE3Q@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id r2si1274089pfr.0.2016.01.27.22.36.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2016 22:36:12 -0800 (PST)
Message-ID: <56A9B41C.4070607@nvidia.com>
Date: Thu, 28 Jan 2016 11:54:28 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V5 5/5] regulator: max77620: add regulator
 driver for max77620/max20024
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com> <1453903808-29788-6-git-send-email-ldewangan@nvidia.com> <56A99130.1070904@samsung.com>
In-Reply-To: <56A99130.1070904@samsung.com>
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


On Thursday 28 January 2016 09:25 AM, Krzysztof Kozlowski wrote:
> On 27.01.2016 23:10, Laxman Dewangan wrote:
>> MAXIM Semiconductor's PMIC, MAX77620 and MAX20024 have the
>> multiple DCDC and LDOs. This supplies the power to different
>> components of the system.
>> Also these rails has configuration for ramp time, flexible
>> power sequence, slew rate etc.
>>
>> Add regulator driver to access these rails via regulator APIs.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
>> ---
>> Changes from V1:
>> - Cleanup code based on comment received on mfd/rtc.
>> - Avoid duplication on error message.
>>
>> Changes form V2:
>> - Run coccicheck and checkpatch in strict mode for the alignment.
>> - Refactor Regulator driver to use core API for DT parsing.
>> - Update based on API changes.
>>
>> Changes from V3:
>> - Change all sys initcall to module driver.
>> - change the max77620_read argument to unisgned int from u8.
>>
>> Changes from V4:
>> - Added DT binding document as devicetree/bindings/regulator/regulator-max77620.txt
>> - Detail out properties.
> What does it mean "Detail out properties"? What have changed>

Based on review comment from Linus W, I added more description on the 
properties.

>
>>   .../bindings/regulator/regulator-max77620.txt      | 163 ++++
> Please put the bindings in separate patch. It might be easier for DT
> guys to review them (they are acking the bindings, not the driver). Also
OK, will push it.


> I already reviewed the patchset but because of adding bindings here, you
> could not add my reviewed-by tag (which makes my effort not tracked...).
Yaah, This patch include the dt binding and so wanted your review again. 
This si only reason to not add reviewed-by.

Now I am going to separate out DT binding and driver,  I will add 
reviewed-by tag for you in driver file.

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
