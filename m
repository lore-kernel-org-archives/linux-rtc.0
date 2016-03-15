Return-Path: <rtc-linux+bncBAABB4PUTW3QKGQEJ5CA4XI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si3798152pab.0.2016.03.14.19.58.56
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 19:58:57 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3] rtc: s3c: Don't print an error on probe deferral
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1458005918-7893-1-git-send-email-javier@osg.samsung.com>
 <56E76A57.7070104@samsung.com> <56E76C6F.5020803@osg.samsung.com>
 <56E772F2.2030507@samsung.com>
Cc: Joe Perches <joe@perches.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56E77A6A.2090604@osg.samsung.com>
Date: Mon, 14 Mar 2016 23:58:50 -0300
MIME-Version: 1.0
In-Reply-To: <56E772F2.2030507@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On 03/14/2016 11:26 PM, Krzysztof Kozlowski wrote:
> On 15.03.2016 10:59, Javier Martinez Canillas wrote:
>>>>  
>>>>  	if (info->data->needs_src_clk) {
>>>>  		info->rtc_src_clk = devm_clk_get(&pdev->dev, "rtc_src");
>>>>  		if (IS_ERR(info->rtc_src_clk)) {
>>>> -			dev_err(&pdev->dev,
>>>> -				"failed to find rtc source clock\n");
>>>> +			ret = PTR_ERR(info->rtc_src_clk);
>>>> +			if (ret != -EPROBE_DEFER)
>>>> +				dev_err(&pdev->dev,
>>>> +					"failed to find rtc source clock\n");
>>>> +			else
>>>> +				dev_dbg(&pdev->dev,
>>>> +					"probe deferred due to missing rtc src clk\n");
>>>>  			clk_disable_unprepare(info->rtc_clk);
>>>> -			return PTR_ERR(info->rtc_src_clk);
>>>> +			return ret;
>>>>  		}
>>>>  		clk_prepare_enable(info->rtc_src_clk);
>>>>  	}
>>>>
>>>
>>> The error path starts looking complicated. This has now 4 indentation
>>> levels...
>>>
>>
>> Yeah, I don't think we can get rid of the 4 indentation levels since
>> the function already has 3 and a check for the errno code is needed.
> 
> Probably handling of the clocks in the driver could be simplified a
> little bit (the if(needs_src_clk) appears in few places)... but this is
> out of scope for this patch.
>

Agreed, I meant without introducing an unrelated change.
 
>>
>>> I agree for removal of error in case of probe deferral because it might
>>> be misleading but I don't see much benefit of a debug message.
>>>
>>
>> But yes, we can at least get rid of the else statement. I don't have a
>> strong opinion about the debug information, I left it to avoid someone
>> to tell me that I was removing a useful log.
> 
> Although dev_dbg doesn't harm... but isn't driver core printing debug
> message already?
>

I don't think it does or at least I didn't find it when looking
at the devm_clk_get() call chain.
 
> BR,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
