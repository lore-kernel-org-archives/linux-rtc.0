Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751831AbdJSVYz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 19 Oct 2017 17:24:55 -0400
MIME-Version: 1.0
In-Reply-To: <20602538-2164-e85c-33b6-31c99dfa8a5e@nelint.com>
References: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
 <1507737390-27818-1-git-send-email-eric@nelint.com> <20171017200622.7xs6hiw3y43mxi2k@rob-hp-laptop>
 <20602538-2164-e85c-33b6-31c99dfa8a5e@nelint.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Oct 2017 16:24:33 -0500
Message-ID: <CAL_Jsq+QQK=NTMBwk=h0uszLW0uSiEd1fmF09USRNFM-2VgiSQ@mail.gmail.com>
Subject: Re: [PATCH V2] rtc: add support for NXP PCF85363 real-time clock
To: Eric Nelson <eric@nelint.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio.salvador@ossystems.com.br>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Oct 17, 2017 at 5:24 PM, Eric Nelson <eric@nelint.com> wrote:
> Hi Rob,
>
>
> On 10/17/2017 01:06 PM, Rob Herring wrote:
>>
>> On Wed, Oct 11, 2017 at 08:56:30AM -0700, Eric Nelson wrote:
>>>
>>> Note that alarms are not currently implemented.
>>>
>>> 64 bytes of nvmem is supported and exposed in
>>> sysfs (# is the instance number, starting with 0):
>>>
>>>         /sys/bus/nvmem/devices/pcf85363-#/nvmem
>>>
>>> Signed-off-by: Eric Nelson <eric@nelint.com>
>>> ---
>>> V2 addresses a couple of issues highlighted by Fabio Estevam
>>>      1. Kconfig updated to select REGMAP_I2C
>>>      2. Switch to of_device_id from i2c_device_id for driver matching
>>>
>>>   Documentation/devicetree/bindings/rtc/pcf85363.txt |  16 ++
>>>   drivers/rtc/Kconfig                                |  13 ++
>>>   drivers/rtc/Makefile                               |   1 +
>>>   drivers/rtc/rtc-pcf85363.c                         | 221
>>> +++++++++++++++++++++
>>>   4 files changed, 251 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>>>   create mode 100644 drivers/rtc/rtc-pcf85363.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt
>>> b/Documentation/devicetree/bindings/rtc/pcf85363.txt
>>> new file mode 100644
>>> index 0000000..5fddb9f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
>>> @@ -0,0 +1,16 @@
>>> +NXP PCF85363 Real Time Clock
>>> +============================
>>> +
>>> +Required properties:
>>> +- compatible: Should contain "nxp,pcf85363".
>>> +- reg: I2C address for chip.
>>> +
>>> +Example:
>>> +
>>> +pcf85363: pcf85363@51 {
>>> +       compatible = "nxp,pcf85363";
>>> +       reg = <0x51>;
>>> +};
>>> +
>>> +Note that alarms are not yet supported, so a specifier for
>>> +"interrupts" will be ignored.
>>
>>
>> Irrelevant to the binding. That's a driver feature (or lack of). If the
>> device has an interrupt line, you should document it. It can be optional
>> though.
>>
>
> That's what I was attempting do do in an awkward way.
>
> Since the driver doesn't support interrupts or alarms at the moment,
> I'll remove this note.
>
> The chip does have an interrupt pin, but the board I have doesn't
> have it connected.

Then just document "interrupts" as optional.

Rob
