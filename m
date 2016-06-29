Return-Path: <rtc-linux+bncBAABB447ZW5QKGQET5OFLFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id a186si397173wma.1.2016.06.28.21.34.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 21:34:59 -0700 (PDT)
Subject: Re: [rtc-linux] [PATCH v2 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
 <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
 <20160624074849.GK5809@piout.net>
 <CAHQ1cqF7ByYz9stnL_-siMJHGoyuLNAPwjcWA_fWRqy7WeMF=A@mail.gmail.com>
CC: Dirk Behme <dirk.behme@de.bosch.com>, Rob Herring <robh+dt@kernel.org>,
	<rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Message-ID: <57734FF2.7070208@de.bosch.com>
Date: Wed, 29 Jun 2016 06:34:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqF7ByYz9stnL_-siMJHGoyuLNAPwjcWA_fWRqy7WeMF=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 24.06.2016 21:14, Andrey Smirnov wrote:
> On Fri, Jun 24, 2016 at 12:48 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 22/06/2016 at 08:42:20 +0200, Dirk Behme wrote :
>>> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
>>>
>>> ... and Epson RX8900 real time clock
>>>
>>> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
>>> Cc: devicetree@vger.kernel.org
>>> ---
>>>  .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.txt b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>>> new file mode 100644
>>> index 0000000..3f61e51
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>>> @@ -0,0 +1,22 @@
>>> +Real Time Clock driver for:
>>> +  - Epson RX8900
>>> +  - Micro Crystal rv8803
>>> +
>>> +Required properties:
>>> +- compatible: should be: "microcrystal,rv8803" or "epson,rx8900"
>>> +- reg : the I2C address of the device for I2C
>>> +
>>> +Optional properties:
>>> +- epson,vdet-disable : boolean, if present will disable voltage detector.
>>> +  Should be set if no backup battery is used.
>>
>> I guess we need to make that one generic. I would use
>> voltage-detection-disable.
>>
>> Andrey, can you use that one instead of
>> dallas,disable-oscillator-stop-flag ?
>>
> 
> AFAIU from reading RX8900 datasheet, it has two power rails main and a
> backup one, so setting this property disables circuitry responsible
> for detecting main power rail failure and switching to a backup one.
> 
> DS1341 has only one power rail and setting
> "dallas,disable-oscillator-stop-flag" will disable circuitry
> responsible for detection of failure of the oscillator ticking its
> internal clock.
> 
> IMHO, those functionalities don't have much in common and using the
> same property would be confusing for users of that binding on DS1341,
> but it's a boolean so there's not technical reason I couldn't.

Should i still replace epson,vdet-disable to voltage-detection-disable?

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
