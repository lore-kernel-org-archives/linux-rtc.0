Return-Path: <rtc-linux+bncBD5O5IWPJMIPBBGDVMCRUBH23TQ26@googlegroups.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id p12si7674wiv.1.2015.06.04.14.26.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 14:26:08 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id d19so2092854wiw.0
        for <rtc-linux@googlegroups.com>; Thu, 04 Jun 2015 14:26:08 -0700 (PDT)
Message-ID: <5570C26D.5080204@gmail.com>
Date: Thu, 04 Jun 2015 23:26:05 +0200
From: Philippe Reynes <tremyfr@gmail.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
 a.zummo@towertech.it, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, rtc-linux@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, fabio.estevam@freescale.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: mxc: add support of device tree
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com> <1431729330-7625-3-git-send-email-tremyfr@gmail.com> <20150528120601.GO2185@piout.net>
In-Reply-To: <20150528120601.GO2185@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,


On 28/05/15 14:06, Alexandre Belloni wrote:
> Hi,
>
> On 16/05/2015 at 00:35:30 +0200, Philippe Reynes wrote :
>>
>
> Please always include a commit message.

Oh yes, sorry about that.

>> Signed-off-by: Philippe Reynes<tremyfr@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 +++++++++++++++++++++
>>   drivers/rtc/rtc-mxc.c                             |   22 ++++++++++++++++-
>>   2 files changed, 48 insertions(+), 1 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>> new file mode 100644
>> index 0000000..5505493
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>> @@ -0,0 +1,27 @@
>> +* Real Time Clock of the i.MX SoCs
>> +
>> +RTC controller for the i.MX SoCs
>> +
>> +Required properties:
>> +- compatible: Should be "fsl,imx1-rtc" or "fsl,imx21-rtc".
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: IRQ line for the RTC.
>> +- clocks: should contain two entries:
>> +  * one for the input reference
>> +  * one for the the SoC RTC
>> +- clock-names: should contain:
>> +  * "rtc" for the input reference clock
>> +  * "ipg" for the SoC RTC clock
>> +
>> +Example:
>> +
>> +rtc@10007000 {
>> +	compatible = "fsl,imx21-rtc";
>> +	reg =<0x10007000 0x1000>;
>> +	interrupts =<22>;
>> +	clocks =<&clks IMX27_CLK_CKIL>,
>> +	       	<&clks IMX27_CLK_RTC_IPG_GATE>;
>> +	clock-names = "rtc, "ipg";
>> +	status = "disabled";
>> +};
>> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
>> index e916a91..df6483d 100644
>> --- a/drivers/rtc/rtc-mxc.c
>> +++ b/drivers/rtc/rtc-mxc.c
>> @@ -16,6 +16,8 @@
>>   #include<linux/interrupt.h>
>>   #include<linux/platform_device.h>
>>   #include<linux/clk.h>
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>>
>>   #define RTC_INPUT_CLK_32768HZ	(0x00<<  5)
>>   #define RTC_INPUT_CLK_32000HZ	(0x01<<  5)
>> @@ -98,6 +100,15 @@ static struct platform_device_id imx_rtc_devtype[] = {
>>   };
>>   MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id imx_rtc_dt_ids[] = {
>> +	{ .compatible = "fsl,imx1-rtc", .data =&imx_rtc_devtype[IMX1_RTC] },
>> +	{ .compatible = "fsl,imx21-rtc", .data =&imx_rtc_devtype[IMX21_RTC] },
>
> Maybe you can use directly IMX1_RTC and IMX21_RTC which...

I've seen both "style" on the code. I may change the code to simply use IMX1_RTC
and IMX21_RTC.

>>
>> -	pdata->devtype = pdev->id_entry->driver_data;
>> +	of_id = of_match_device(imx_rtc_dt_ids,&pdev->dev);
>> +	if (of_id) {
>> +		struct platform_device_id *id_entry;
>> +
>> +		id_entry = (struct platform_device_id *)of_id->data;
>> +		pdata->devtype = id_entry->driver_data;
>
> ... also simplifies that part.

I'll do it in the next version of this patch.
  
>> +	} else
>> +		pdata->devtype = pdev->id_entry->driver_data;
>>
>

Do you prefer that I wait the clock driver has move to drivers/clk/imx
(as requested by Shawn) before sending a v2 ?

Regards,
Philippe

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
