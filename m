Return-Path: <rtc-linux+bncBDKOBWPM5ABRBKGBTO5QKGQEUWXTPTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id h76si450615ywc.7.2016.06.19.11.12.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 11:12:56 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id f75so172778ywb.3
        for <rtc-linux@googlegroups.com>; Sun, 19 Jun 2016 11:12:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160619142934.GA8522@rob-hp-laptop>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
 <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com> <20160619142934.GA8522@rob-hp-laptop>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sun, 19 Jun 2016 11:12:55 -0700
Message-ID: <CAHQ1cqFfFpLmMMr9itinha9rotG7Btr9UmWbO2_0VWxX_HeG1g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 03/13] RTC: ds1307: Add DS1341 specific
 power-saving options
To: Rob Herring <robh@kernel.org>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Jun 19, 2016 at 7:29 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 14, 2016 at 10:59:29PM -0700, Andrey Smirnov wrote:
>> Add DS1341 specific power-saving options that allow to disable certain
>> functional aspects of the chip in order to minimize its power
>> consumption.
>
> This description doesn't match that you are adding a new binding. It is
> preferred that bindings are a separate patch.

OK, will split this patch into two in v2.

>
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/dallas,ds1341.txt      | 23 ++++++++++++++++++
>>  drivers/rtc/rtc-ds1307.c                           | 28 ++++++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
>> new file mode 100644
>> index 0000000..b8be7a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
>> @@ -0,0 +1,23 @@
>> +* Dallas DS1341              I2C Serial Real-Time Clock
>> +
>> +Required properties:
>> +
>> +- compatible: Should contain "dallas,ds1341".
>> +
>> +- reg: I2C address for chip
>> +
>> +Optional properties:
>> +
>> +- disable-oscillator-stop-flag : Configure chip to disable oscillator
>> +  fault detection circuitry
>> +
>> +- enable-glitch-filter : Configure chip to enable crystal oscillator
>> +  output glitch filtering
>
> What determines setting these properties or not?

Setting those properties allows drastically reduce RTC's power
consumption at the expense of reliability and quality of service. In
my use case, DS1341 is powered by a supercap and enabling those two
setting allows to increase holdup from less than a day do 2+ weeks.

>
> They should have vendor prefix and be explicit that they are boolean.

I was trying to be consistent with ds1339 and ds1390 bindings which do
not have vendor prefixes. Will fix in v2.

Thank you,
Andrey Smirnov

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
