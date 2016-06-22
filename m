Return-Path: <rtc-linux+bncBAABBYV5VC5QKGQEXESHI3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id f138si198758wmf.3.2016.06.21.22.15.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 22:15:13 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
To: Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>
References: <1466492240-5528-1-git-send-email-dirk.behme@de.bosch.com>
 <1466492240-5528-2-git-send-email-dirk.behme@de.bosch.com>
 <20160621214836.GA10197@rob-hp-laptop>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Message-ID: <576A1EE0.4000603@de.bosch.com>
Date: Wed, 22 Jun 2016 07:15:12 +0200
MIME-Version: 1.0
In-Reply-To: <20160621214836.GA10197@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 21.06.2016 23:48, Rob Herring wrote:
> On Tue, Jun 21, 2016 at 08:57:18AM +0200, Dirk Behme wrote:
>> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
>>
>> ... and Epson RX8900 real time clock
>>
>> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  .../devicetree/bindings/rtc/epson,rx8900.txt        | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.txt b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>> new file mode 100644
>> index 0000000..51959de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
>> @@ -0,0 +1,21 @@
>> +Real Time Clock driver for:
>> +  - Epson RX8900
>> +  - Micro Crystal rv8803
>> +
>> +Required properties:
>> +- compatible: should be: "mc,rv8803" or "epson,rx8900"
>> +- reg : the I2C address of the device for I2C
>> +
>> +Optional properties:
>> +- epson,vdetoff : Disable Voltage Detector. Should be set if no
>> +  backup battery is used.
> 
> set to no? Looks like a boolean to me.
> 
> How about epson,vdet-disable to be consistent.
> 
>> +- trickle-diode-disable : Disable internal trickle charger diode
> 
> boolean?
> 
> Needs a vendor prefix.

This is common name used by many rtc driver without vendor prefix.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
