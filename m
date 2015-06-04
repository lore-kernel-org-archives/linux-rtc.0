Return-Path: <rtc-linux+bncBD5O5IWPJMIL57GCVMCRUBGTMIACG@googlegroups.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com. [2a00:1450:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id p12si5366wiv.1.2015.06.04.14.08.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 14:08:13 -0700 (PDT)
Received: by mail-wi0-x236.google.com with SMTP id dt2so1016423wib.1
        for <rtc-linux@googlegroups.com>; Thu, 04 Jun 2015 14:08:13 -0700 (PDT)
Message-ID: <5570BE33.9080103@gmail.com>
Date: Thu, 04 Jun 2015 23:08:03 +0200
From: Philippe Reynes <tremyfr@gmail.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
 a.zummo@towertech.it, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, rtc-linux@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, fabio.estevam@freescale.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: mxc: add a second clock
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com> <1431729330-7625-2-git-send-email-tremyfr@gmail.com> <20150528115731.GN2185@piout.net>
In-Reply-To: <20150528115731.GN2185@piout.net>
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

On 28/05/15 13:57, Alexandre Belloni wrote:
> Hi,
>
> On 16/05/2015 at 00:35:29 +0200, Philippe Reynes wrote :
>> The mxc RTC needs two clocks, one for the input
>> reference, and one for the IP. But this driver
>> was only using one clock (for the reference).
>> This patch add the second clock (for the IP).
>>
>> Signed-off-by: Philippe Reynes<tremyfr@gmail.com>
>> ---
>>   arch/arm/mach-imx/clk-imx31.c |    3 ++-
>>   drivers/rtc/rtc-mxc.c         |   26 +++++++++++++++++---------
>>   2 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
>> index 286ef42..480c54f 100644
>> --- a/arch/arm/mach-imx/clk-imx31.c
>> +++ b/arch/arm/mach-imx/clk-imx31.c
>> @@ -130,7 +130,8 @@ int __init mx31_clocks_init(unsigned long fref)
>>   	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
>>   	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
>>   	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
>> -	clk_register_clkdev(clk[rtc_gate], NULL, "imx21-rtc");
>> +	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
>> +	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
>>   	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
>>   	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
>>   	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
>
> This should probably go in a separate patch so that Shawn can apply it.

Yes, I will do a patch and send it on the mailling list.
  
>> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
>> index 09d422b..e916a91 100644
>> --- a/drivers/rtc/rtc-mxc.c
>> +++ b/drivers/rtc/rtc-mxc.c
>> @@ -79,7 +79,8 @@ struct rtc_plat_data {
>>   	struct rtc_device *rtc;
>>   	void __iomem *ioaddr;
>>   	int irq;
>> -	struct clk *clk;
>> +	struct clk *clk_rtc;
>> +	struct clk *clk_ipg;
>>   	struct rtc_time g_rtc_alarm;
>>   	enum imx_rtc_type devtype;
>>   };
>> @@ -373,17 +374,24 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>>   	if (IS_ERR(pdata->ioaddr))
>>   		return PTR_ERR(pdata->ioaddr);
>>
>> -	pdata->clk = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(pdata->clk)) {
>> -		dev_err(&pdev->dev, "unable to get clock!\n");
>> -		return PTR_ERR(pdata->clk);
>> +	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>> +	if (IS_ERR(pdata->clk_ipg)) {
>> +		dev_err(&pdev->dev, "unable to get ipg clock!\n");
>> +		return PTR_ERR(pdata->clk_ipg);
>>   	}
>>
>> -	ret = clk_prepare_enable(pdata->clk);
>> +	ret = clk_prepare_enable(pdata->clk_ipg);
>>   	if (ret)
>>   		return ret;
>>
>> -	rate = clk_get_rate(pdata->clk);
>> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
>> +	if (IS_ERR(pdata->clk_rtc)) {
>> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
>> +		ret = PTR_ERR(pdata->clk_rtc);
>> +		goto exit_put_clk;
>> +	}
>> +
>> +	rate = clk_get_rate(pdata->clk_rtc);
>
> You are getting the rate but don't you need to clk_prepare_enable()?

This IP needs the clock reference rate for his configuration,
so I think that I only need the rate.

> Also, aren't those devm_clk_get now failing on i.mx35? Maybe it was
> already failing before that patch as I don't see any rtc clock being
> registeres in clk-imx35.c

Yes, I don't see this clock on clk-imx35.c too.So I don't understand how
this driver could work on imx35. The board MX35PDK use this driver,
but in my understanding, it should be broken. If someone has this board
and have some time to test the rtc, I would be pleased to get the result.

>>
>>   	if (rate == 32768)
>>   		reg = RTC_INPUT_CLK_32768HZ;
>> @@ -432,7 +440,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>>   	return 0;
>>
>>   exit_put_clk:
>> -	clk_disable_unprepare(pdata->clk);
>> +	clk_disable_unprepare(pdata->clk_ipg);
>>
>>   	return ret;
>>   }
>> @@ -441,7 +449,7 @@ static int mxc_rtc_remove(struct platform_device *pdev)
>>   {
>>   	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
>>
>> -	clk_disable_unprepare(pdata->clk);
>> +	clk_disable_unprepare(pdata->clk_ipg);
>>
>>   	return 0;
>>   }
>> --
>> 1.7.4.4
>>
>

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
