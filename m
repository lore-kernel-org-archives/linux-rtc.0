Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:47480 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764573AbdJQWYi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Oct 2017 18:24:38 -0400
Received: by mail-pg0-f51.google.com with SMTP id r25so2564673pgn.4
        for <linux-rtc@vger.kernel.org>; Tue, 17 Oct 2017 15:24:38 -0700 (PDT)
Subject: Re: [PATCH V2] rtc: add support for NXP PCF85363 real-time clock
To: Rob Herring <robh@kernel.org>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br,
        festevam@gmail.com
References: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
 <1507737390-27818-1-git-send-email-eric@nelint.com>
 <20171017200622.7xs6hiw3y43mxi2k@rob-hp-laptop>
From: Eric Nelson <eric@nelint.com>
Message-ID: <20602538-2164-e85c-33b6-31c99dfa8a5e@nelint.com>
Date: Tue, 17 Oct 2017 15:24:35 -0700
MIME-Version: 1.0
In-Reply-To: <20171017200622.7xs6hiw3y43mxi2k@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Rob,

On 10/17/2017 01:06 PM, Rob Herring wrote:
> On Wed, Oct 11, 2017 at 08:56:30AM -0700, Eric Nelson wrote:
>> Note that alarms are not currently implemented.
>>
>> 64 bytes of nvmem is supported and exposed in
>> sysfs (# is the instance number, starting with 0):
>>
>> 	/sys/bus/nvmem/devices/pcf85363-#/nvmem
>>
>> Signed-off-by: Eric Nelson <eric@nelint.com>
>> ---
>> V2 addresses a couple of issues highlighted by Fabio Estevam
>>      1. Kconfig updated to select REGMAP_I2C
>>      2. Switch to of_device_id from i2c_device_id for driver matching
>>
>>   Documentation/devicetree/bindings/rtc/pcf85363.txt |  16 ++
>>   drivers/rtc/Kconfig                                |  13 ++
>>   drivers/rtc/Makefile                               |   1 +
>>   drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
>>   4 files changed, 251 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>>   create mode 100644 drivers/rtc/rtc-pcf85363.c
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
>> new file mode 100644
>> index 0000000..5fddb9f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
>> @@ -0,0 +1,16 @@
>> +NXP PCF85363 Real Time Clock
>> +============================
>> +
>> +Required properties:
>> +- compatible: Should contain "nxp,pcf85363".
>> +- reg: I2C address for chip.
>> +
>> +Example:
>> +
>> +pcf85363: pcf85363@51 {
>> +	compatible = "nxp,pcf85363";
>> +	reg = <0x51>;
>> +};
>> +
>> +Note that alarms are not yet supported, so a specifier for
>> +"interrupts" will be ignored.
> 
> Irrelevant to the binding. That's a driver feature (or lack of). If the
> device has an interrupt line, you should document it. It can be optional
> though.
> 

That's what I was attempting do do in an awkward way.

Since the driver doesn't support interrupts or alarms at the moment,
I'll remove this note.

The chip does have an interrupt pin, but the board I have doesn't
have it connected.

Regards,


Eric
