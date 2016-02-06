Return-Path: <rtc-linux+bncBD2OLRXW4ABBBZPU262QKGQEWMFOZEA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si2779257pac.1.2016.02.06.05.51.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2016 05:51:33 -0800 (PST)
Message-ID: <56B5F7B4.6080306@nvidia.com>
Date: Sat, 6 Feb 2016 19:10:04 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com> <1454507233-9959-6-git-send-email-ldewangan@nvidia.com> <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com> <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com> <56B4B38C.3030805@nvidia.com> <56B58501.603@osg.samsung.com> <56B592C5.3040208@nvidia.com> <56B5EEB0.3040505@osg.samsung.com>
In-Reply-To: <56B5EEB0.3040505@osg.samsung.com>
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


On Saturday 06 February 2016 06:31 PM, Javier Martinez Canillas wrote:
> Hello Laxman,
>
> On 02/06/2016 03:29 AM, Laxman Dewangan wrote:
>>
>> So the issue is that when we create mapping, we can not delete the 
>> irq_chip.
>>
>> I saw one function from irq framework irq_dispose_mapping(unsigned 
>> int virq).
>>
>> So we need to dispose the mapping before deleting irq chip.
>>
>>
>> Becasue it is reproduced in normal boot also if we do create mapping 
>> and delete the irq chip data, I will also be able to validate if I 
>> get some time on weekend.
>>
>
> Thanks, that was it! I was searching yesterday for the 
> regmap_irq_get_virq()
> counterpart and did not find it, but I was looking at 
> include/linux/regmap.h
> and didn't think about looking at include/linux/irqdomain.h.
>
> Maybe we should add a regmap_irq_put_virq() that's just a wrapper around
> irq_dispose_mapping() to make the API consistent and avoid this 
> confusion?
> I see that most drivers don't dispose the mapping on their 
> error/remove path.
>
> Anyways, with this patch on top of yours 5/5 my system is able to suspend
> after an unbind again:
>
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 45d639674c0b..8ea6d601482a 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -765,6 +765,7 @@ static int max77686_rtc_remove(struct 
> platform_device *pdev)
>      struct max77686_rtc_info *info = platform_get_drvdata(pdev);
>
>      free_irq(info->virq, info);
> +    irq_dispose_mapping(info->virq);
>      regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
>      if (info->rtc)
>          i2c_unregister_device(info->rtc);
>
> This is a bug in the current MFD driver though so I would include it as
> a separate patch prior to your patch that moves the regmap and i2c init
> to the RTC driver.
>
> When posting your new revsion feel free to add my {Reviewed,Tested}-by
> tags for $SUBJECT and the new bugfix patch.


Thank you very much for testing/help.
Now we have all the fixes on this series. I am going to add the "put" 
funntion on regmap and then first fix it in the rtc driver and then 
apply my series on top of that. Now 7 patches..


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
