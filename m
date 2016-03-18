Return-Path: <rtc-linux+bncBAABBNMMWC3QKGQETKJYOIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id sf5si2098986pac.1.2016.03.18.06.44.20
        for <rtc-linux@googlegroups.com>;
        Fri, 18 Mar 2016 06:44:20 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3] rtc: s3c: Don't print an error on probe deferral
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1458005918-7893-1-git-send-email-javier@osg.samsung.com>
 <56E76A57.7070104@samsung.com> <56E76C6F.5020803@osg.samsung.com>
 <56E772F2.2030507@samsung.com> <56E77A6A.2090604@osg.samsung.com>
 <56EBED45.6070000@osg.samsung.com> <20160318120717.GD2531@piout.net>
 <20160318130312.GE2531@piout.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56EC062C.8060702@osg.samsung.com>
Date: Fri, 18 Mar 2016 10:44:12 -0300
MIME-Version: 1.0
In-Reply-To: <20160318130312.GE2531@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

On 03/18/2016 10:03 AM, Alexandre Belloni wrote:
> On 18/03/2016 at 13:07:17 +0100, Alexandre Belloni wrote :
>> On 18/03/2016 at 08:57:57 -0300, Javier Martinez Canillas wrote :
>>>>>> But yes, we can at least get rid of the else statement. I don't have a
>>>>>> strong opinion about the debug information, I left it to avoid someone
>>>>>> to tell me that I was removing a useful log.
>>>>>
>>>>> Although dev_dbg doesn't harm... but isn't driver core printing debug
>>>>> message already?
>>>>>
>>>>
>>>> I don't think it does or at least I didn't find it when looking
>>>> at the devm_clk_get() call chain.
>>>>  
>>>>> BR,
>>>>> Krzysztof
>>>>>
>>>
>>> Just to make sure that I understood correctly, there's no action I
>>> should take in order for this patch to be picked right? IOW, the
>>> current version is OK?
>>>
>>
>> I was kind of waiting an answer on the question whether the core already
>> prints a message when probe dereferral happens because in that case,
>> there is no need for a debug message and we can indeed simplify the
>> whole block.
> 
> Ok, I've found the recent commit 13fcffbbdec4e4863a9a9c7792b821cd6d363a8f
> 
> I'll take the patch as is.
> 
> 

Great, thanks!

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
