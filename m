Return-Path: <rtc-linux+bncBAABBAESWC3QKGQELKUIOUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id sf5si2108275pac.1.2016.03.18.06.56.15
        for <rtc-linux@googlegroups.com>;
        Fri, 18 Mar 2016 06:56:15 -0700 (PDT)
Subject: Re: [rtc-linux] Re: [PATCH v3] rtc: s3c: Don't print an error on
 probe deferral
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com
References: <1458005918-7893-1-git-send-email-javier@osg.samsung.com>
 <56E76A57.7070104@samsung.com> <56E76C6F.5020803@osg.samsung.com>
 <56E772F2.2030507@samsung.com> <56E77A6A.2090604@osg.samsung.com>
 <56EBED45.6070000@osg.samsung.com> <20160318120717.GD2531@piout.net>
 <CAJKOXPeam-rpnijB0OgGxbY2rdtVwqwdEyHb_LOyzZnXuY82vg@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56EC08F8.2080400@osg.samsung.com>
Date: Fri, 18 Mar 2016 10:56:08 -0300
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeam-rpnijB0OgGxbY2rdtVwqwdEyHb_LOyzZnXuY82vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On 03/18/2016 09:20 AM, Krzysztof Kozlowski wrote:
> On Fri, Mar 18, 2016 at 9:07 PM, Alexandre Belloni
>> On 18/03/2016 at 08:57:57 -0300, Javier Martinez Canillas wrote :

[snip]

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
> Although I did not test it, I think the core will print generic defer
> message. See really_probe() around line 400:
> http://lxr.free-electrons.com/source/drivers/base/dd.c?v=4.4#L347
> 
> However the cause of deferring will not be printed... so I find some
> use of debug message in driver... On the other hand, not many drivers
> are doing this. Ehh, I guess I am just really picky. :)
>

It's Ok, I also have doubts about which direction to take even when
writing trivial patches like $SUBJECT, so I understand the feeling :)

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
