Return-Path: <rtc-linux+bncBAABBHPN462QKGQEHVJWCWA@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id u66si5290289pfa.2.2016.02.09.06.24.28
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Feb 2016 06:24:29 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V6 1/6] regmap: irq: dispose all virtual irq
 before removing domain
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
 broonie@kernel.org, gregkh@linuxfoundation.org, a.zummo@towertech.it
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
 <1455020907-4564-2-git-send-email-ldewangan@nvidia.com>
 <56B9E93A.2040903@osg.samsung.com> <56B9F078.1030006@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Message-ID: <56B9F695.4060501@osg.samsung.com>
Date: Tue, 9 Feb 2016 11:24:21 -0300
MIME-Version: 1.0
In-Reply-To: <56B9F078.1030006@nvidia.com>
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

Hello Laxman,

On 02/09/2016 10:58 AM, Laxman Dewangan wrote:
>
> On Tuesday 09 February 2016 06:57 PM, Javier Martinez Canillas wrote:
>> Hello Laxman,
>>
>> On 02/09/2016 09:28 AM, Laxman Dewangan wrote:
>>> It is require to dispose all virtual irq of hwirq on chip
>>> created on given irq domain before removing this irq domain.
>>> Hence dispose all mapped irqs before deleting the irq domains
>>> in regmap_del_irq_chip();
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>>
>>
>> I believe this patch could be picked separately and not made part of
>> this series since is fixing a bug that happens on most drivers using
>> the regmap-irq API. This will avoid cross-subsystem churn for people.
>>
>> Your patch 6/6 does not introduce a regression since the bug already
>> exists in the MFD driver, it just makes it more noticeable since it
>> is easier to unbind the max77686 RTC driver than the MFD one.
>
>
> If we dont have fix then rtc unbind/bind creates issue on S2R. Although it was issue on tot but the issue visible with my patch only.
>
> So if you test my 2 to 6 without 1, you will see issue.
>

Yes I know that but my point is that this will also happen in mainline if
the MFD device is unbind. Is just that it's harder to do so since at least
in the Chromebooks the regulators are used for the panel and backlight so
you will need a serial console.
  
> So to avoid bisect issue in functionality wise, this should go on sequence. This is my view.
>

The problem with patch series touching different subsystems is that the
maintainers have to agree on how to handle the possible conflicts so it
is easier for them if you split the patches and post them separately if
the are really no dependencies.

My view is that this fixes a regmap-irq core bug that is present in all
the drivers using regmap-irq that remove the IRQ chip after mapping IRQs
so it's really not related to your RTC series.

But of course I'm not a subsystem maintainer so is up to Alexandre and
Mark to decide that. I was just giving my opinion.

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
