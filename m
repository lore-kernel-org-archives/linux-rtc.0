Return-Path: <rtc-linux+bncBC2IT2GSZUDRBM6P67FAKGQENTA25UI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id s84si8782415wmf.5.2017.07.06.00.33.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2017 00:33:07 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: stm32: add STM32H7 RTC support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
 <20170705213746.6hf5af57ty6wsfgs@piout.net>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <ebe3f3f0-263d-cf6c-6b6e-2f37ab435c88@st.com>
Date: Thu, 6 Jul 2017 09:33:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170705213746.6hf5af57ty6wsfgs@piout.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 07/05/2017 11:37 PM, Alexandre Belloni wrote:
> Hi,
> 
> This is mostly fine, even if I'm not too happy with the
> s/ck_rtc/rtc_ck/.
> 
This clock name has changed in datasheet between STM32F4/STM32F7 and 
STM32H7, so, I'm not really happy too... But, as there is only one clock 
on F4/F7, its name is not important for the end user. Now that pclk 
appears, we need to distinguish the two clocks, and for the end user, it 
is better if the clock names match the datasheet.

> On 26/06/2017 at 11:51:29 +0200, Amelie Delaunay wrote:
>> -	rtc->ck_rtc = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(rtc->ck_rtc)) {
>> -		dev_err(&pdev->dev, "no ck_rtc clock");
>> -		return PTR_ERR(rtc->ck_rtc);
>> +	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
>> +	if (match && match->data)
>> +		rtc->data = (struct stm32_rtc_data *)match->data;
>> +	else
>> +		return -EINVAL;
> 
> This will never happen, you can remove that test.
> 
> 
OK, will be done in V2.

Thanks for the review,
Amelie

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
