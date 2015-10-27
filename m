Return-Path: <rtc-linux+bncBD747RFBYUPBBOU3XSYQKGQEMCIBBMA@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id el2si3914850pbb.0.2015.10.26.22.38.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Oct 2015 22:38:01 -0700 (PDT)
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWV01CT76BB5Q90@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 27 Oct 2015 14:37:59 +0900 (KST)
Message-id: <562F0B7C.9080307@samsung.com>
Date: Tue, 27 Oct 2015 10:58:28 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, k.kozlowski@samsung.com, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Thomas Abraham <thomas.ab@samsung.com>
Subject: [rtc-linux] Re: [PATCH v2 2/5] mfd: sec: Add support for S2MPS15 PMIC
References: <1445855803-26973-1-git-send-email-alim.akhtar@samsung.com>
 <1445855803-26973-3-git-send-email-alim.akhtar@samsung.com>
 <20151026110611.GH597@x1> <562E1F84.2000105@samsung.com>
 <20151026142930.GJ597@x1>
In-reply-to: <20151026142930.GJ597@x1>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello

On 10/26/2015 07:59 PM, Lee Jones wrote:
> On Mon, 26 Oct 2015, Alim Akhtar wrote:
>
>> Hi Lee,
>> Thanks for looking into this.
>>
>> On 10/26/2015 04:36 PM, Lee Jones wrote:
>>> On Mon, 26 Oct 2015, Alim Akhtar wrote:
>>>
>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>
>>>> Add support for S2MPS15 PMIC which is similar to S2MPS11 PMIC. The S2MPS15
>>>> PMIC supports 27 LDO regulators, 10 buck regulators, RTC, three 32.768KHz
>>>> clock outputs and battery charger. This patch adds initial support for
>>>> LDO and buck regulators of S2MPS15 device.
>>>>
>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>> [Alim: Added s2mps15_devs like rtc and clk and related changes]
>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> ---
>>>>   drivers/mfd/sec-core.c              |   31 +++++++
>>>>   drivers/mfd/sec-irq.c               |    8 ++
>>>>   include/linux/mfd/samsung/core.h    |    1 +
>>>>   include/linux/mfd/samsung/s2mps15.h |  161 +++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 201 insertions(+)
>>>>   create mode 100644 include/linux/mfd/samsung/s2mps15.h
>>>>
>>>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>>> index 2626fc0b5b8c..db3d4d4ff805 100644
>>>> --- a/drivers/mfd/sec-core.c
>>>> +++ b/drivers/mfd/sec-core.c
>>>> @@ -29,6 +29,7 @@
>>>>   #include <linux/mfd/samsung/s2mps11.h>
>>>>   #include <linux/mfd/samsung/s2mps13.h>
>>>>   #include <linux/mfd/samsung/s2mps14.h>
>>>> +#include <linux/mfd/samsung/s2mps15.h>
>>>>   #include <linux/mfd/samsung/s2mpu02.h>
>>>>   #include <linux/mfd/samsung/s5m8763.h>
>>>>   #include <linux/mfd/samsung/s5m8767.h>
>>>> @@ -96,6 +97,17 @@ static const struct mfd_cell s2mps14_devs[] = {
>>>>   	}
>>>>   };
>>>>
>>>> +static const struct mfd_cell s2mps15_devs[] = {
>>>> +	{
>>>> +		.name = "s2mps15-pmic",
>>>> +	}, {
>>>> +		.name = "s2mps15-rtc",
>>>> +	}, {
>>>
>>> Why don't these have compatibles?
>>>
>> s2mps15-pmic does have compatible below in sec_dt_match[].
>
> Woah!!  What's going on here?  You're matching the MFD and Regulator
> drivers with the same compatible string.  And then registering the
> Regulator device as an MFD.  That's a bit confusing don't you think?
>
Sorry for the confusion, as explained in the binding documentation,
S2MPS15 is a multi-function device which has rtc, regulator and clk 
provider as a sub-blocks. And each of these sub-blocks are represented
as child node of parent MFD node. Out of these only clk controller child 
node needs its own compatible string to populate of_node structure of 
the device so that it can access properties of this sub-node in 
drivers/clk/clk-s2mps11.c.
I just followed "Documentation/devicetree/bindings/mfd/s2mps11.txt"
to implement s2mps15.


>> s2mps15-rtc does not need one as rtc driver does not support OF yet.
>> So no DT node for this as of now.
>
> [...]
>

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
