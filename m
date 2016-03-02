Return-Path: <rtc-linux+bncBD2OLRXW4ABBBIM73G3AKGQEJTPPRDI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id r75si3196890pfr.0.2016.03.01.18.27.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 18:27:45 -0800 (PST)
Message-ID: <56D64CAC.5030704@nvidia.com>
Date: Wed, 2 Mar 2016 07:45:08 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <javier@osg.samsung.com>, <rklein@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com> <56D63A9C.20506@samsung.com>
In-Reply-To: <56D63A9C.20506@samsung.com>
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


On Wednesday 02 March 2016 06:28 AM, Krzysztof Kozlowski wrote:
> On 29.02.2016 21:58, Laxman Dewangan wrote:
> +	.alarm_pending_status_reg = MAX77620_RTC_ALARM_PENDING_STATUS_REG,
> Just skip the alarm_pending_status_reg (so it will be 0x0) and check for
> non-zero value later?
>
> It might be a little bit non consistent approach to how we map RTC
> registers (REG_RTC_NONE)... so I don't have strong feelings about this.

I choose -1 because 0 is also valid.
So I can have macro for INVALID register which is -1 and use here, other 
places direct register as STATUS2.


>
>> +	if (info->drv_data->rtc_irq_from_platform) {
>> +		struct platform_device *pdev = to_platform_device(info->dev);
>> +
>> +		info->rtc_irq = platform_get_irq(pdev, 0);
> It may return -ERRNO. What happens then?

MFD is initializing the irq and so it will not fail on this particular case.
Even if error, the regmap_add_irq should fail.

Let me handle error at this point only to avoid any assumption and 
further processing with error, by returning error.


>
>> +	} else {
>> +		info->rtc_irq =  parent_i2c->irq;
>> +	}
>>   
>>   	info->regmap = dev_get_regmap(parent, NULL);
>>   	if (!info->regmap) {
>> @@ -802,6 +840,8 @@ static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
>>   static const struct platform_device_id rtc_id[] = {
>>   	{ "max77686-rtc", .driver_data = (kernel_ulong_t)&max77686_drv_data, },
>>   	{ "max77802-rtc", .driver_data = (kernel_ulong_t)&max77802_drv_data, },
>> +	{ "max77620-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
>> +	{ "max20024-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> There shouldn't be "max20024-rtc". This is exactly the same as
> "max77620-rtc" so re-use existing id. No point of duplicating device
> names for 100% compatible devices.
>
>
I am thinking that having compatible for each device which it supports 
is better.

In MFD, I have made all sub module of max20024 as max20024-<module>.
I have not mixed the sub module name for max20024 with max77620 module.


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
