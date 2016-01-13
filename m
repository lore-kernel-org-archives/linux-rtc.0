Return-Path: <rtc-linux+bncBD2OLRXW4ABBBX47262AKGQEZFNFQ2I@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id dz2si7650732pab.1.2016.01.12.20.17.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 20:17:35 -0800 (PST)
Message-ID: <5695CD73.5010709@nvidia.com>
Date: Wed, 13 Jan 2016 09:37:15 +0530
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
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 5/6] rtc: max77xxx: add RTC driver for
 Maxim MAX77xxx series RTC IP
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-6-git-send-email-ldewangan@nvidia.com> <569594F0.4020007@samsung.com>
In-Reply-To: <569594F0.4020007@samsung.com>
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


On Wednesday 13 January 2016 05:36 AM, Krzysztof Kozlowski wrote:
> On 12.01.2016 18:17, Laxman Dewangan wrote:
>> Maxim Semiconductor's PMIC MAX77620, MAX77686, MAX20024 have
>> same RTC IP on these PMICs.
>>
>> Add generic MAX77xxxx series RTC driver which can be used as
>> RTC driver for these PMIC and avoids duplication of RTC driver
>> for each PMICs. Their MFD driver can be different here.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>> Changes from V1:
>> - Rename the file to rtc-max77xxx.c and make the generic implementation.
>> - Direct regmap apis are used for the register access.
>> - Decouped from max77620 driver.
>> - Taken care of cleanup comments form V1 version.
>>
>>   drivers/rtc/Kconfig        |  10 +
>>   drivers/rtc/Makefile       |   1 +
>>   drivers/rtc/rtc-max77xxx.c | 500 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 511 insertions(+)
>>   create mode 100644 drivers/rtc/rtc-max77xxx.c
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 376322f..4972dd5 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -315,6 +315,16 @@ config RTC_DRV_MAX8997
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called rtc-max8997.
>>   
>> +config RTC_DRV_MAX77XXX
>> +	tristate "Maxim MAX77XXX series generic RTC driver"
>> +	help
>> +	  If you say yes here you will get support for the generic RTC driver
>> +	  for Maxim Semiconductor MAX77XXX series of PMIC like MAX77620.
>> +	  This also supports the RTC driver for Maxim PMIC MaX20024 which
>> +	  is almost same as MAX77620.
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called rtc-max77xxx.
>> +
> That was not the consensus... You still added a new driver - but now
> with different name.
>
> That is useless duplication
>
> Please work with existing code. Use existing maxim RTC drivers: either
> max77686 or max77802.
>
> There is no need for new one.

If we modify the existing one then that work will be outside of this 
series to make it independent.

However, the file name does not suggest common in older file. Also this 
will require mfd and rtc driver changes to decouple it.

Here is my approach:
- Let's have common driver in implementation and file name. This will be 
independent of the mfd driver on all sense.
- Once it is merged, move the max77686 and max77802 to use this driver, 
this will need the modification on the mfd driver, related defconfig 
file and if specific stuff needed in the rtc then addition of that.

Per your approach:
- Modify rtc max77686 and mfd driver max77686 to decouple and proper 
registration.
- Add support of max77620 on the max77686 driver if any specific is 
required.

That is also fine to me but still I am not comfortable with the config 
name and driver file name as this does not suggest the common.




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
