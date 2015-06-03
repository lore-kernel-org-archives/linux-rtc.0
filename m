Return-Path: <rtc-linux+bncBD62P6P6EQIOHIV2VMCRUBCGH7T6M@googlegroups.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com. [2607:f8b0:4001:c03::232])
        by gmr-mx.google.com with ESMTPS id x1si1392561igb.2.2015.06.02.22.32.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 22:32:18 -0700 (PDT)
Received: by mail-ie0-x232.google.com with SMTP id lw1so5633540iec.3
        for <rtc-linux@googlegroups.com>; Tue, 02 Jun 2015 22:32:18 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <877fs5k9ps.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home> <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jun 2015 00:31:58 -0500
Message-ID: <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
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

On Mon, May 18, 2015 at 1:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Fri, May 15, 2015 at 6:13 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Rob Herring <robh@kernel.org> writes:
>>>
>>>> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
>>>> testing on PXA27x/3xx.
>>> Hi Rob,
>>>
>>> I tested on PXA27x. It works for the boards which used pxa-rtc.
>>> For the others, their defconfig become broken, because the pxa boards with
>>> sa1100-rtc do not work anymore. And of course no .config manipulation will fix
>>> this, because PXA architecture is denied the sa1100-rtc driver.
>>
>> Ah, I didn't realize there is a mixture of use.
>>
>> I could just do something like this instead of removing
>> sa1100_device_rtc registration:
>>
>> #ifndef CONFIG_RTC_DRV_PXA
>>        &sa1100_device_rtc,
>> #else
>>         &pxa_device_rtc,
>> #endif
> I ... don't like that much, especially when you consider both rtc might be
> modules for example. I rather like that patch in pxa as they are.
>
> I'm rather in a mood for a more aggressive approach :
>
>  - you fire an incremental patch to patch the 10 defconfigs on PXA architecture
>    (pxa27x and pxa3xx)

Here's the breakdown of configs which enable SA1100 RTC only. Only the
last 6 need to change by my count:

pxa25x
arch/arm/configs/h5000_defconfig
arch/arm/configs/xcep_defconfig
arch/arm/configs/viper_defconfig

pxa255/270
arch/arm/configs/cm_x2xx_defconfig

pxa270
arch/arm/configs/em_x270_defconfig
arch/arm/configs/magician_defconfig
arch/arm/configs/palmz72_defconfig
arch/arm/configs/pcm027_defconfig
arch/arm/configs/trizeps4_defconfig

>  - in this patch, you replace 's/CONFIG_RTC_DRV_SA1100/CONFIG_RTC_DRV_PXA/'
>  - you send this patch to the maintainers and me
>  - you explain in the commit message that from a userland perspective, nothing
>    changes, except that the RTC IP will change, and any dependency on a

The IP does not change here. rtc0 is still going to be the SA1100 RTC
being registered first. The only change will be the addition of rtc1.

>    bootloader fidling with RTC should be considered as a source of regression.

I'm not sure that I follow.

>    Moreover the first reboot will have the wrong date, until it is set.

Only for rtc1, right?

Rob

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
