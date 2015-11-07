Return-Path: <rtc-linux+bncBDNNFENL2IBRB7M76WYQKGQEQ3EMJ4I@googlegroups.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com. [2607:f8b0:4001:c06::22d])
        by gmr-mx.google.com with ESMTPS id tg5si83783igb.2.2015.11.06.17.12.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 17:12:29 -0800 (PST)
Received: by mail-io0-x22d.google.com with SMTP id y8so139014232iod.1
        for <rtc-linux@googlegroups.com>; Fri, 06 Nov 2015 17:12:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151106223339.GA22411@rob-hp-laptop>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-2-git-send-email-alim.akhtar@samsung.com> <20151106223339.GA22411@rob-hp-laptop>
From: Alim Akhtar <alim.akhtar@gmail.com>
Date: Sat, 7 Nov 2015 06:41:49 +0530
Message-ID: <CAGOxZ52LkKPogBBsY1yh4U7tAVogqxh1Vh5yQa_C-ORQu0BTWw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v5 1/4] dt-bindings: mfd: s2mps11: add
 documentation for s2mps15 PMIC
To: Rob Herring <robh@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Lee Jones <lee.jones@linaro.org>, broonie@kernel.org,
	=?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Abraham <thomas.ab@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Rob,

On Sat, Nov 7, 2015 at 4:03 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 30, 2015 at 11:55:31AM +0530, Alim Akhtar wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add dt-binding documentation for s2mps15 PMIC device. The s2mps15 device
>> is similar to s2mps11/14 PMIC device and has 27 LDO and 10 buck regulators.
>> This also supports RTC and three 32.768KHz clock outputs.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/s2mps11.txt |   21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/s2mps11.txt b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> index 890f0b0e1643..4c0543ceec25 100644
>> --- a/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> +++ b/Documentation/devicetree/bindings/mfd/s2mps11.txt
>> @@ -1,5 +1,5 @@
>>
>> -* Samsung S2MPS11, S2MPS13, S2MPS14 and S2MPU02 Voltage and Current Regulator
>> +* Samsung S2MPS11/13/14/15 and S2MPU02 Voltage and Current Regulator
>>
>>  The Samsung S2MPS11 is a multi-function device which includes voltage and
>>  current regulators, RTC, charger controller and other sub-blocks. It is
>> @@ -7,8 +7,12 @@ interfaced to the host controller using an I2C interface. Each sub-block is
>>  addressed by the host system using different I2C slave addresses.
>>
>>  Required properties:
>> -- compatible: Should be "samsung,s2mps11-pmic" or "samsung,s2mps13-pmic"
>> -           or "samsung,s2mps14-pmic" or "samsung,s2mpu02-pmic".
>> +- compatible: Should be one of the following
>> +     - "samsung,s2mps11-pmic"
>> +     - "samsung,s2mps13-pmic"
>> +     - "samsung,s2mps14-pmic"
>> +     - "samsung,s2mps15-pmic"
>> +     - "samsung,s2mpu02-pmic".
>>  - reg: Specifies the I2C slave address of the pmic block. It should be 0x66.
>>
>>  Optional properties:
>> @@ -24,7 +28,7 @@ Optional properties:
>>    unwanted buck warm reset (setting buck voltages to default values).
>>
>>  Optional nodes:
>> -- clocks: s2mps11, s2mps13 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>> +- clocks: s2mps11, s2mps13, s2mps15 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>
> s5m8767 doesn't seem to be documented. Can you please fix or remove.
>
Ok, will take a look.

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim

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
