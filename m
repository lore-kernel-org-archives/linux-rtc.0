Return-Path: <rtc-linux+bncBD2OLRXW4ABBBV4RVW2QKGQEA6DQKZY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id jg4si1966027pac.2.2016.01.29.03.11.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 03:11:18 -0800 (PST)
Message-ID: <56AB462A.8090307@nvidia.com>
Date: Fri, 29 Jan 2016 16:29:54 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <broonie@kernel.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun
 Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V6 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
References: <1453988274-28052-1-git-send-email-ldewangan@nvidia.com> <1453988274-28052-3-git-send-email-ldewangan@nvidia.com> <20160129090632.GS3368@x1>
In-Reply-To: <20160129090632.GS3368@x1>
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

Thanks Lee for review.
I will take care of most of stuff on next version of patch.

However, I have some query form your comment.
On Friday 29 January 2016 02:36 PM, Lee Jones wrote:
> On Thu, 28 Jan 2016, Laxman Dewangan wrote:
>
>
>> +	}
>> +
>> +#define MAX20024_SUB_MODULE_NO_RES(_name, _id)			\
>> +	[_id] = {						\
>> +		.name = "max20024-"#_name,			\
>> +		.id = _id,					\
>> +	}
> I don't want people hand-rolling this stuff.  If it's useful to you,
> it's useful to others, so great a generic implementation that lives in
> the kernel headers directory.

yaah, generic implementation possible. I can put the new defines in the 
mfd/core.h.

This will be similar to
+/* Define mfd cells with name and resource */
+#define DEFINE_MFD_CELL_NAME_RESOURCE(_name, _res)             \
+       {                                                       \
+               .name = (_name),                                \
+               .num_resources = ARRAY_SIZE((res)),             \
+               .resources = (_res),                            \
+       }
+
+/* Define mfd cells with name */
+#define DEFINE_MFD_CELL_NAME(_name)                            \
+       {                                                       \
+               .name = (_name),                                \
+       }
+

This will be separate patch and should be applied before this series.
Does it look fine?


>
>> +static const struct i2c_device_id max77620_id[] = {
>> +	{"max77620", MAX77620},
>> +	{"max20024", MAX20024},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max77620_id);
>> +
>> +static const struct of_device_id max77620_of_match[] = {
>> +	{
>> +		.compatible = "maxim,max77620",
>> +		.data = &max77620_cells,
>> +	}, {
>> +		.compatible = "maxim,max20024",
>> +		.data = &max20024_cells,
>> +	}, {
>> +	},
>> +};
>> +MODULE_DEVICE_TABLE(of, max77620_of_match);
> This is not acceptable.  EITHER use DT OR MFD methods of registering
> devices, do not mix the two.

You mean I need to either provide the i2c_device_id table or the 
of_device_id table, not both?
Do I need to protect it by CONFIG_OF?

This only support the DT method of registration. So do I need to remove 
i2c_device_id?





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
