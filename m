Return-Path: <rtc-linux+bncBD747RFBYUPBB7WDXCYQKGQER73FZVY@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id pe1si3501633pac.2.2015.10.26.05.52.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Oct 2015 05:52:14 -0700 (PDT)
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWT014Q2VR18P20@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 26 Oct 2015 21:52:13 +0900 (KST)
Message-id: <562E1FB5.1000600@samsung.com>
Date: Mon, 26 Oct 2015 18:12:29 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, k.kozlowski@samsung.com, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Thomas Abraham <thomas.ab@samsung.com>, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 1/5] dt-bindings: mfd: s2mps11: add
 documentation for s2mps15 PMIC
References: <1445855803-26973-1-git-send-email-alim.akhtar@samsung.com>
 <1445855803-26973-2-git-send-email-alim.akhtar@samsung.com>
 <20151026110924.GI597@x1>
In-reply-to: <20151026110924.GI597@x1>
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



On 10/26/2015 04:39 PM, Lee Jones wrote:
> On Mon, 26 Oct 2015, Alim Akhtar wrote:
>
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add dt-binding documentation for s2mps15 PMIC device. The s2mps15 device
>> is similar to s2mps11/14 PMIC device and has 27 LDO and 10 buck regulators.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/s2mps11.txt |   23 ++++++++++++++-------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> Nothing to controversial here.
>
> For my own reference:
>    Acked-by: Lee Jones <lee.jones@linaro.org>
>
Thanks, will send v3 of this series.

>> diff --git a/Documentation/devicetree/bindings/mfd/s2mps11.txt b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> index 890f0b0e1643..c0427c9d0886 100644
>> --- a/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> +++ b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> @@ -1,5 +1,5 @@
>>
>> -* Samsung S2MPS11, S2MPS13, S2MPS14 and S2MPU02 Voltage and Current Regulator
>> +* Samsung S2MPS11/13/14/15 and S2MPU02 Voltage and Current Regulator
>>
>>   The Samsung S2MPS11 is a multi-function device which includes voltage and
>>   current regulators, RTC, charger controller and other sub-blocks. It is
>> @@ -7,8 +7,12 @@ interfaced to the host controller using an I2C interface. Each sub-block is
>>   addressed by the host system using different I2C slave addresses.
>>
>>   Required properties:
>> -- compatible: Should be "samsung,s2mps11-pmic" or "samsung,s2mps13-pmic"
>> -	      or "samsung,s2mps14-pmic" or "samsung,s2mpu02-pmic".
>> +- compatible: Should be one of the following
>> +	- "samsung,s2mps11-pmic"
>> +	- "samsung,s2mps13-pmic"
>> +	- "samsung,s2mps14-pmic"
>> +	- "samsung,s2mps15-pmic"
>> +	- "samsung,s2mpu02-pmic".
>>   - reg: Specifies the I2C slave address of the pmic block. It should be 0x66.
>>
>>   Optional properties:
>> @@ -24,7 +28,7 @@ Optional properties:
>>     unwanted buck warm reset (setting buck voltages to default values).
>>
>>   Optional nodes:
>> -- clocks: s2mps11, s2mps13 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>> +- clocks: s2mps11, s2mps13, s2mps15 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>>     KHz outputs, so to register these as clocks with common clock framework
>>     instantiate a sub-node named "clocks". It uses the common clock binding
>>     documented in :
>> @@ -37,12 +41,13 @@ Optional nodes:
>>       the clock which they consume.
>>       Clock               ID           Devices
>>       ----------------------------------------------------------
>> -    32KhzAP		0            S2MPS11, S2MPS13, S2MPS14, S5M8767
>> -    32KhzCP		1            S2MPS11, S2MPS13, S5M8767
>> -    32KhzBT		2            S2MPS11, S2MPS13, S2MPS14, S5M8767
>> +    32KhzAP		0            S2MPS11, S2MPS13, S2MPS14, S2MPS15, S5M8767
>> +    32KhzCP		1            S2MPS11, S2MPS13, S2MPS15, S5M8767
>> +    32KhzBT		2            S2MPS11, S2MPS13, S2MPS14, S2MPS15, S5M8767
>>
>>     - compatible: Should be one of: "samsung,s2mps11-clk", "samsung,s2mps13-clk",
>> -		"samsung,s2mps14-clk", "samsung,s5m8767-clk"
>> +		"samsung,s2mps14-clk", "samsung,s2mps15-clk",
>> +		"samsung,s5m8767-clk"
>>
>>   - regulators: The regulators of s2mps11 that have to be instantiated should be
>>   included in a sub-node named 'regulators'. Regulator nodes included in this
>> @@ -90,6 +95,7 @@ as per the datasheet of s2mps11.
>>   			- S2MPS11: 1 to 38
>>   			- S2MPS13: 1 to 40
>>   			- S2MPS14: 1 to 25
>> +			- S2MPS15: 1 to 27
>>   			- S2MPU02: 1 to 28
>>   		  - Example: LDO1, LDO2, LDO28
>>   	- BUCKn
>> @@ -97,6 +103,7 @@ as per the datasheet of s2mps11.
>>   			- S2MPS11: 1 to 10
>>   			- S2MPS13: 1 to 10
>>   			- S2MPS14: 1 to 5
>> +			- S2MPS15: 1 to 10
>>   			- S2MPU02: 1 to 7
>>   		  - Example: BUCK1, BUCK2, BUCK9
>>
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
