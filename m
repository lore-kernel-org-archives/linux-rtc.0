Return-Path: <rtc-linux+bncBDL3F4G2ZAIBBHO546UAKGQE3ND5OSQ@googlegroups.com>
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id iw3si1333084pbd.1.2015.03.30.17.47.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 17:47:24 -0700 (PDT)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM100083WUS9Y30@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 31 Mar 2015 09:47:16 +0900 (KST)
Message-id: <5519EE93.70509@samsung.com>
Date: Tue, 31 Mar 2015 09:47:15 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, Kyungmin Park <kyungmin.park@samsung.com>
Subject: [rtc-linux] Re: [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc
 instead of exynos3250-rtc
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
 <5519DE76.4080803@samsung.com> <20150331003101.GG3849@piout.net>
In-reply-to: <20150331003101.GG3849@piout.net>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/31/2015 09:31 AM, Alexandre Belloni wrote:
> Hi,
> 
> On 31/03/2015 at 08:38:30 +0900, Chanwoo Choi wrote :
>>> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>>> index ab757b84daa7..ac2fcd6ff4b8 100644
>>> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>>> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>>> @@ -6,7 +6,8 @@ Required properties:
>>>      * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
>>>      * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
>>>      * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
>>> -    * "samsung,exynos3250-rtc" - for controllers compatible with exynos3250 rtc.
>>> +    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
>>> +                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
>>>  - reg: physical base address of the controller and length of memory mapped
>>>    region.
>>>  - interrupts: Two interrupt numbers to the cpu should be specified. First
>>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>>> index e3bfb11c6ef8..8d58b550e925 100644
>>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>>> @@ -189,7 +189,7 @@
>>>  		};
>>>  
>>>  		rtc: rtc@10070000 {
>>> -			compatible = "samsung,exynos3250-rtc";
>>> +			compatible = "samsung,s3c6410-rtc";
>>>  			reg = <0x10070000 0x100>;
>>>  			interrupts = <0 73 0>, <0 74 0>;
>>>  			interrupt-parent = <&pmu_system_controller>;
>>> diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
>>> index 5caea996e090..186cb8465683 100644
>>> --- a/arch/arm/boot/dts/exynos4415.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4415.dtsi
>>> @@ -177,7 +177,7 @@
>>>  		};
>>>  
>>>  		rtc: rtc@10070000 {
>>> -			compatible = "samsung,exynos3250-rtc";
>>> +			compatible = "samsung,s3c6410-rtc";
>>>  			reg = <0x10070000 0x100>;
>>>  			interrupts = <0 73 0>, <0 74 0>;
>>>  			status = "disabled";
>>>
>>
>> Looks good to me.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Are you absolutely sure that the exynos3250 IP is the same as the
> s3c6410 (I don't know much about the exynos family). The concern being
> that if at one point you have an errata on one or ther other, you will
> have to break the DT ABI by undoing this change.
> 
> Note that I'm fine with it, I'm just asking.

I'm sure about exynos3250 RTC is same with S3C6410 RTC.
There was little different about that pevious S3C6410 RTC
don't consider to control the 'rtc_src' clk.


But, Javier's patch[1] add the '.needs_src_clk' to control the
'rtc_src' clk. After merged this patch, there is no different part between
Exynos3250 RTC and S3C6410 RTC.

[1] 8792f7772f4f (drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data)

Thanks,
Chanwoo Choi



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
