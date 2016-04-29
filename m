Return-Path: <rtc-linux+bncBCPM5SUWUYIRBSXHRO4QKGQEE5NJUFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qg0-x229.google.com (mail-qg0-x229.google.com. [2607:f8b0:400d:c04::229])
        by gmr-mx.google.com with ESMTPS id y205si1027017ywg.7.2016.04.28.22.40.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 22:40:26 -0700 (PDT)
Received: by mail-qg0-x229.google.com with SMTP id d90so38800470qgd.3
        for <rtc-linux@googlegroups.com>; Thu, 28 Apr 2016 22:40:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461765799.2957.4.camel@gmail.com>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
	<20160410151237.GD5377@piout.net>
	<1460301781.17404.171.camel@gmail.com>
	<20160410153855.GG5377@piout.net>
	<20160412012518.GQ3351@sirena.org.uk>
	<CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
	<20160427135012.GP3217@sirena.org.uk>
	<1461765799.2957.4.camel@gmail.com>
Date: Fri, 29 Apr 2016 14:40:25 +0900
Message-ID: <CAC5umyhLZ7Nvakf84qS73HG=H39mjYf5Lv=BPFnqZt-rTrZvCA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Sergei Ianovich <ynvich@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-04-27 23:03 GMT+09:00 Sergei Ianovich <ynvich@gmail.com>:
> On Wed, 2016-04-27 at 14:50 +0100, Mark Brown wrote:
>> On Wed, Apr 27, 2016 at 04:53:18AM +0900, Akinobu Mita wrote:
>>
>> >
>> > For the read data transfer, the address/command byte is sent on the
>> > rising edge of the first eight SCLK cycles and the read data byte
>> > is
>> > transmitted on the falling edge of the next eight SCL cycles.
>> That's an innovative and exciting hardware design :/  Definitely
>> doesn't
>> seem to correspond too closely to any SPI mode I can think of.
>
> DS1302 uses the standard MicroWire half-duplex transfer timing. The
> timing can be handled by eg. PXA270 built-in SPI controller with proper
> configuration.

Thanks for clarification about the hardware.

I feel that using spi-gpio to communicate with DS1302 is difficult
because we need to introduce different timing option to spi-gpio
(spi-bitbang) for the I/O pin which is tri-stated upon each rising
edge of SCLK, as I said in the last email.

So I think that the way like the patch 3 and 4 in this series showed
is reasonable.  And rtc-ds2404, rtc-moxart, and rtc-v3020 do something
similar.

If there is no complaint, I'll resend patch 3 and 4 with small fixes.

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
