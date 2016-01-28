Return-Path: <rtc-linux+bncBDKZNNNLXAHBBZPQU22QKGQEJZAWJ2A@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id tn7si1299698pac.1.2016.01.27.22.42.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 22:42:45 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1N00I31HB5EMA0@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 28 Jan 2016 06:42:41 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V5 5/5] regulator: max77620: add regulator
 driver for max77620/max20024
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
 <1453903808-29788-6-git-send-email-ldewangan@nvidia.com>
 <56A99130.1070904@samsung.com> <56A9B41C.4070607@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A9B85C.2050206@samsung.com>
Date: Thu, 28 Jan 2016 15:42:36 +0900
MIME-version: 1.0
In-reply-to: <56A9B41C.4070607@nvidia.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28.01.2016 15:24, Laxman Dewangan wrote:
> 
> On Thursday 28 January 2016 09:25 AM, Krzysztof Kozlowski wrote:
>> On 27.01.2016 23:10, Laxman Dewangan wrote:
>>> MAXIM Semiconductor's PMIC, MAX77620 and MAX20024 have the
>>> multiple DCDC and LDOs. This supplies the power to different
>>> components of the system.
>>> Also these rails has configuration for ramp time, flexible
>>> power sequence, slew rate etc.
>>>
>>> Add regulator driver to access these rails via regulator APIs.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
>>> ---
>>> Changes from V1:
>>> - Cleanup code based on comment received on mfd/rtc.
>>> - Avoid duplication on error message.
>>>
>>> Changes form V2:
>>> - Run coccicheck and checkpatch in strict mode for the alignment.
>>> - Refactor Regulator driver to use core API for DT parsing.
>>> - Update based on API changes.
>>>
>>> Changes from V3:
>>> - Change all sys initcall to module driver.
>>> - change the max77620_read argument to unisgned int from u8.
>>>
>>> Changes from V4:
>>> - Added DT binding document as
>>> devicetree/bindings/regulator/regulator-max77620.txt
>>> - Detail out properties.
>> What does it mean "Detail out properties"? What have changed>
> 
> Based on review comment from Linus W, I added more description on the
> properties.

Ah, ok.

>> I already reviewed the patchset but because of adding bindings here, you
>> could not add my reviewed-by tag (which makes my effort not tracked...).
> Yaah, This patch include the dt binding and so wanted your review again.
> This si only reason to not add reviewed-by.
> 
> Now I am going to separate out DT binding and driver,  I will add
> reviewed-by tag for you in driver file.

Yeah, but the driver nor the bindings do not change so it really does
not need my additional review.

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
