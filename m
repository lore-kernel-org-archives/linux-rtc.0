Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMGC5GUAKGQEJOZOESI@googlegroups.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com. [2607:f8b0:4002:c07::22c])
        by gmr-mx.google.com with ESMTPS id 40si537083yho.6.2015.03.31.01.56.16
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 01:56:16 -0700 (PDT)
Received: by ykek76 with SMTP id k76so4090616yke.0
        for <rtc-linux@googlegroups.com>; Tue, 31 Mar 2015 01:56:16 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150331081204.GH3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
	<1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
	<5519DE76.4080803@samsung.com>
	<20150331003101.GG3849@piout.net>
	<5519EE93.70509@samsung.com>
	<20150331081204.GH3849@piout.net>
Date: Tue, 31 Mar 2015 10:56:15 +0200
Message-ID: <CAJKOXPc7px9Aq4b6DRyKnNf=uREYzO0L41ANzKXB3n9HTzV9oQ@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc
 instead of exynos3250-rtc
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-03-31 10:12 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 31/03/2015 at 09:47:15 +0900, Chanwoo Choi wrote :
>> > Are you absolutely sure that the exynos3250 IP is the same as the
>> > s3c6410 (I don't know much about the exynos family). The concern being
>> > that if at one point you have an errata on one or ther other, you will
>> > have to break the DT ABI by undoing this change.
>> >
>> > Note that I'm fine with it, I'm just asking.
>>
>> I'm sure about exynos3250 RTC is same with S3C6410 RTC.
>> There was little different about that pevious S3C6410 RTC
>> don't consider to control the 'rtc_src' clk.
>>
>>
>> But, Javier's patch[1] add the '.needs_src_clk' to control the
>> 'rtc_src' clk. After merged this patch, there is no different part between
>> Exynos3250 RTC and S3C6410 RTC.
>>
>> [1] 8792f7772f4f (drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data)
>>
>
> Yes, I saw that the software was handling both the same way, I was
> asking about the hardware side.

The hardware is exactly the same. Or maybe I should say: I could not
find any differences.

Best regards,
Krzysztof

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
