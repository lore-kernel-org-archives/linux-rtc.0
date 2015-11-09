Return-Path: <rtc-linux+bncBD747RFBYUPBBDHKQCZAKGQEBCF7BHI@googlegroups.com>
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id el2si1171977pbb.0.2015.11.08.21.54.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Nov 2015 21:54:20 -0800 (PST)
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NXJ02U3V9QIQRD0@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 09 Nov 2015 14:54:18 +0900 (KST)
Message-id: <56403525.7000808@samsung.com>
Date: Mon, 09 Nov 2015 11:24:45 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com
Cc: k.kozlowski.k@gmail.com, lee.jones@linaro.org, broonie@kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Abraham <thomas.ab@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [rtc-linux] Re: [PATCH v5 1/4] dt-bindings: mfd: s2mps11: add
 documentation for s2mps15 PMIC
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-2-git-send-email-alim.akhtar@samsung.com>
 <20151106223339.GA22411@rob-hp-laptop> <563D6B72.9010004@samsung.com>
In-reply-to: <563D6B72.9010004@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Krzysztof,

On 11/07/2015 08:39 AM, Krzysztof Kozlowski wrote:
> W dniu 07.11.2015 o 07:33, Rob Herring pisze:
>> On Fri, Oct 30, 2015 at 11:55:31AM +0530, Alim Akhtar wrote:
>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>
>>> Add dt-binding documentation for s2mps15 PMIC device. The s2mps15 device
>>> is similar to s2mps11/14 PMIC device and has 27 LDO and 10 buck regulators.
>>> This also supports RTC and three 32.768KHz clock outputs.
>>>
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/s2mps11.txt |   21 ++++++++++++++-------
>>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/s2mps11.txt b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>>> index 890f0b0e1643..4c0543ceec25 100644
>>> --- a/Documentation/devicetree/bindings/mfd/s2mps11.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>>> @@ -1,5 +1,5 @@
>>>
>>> -* Samsung S2MPS11, S2MPS13, S2MPS14 and S2MPU02 Voltage and Current Regulator
>>> +* Samsung S2MPS11/13/14/15 and S2MPU02 Voltage and Current Regulator
>>>
>>>   The Samsung S2MPS11 is a multi-function device which includes voltage and
>>>   current regulators, RTC, charger controller and other sub-blocks. It is
>>> @@ -7,8 +7,12 @@ interfaced to the host controller using an I2C interface. Each sub-block is
>>>   addressed by the host system using different I2C slave addresses.
>>>
>>>   Required properties:
>>> -- compatible: Should be "samsung,s2mps11-pmic" or "samsung,s2mps13-pmic"
>>> -	      or "samsung,s2mps14-pmic" or "samsung,s2mpu02-pmic".
>>> +- compatible: Should be one of the following
>>> +	- "samsung,s2mps11-pmic"
>>> +	- "samsung,s2mps13-pmic"
>>> +	- "samsung,s2mps14-pmic"
>>> +	- "samsung,s2mps15-pmic"
>>> +	- "samsung,s2mpu02-pmic".
>>>   - reg: Specifies the I2C slave address of the pmic block. It should be 0x66.
>>>
>>>   Optional properties:
>>> @@ -24,7 +28,7 @@ Optional properties:
>>>     unwanted buck warm reset (setting buck voltages to default values).
>>>
>>>   Optional nodes:
>>> -- clocks: s2mps11, s2mps13 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>>> +- clocks: s2mps11, s2mps13, s2mps15 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>>
>> s5m8767 doesn't seem to be documented. Can you please fix or remove.
>
> What exactly do you have in mind?
>
> The s5m8767-clk is already documented as part of clk-s2mps11.c driver:
> Documentation/devicetree/bindings/mfd/s2mps11.txt
>
> The main s5m8767 MFD driver is documented as part of regulator driver:
> Documentation/devicetree/bindings/regulator/s5m8767-regulator.txt
>
> Yes, this may be confusing... They S2M and S5M family devices share:
>   - main mfd driver,
>   - rtc driver,
>   - clk driver.
>
> but regulator drivers are separate.
>
Indeed things are documented but in very confusing manners, e.g. 
compatible name "samsung,s5m8767-pmic" belongs to MFD not regulator.
It should have being in */bindings/mfd/s2mps11.txt
Not sure if it make sense to change it though.

> Best regards,
> Krzysztof
>
>

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
