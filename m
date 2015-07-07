Return-Path: <rtc-linux+bncBCMNZUWXYYORBI7H5WWAKGQEMWK6NNY@googlegroups.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com. [209.85.192.181])
        by gmr-mx.google.com with ESMTPS id xz5si2142784pac.1.2015.07.06.23.37.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 23:37:23 -0700 (PDT)
Received: by pddu5 with SMTP id u5so32510231pdd.3
        for <rtc-linux@googlegroups.com>; Mon, 06 Jul 2015 23:37:23 -0700 (PDT)
Message-ID: <559B739A.3080300@linaro.org>
Date: Tue, 07 Jul 2015 12:07:14 +0530
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 lee.jones@linaro.org, devicetree@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Chao Xie <chao.xie@marvell.com>
Subject: Re: [rtc-linux] [PATCH-v2] rtc: 88pm80x: add device tree support
References: <vaibhav.hiremath@linaro.org> <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org> <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org> <20150620004354.GY27492@piout.net> <558BB1C1.2090400@linaro.org>
In-Reply-To: <558BB1C1.2090400@linaro.org>
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



On Thursday 25 June 2015 01:16 PM, Vaibhav Hiremath wrote:
>
>
> On Saturday 20 June 2015 06:13 AM, Alexandre Belloni wrote:
>> Hi,
>>
>
> Sorry I missed this email.
> Just wanted to send reminder email and saw this :)
>
>> On 18/06/2015 at 00:28:06 +0530, Vaibhav Hiremath wrote :
>>> -    pdata = dev_get_platdata(&pdev->dev);
>>> -    if (pdata == NULL)
>>> -        dev_warn(&pdev->dev, "No platform data!\n");
>>> +    if (!pdata && !node) {
>>> +        dev_err(&pdev->dev,
>>> +            "pm80x-rtc requires platform data or of_node\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!pdata) {
>>> +        pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>
>> I had troubles to follow the rtc_wakeup initialization cleanup but it
>> seems OK.
>
> Probably, once we have complete PM support ready then it would be
> easier to understand. I think as of now lets have this minimal code for
> rtc_wakeup.
>
>> However, I'm wondering why you are adding DT support as this
>> will always be probed from the MFD driver which pass the platform_data
>> and avoids that allocation.
>>
>
> You are right.
>
> Originally, it was cleanup patch,
>
>   - remove pm80x_pdata
>   - Add check for pdata and np
>   - and around rtc_wakeup
>
> While doing that I added this nice to have allocation.
>

Any update/feedback on this?

Thanks,
Vaibhav

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
