Return-Path: <rtc-linux+bncBD747RFBYUPBB25OYGYQKGQE55SGDNA@googlegroups.com>
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id pe1si4695242pac.2.2015.10.27.22.04.42
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 22:04:42 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWW01ENXZFTQJ50@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 28 Oct 2015 14:04:41 +0900 (KST)
Message-id: <5630554E.8070301@samsung.com>
Date: Wed, 28 Oct 2015 10:25:42 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
Cc: mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 4/5] clk: s2mps15: Add support for S2MPS15 clocks
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-5-git-send-email-alim.akhtar@samsung.com>
 <5630243E.1080608@samsung.com> <5630503A.3070404@samsung.com>
In-reply-to: <5630503A.3070404@samsung.com>
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



On 10/28/2015 10:04 AM, Krzysztof Kozlowski wrote:
> On 28.10.2015 10:26, Krzysztof Kozlowski wrote:
>> On 26.10.2015 21:51, Alim Akhtar wrote:
>>> S2MPS15 PMIC has three 32k buffered clocks outputs. This patch
>>> adds supports for the same to the s2mps11 clock driver.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   drivers/clk/Kconfig       |    5 +++--
>>>   drivers/clk/clk-s2mps11.c |   24 ++++++++++++++++++++++++
>>>   2 files changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index a1fa61159179..037a314b5d76 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -120,9 +120,10 @@ config COMMON_CLK_S2MPS11
>>>   	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
>>>   	depends on MFD_SEC_CORE
>>>   	---help---
>>> -	  This driver supports S2MPS11/S2MPS14/S5M8767 crystal oscillator
>>> +	  This driver supports S2MPS1X/S5M8767 crystal oscillator
>>>   	  clock. These multi-function devices have two (S2MPS14) or three
>>> -	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>>> +	  (S2MPS11/S2MPS13/S2MPS15/S5M8767) fixed-rate oscillators,
>>> +	  clocked at 32KHz each.
>>>
>>>   config CLK_TWL6040
>>>   	tristate "External McPDM functional clock from twl6040"
>>> diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
>>> index d266299dfdb1..455500dca653 100644
>>> --- a/drivers/clk/clk-s2mps11.c
>>> +++ b/drivers/clk/clk-s2mps11.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/mfd/samsung/s2mps11.h>
>>>   #include <linux/mfd/samsung/s2mps13.h>
>>>   #include <linux/mfd/samsung/s2mps14.h>
>>> +#include <linux/mfd/samsung/s2mps15.h>
>>>   #include <linux/mfd/samsung/s5m8767.h>
>>>   #include <linux/mfd/samsung/core.h>
>>>
>>> @@ -148,6 +149,24 @@ static struct clk_init_data s2mps14_clks_init[S2MPS11_CLKS_NUM] = {
>>>   	},
>>>   };
>>>
>>> +static struct clk_init_data s2mps15_clks_init[S2MPS11_CLKS_NUM] = {
>>> +	[S2MPS11_CLK_AP] = {
>>> +		.name = "s2mps15_ap",
>>> +		.ops = &s2mps11_clk_ops,
>>> +		.flags = CLK_IS_ROOT,
>>> +	},
>>> +	[S2MPS11_CLK_CP] = {
>>> +		.name = "s2mps15_cp",
>>> +		.ops = &s2mps11_clk_ops,
>>> +		.flags = CLK_IS_ROOT,
>>> +	},
>>> +	[S2MPS11_CLK_BT] = {
>>> +		.name = "s2mps15_bt",
>>> +		.ops = &s2mps11_clk_ops,
>>> +		.flags = CLK_IS_ROOT,
>>> +	},
>>> +};
>>> +
>>>   static struct device_node *s2mps11_clk_parse_dt(struct platform_device *pdev,
>>>   		struct clk_init_data *clks_init)
>>>   {
>>> @@ -207,6 +226,10 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
>>>   		s2mps11_reg = S2MPS14_REG_RTCCTRL;
>>>   		clks_init = s2mps14_clks_init;
>>>   		break;
>>> +	case S2MPS15X:
>>> +		s2mps11_reg = S2MPS15_REG_RTC_BUF;
>>> +		clks_init = s2mps15_clks_init;
>>
>> Another question (after looking at RTC driver):
>> Is this the same register address as S2MPS14?
>
> I found the answer - this is the same address as in S2MPS13 and S2MPS14:
> 0xc. The S2MPS14 has only two clocks though but S2MPS13 has three.
> Again, as in RTC, you should re-use existing support.
>
> It looks there is no need for this patch at all.
>
Yes, checked that, rtc looks same to s2mps14 and clk looks same as 
s2mps13{ not s2mps11}, because of the RTC_BUF address changes.
Will drop patch 4 and 5 and use the existing names where applicable.
I think I don't have to change the binding or Kconfig changes?


> Best regards,
> Krzysztof
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
