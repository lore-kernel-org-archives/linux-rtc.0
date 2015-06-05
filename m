Return-Path: <rtc-linux+bncBD62P6P6EQIPLKGIVMCRUBAX6IAOW@googlegroups.com>
Received: from mail-vn0-x232.google.com (mail-vn0-x232.google.com. [2607:f8b0:400c:c0f::232])
        by gmr-mx.google.com with ESMTPS id ci2si359711vdd.3.2015.06.05.14.28.21
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2015 14:28:21 -0700 (PDT)
Received: by vnbg129 with SMTP id g129so10713502vnb.9
        for <rtc-linux@googlegroups.com>; Fri, 05 Jun 2015 14:28:21 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <871thq54c7.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home> <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home> <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
 <871thq54c7.fsf@belgarion.home>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Jun 2015 16:28:00 -0500
Message-ID: <CAL_JsqJnj+JLFoUmE6COqhr83_H0n1=Bdk_wYnMZEzsZRu=aew@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 0/6] SA1100/PXA RTC clean-up
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jun 5, 2015 at 2:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>>> I'm rather in a mood for a more aggressive approach :
>>>
>>>  - you fire an incremental patch to patch the 10 defconfigs on PXA architecture
>>>    (pxa27x and pxa3xx)
>>
>> Here's the breakdown of configs which enable SA1100 RTC only. Only the
>> last 6 need to change by my count:
>>
>> pxa25x
>> arch/arm/configs/h5000_defconfig
>> arch/arm/configs/xcep_defconfig
>> arch/arm/configs/viper_defconfig
>>
>> pxa255/270
>> arch/arm/configs/cm_x2xx_defconfig
>>
>> pxa270
>> arch/arm/configs/em_x270_defconfig
>> arch/arm/configs/magician_defconfig
>> arch/arm/configs/palmz72_defconfig
>> arch/arm/configs/pcm027_defconfig
>> arch/arm/configs/trizeps4_defconfig
> And arch/arm/configs/jornada720_defconfig I counted wrongly as it's sa1100.
> So I agree with your list of last 6 defconfigs.
>
>>>  - in this patch, you replace 's/CONFIG_RTC_DRV_SA1100/CONFIG_RTC_DRV_PXA/'
>>>  - you send this patch to the maintainers and me
>>>  - you explain in the commit message that from a userland perspective, nothing
>>>    changes, except that the RTC IP will change, and any dependency on a
>>
>> The IP does not change here. rtc0 is still going to be the SA1100 RTC
>> being registered first. The only change will be the addition of rtc1.
> For boards which were only using rtc-pxa.c (as mioa701 for example), they relied
> on the fact that rtc0 == pxa_rtc. Their time is stored in PXA IP. Therefore,
> each of their hwclock will end up on sa1100-rtc instead of pxa-rtc.
>
> So for these boards, ie. for all boards where only rtc-pxa.c was used, the IP
> addressed changes from a casual userspace perspective.

Okay, so this is the case where the time will be wrong.

I could remove the select of the sa1100-rtc and do an empty function
for sa1100_rtc_init. This would preserve current behavior.

>
>>>    bootloader fidling with RTC should be considered as a source of regression.
>>
>> I'm not sure that I follow.
> Let's talk about how a double boot windows + linux box works.
> The bootloader ensures that :
>  - sa1100-rtc holds the number of seconds since the OS start (think jiffies)
>  - pxa-rtc holds the wall clock time
>
> Upon each reboot, sa1100-rtc is checked to see how much time has passed. If an
> "oustanding number" is detected, for example 10 years, the firmware resets the
> data partition.
>
> Now think what will happen when this change will be commited, upon the first
> reboot after the linux kernel has change sa1100-rtc time.

That would be bad. But on these platforms, the kernel has been using
both RTCs right? Presumably on platforms only using 1 of the RTCs, the
bootloader does not touch the RTCs.

Rob

>
>>>    Moreover the first reboot will have the wrong date, until it is set.
>> Only for rtc1, right?
> Yes, right, unless the bootloader logic is ... over-engineered.
>
> All of this to say maintainers should be forwarned at least. After that, up to
> them to react.
>
> Cheers.
>
> --
> Robert

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
