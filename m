Return-Path: <rtc-linux+bncBCPM5SUWUYIRBLUO764AKGQEDXHQKLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com. [2607:f8b0:400d:c04::232])
        by gmr-mx.google.com with ESMTPS id x84si9600ywd.6.2016.04.26.12.53.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 12:53:18 -0700 (PDT)
Received: by mail-qg0-x232.google.com with SMTP id d90so9387249qgd.3
        for <rtc-linux@googlegroups.com>; Tue, 26 Apr 2016 12:53:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160412012518.GQ3351@sirena.org.uk>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
	<20160410151237.GD5377@piout.net>
	<1460301781.17404.171.camel@gmail.com>
	<20160410153855.GG5377@piout.net>
	<20160412012518.GQ3351@sirena.org.uk>
Date: Wed, 27 Apr 2016 04:53:18 +0900
Message-ID: <CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sergei Ianovich <ynvich@gmail.com>, rtc-linux@googlegroups.com,
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

Sorry for the late reply.

2016-04-12 10:25 GMT+09:00 Mark Brown <broonie@kernel.org>:
> On Sun, Apr 10, 2016 at 05:38:55PM +0200, Alexandre Belloni wrote:
>> On 10/04/2016 at 18:23:01 +0300, Sergei Ianovich wrote :
>
>> > No, unfortunately. I've investigated this possibility for my platform.
>> > spi-gpio doesn't support LSB-first and 3-wire options. Adding support
>> > there is a very big change. The best way to add GPIO support is to
>> > create spi-gpio-3wire with LSB-first support.
>
>> Mark, do you have nay opinion on that?
>
> Three wire doesn't seem like it should be invasive, LSB is going to be a
> lot more invasive though it seems reasonable to just do the reversal in
> the driver for whatever device this is and let the SPI controller run
> normally.  Or we could do that in the core with a pass over the data.

I've added 3wire support to spi-gpio and added the bit reversal logic
to ds1302 driver if the spi mode is not LSB first.  But the register
read command doesn't work.  I think there is no suitable SPI mode that
can communicate with DS1302.  The reason is as follows.

For the read data transfer, the address/command byte is sent on the
rising edge of the first eight SCLK cycles and the read data byte is
transmitted on the falling edge of the next eight SCL cycles.

But in the latter read data byte data phase, I/O pin is tri-stated
upon each rising edge of SCLK.
(Please see DATA OUTPUT section and Figure 6. Timing Diagram: Read Data
Transfer in https://datasheets.maximintegrated.com/en/ds/DS1302.pdf)

So if the SPI mode 0 (CPOL=0 CPHA=0) is selected, the address/command
byte phase is ok but the read data byte is unavailable because each
bit is retrieved while SCLK is high.  Similarly there is no suitable
SPI mode for DS1302.

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
