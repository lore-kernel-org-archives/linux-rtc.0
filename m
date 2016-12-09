Return-Path: <rtc-linux+bncBC6YH6VTZQDRBANTVPBAKGQESPQNI4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id s81si1663272wmf.3.2016.12.09.08.19.13
        for <rtc-linux@googlegroups.com>;
        Fri, 09 Dec 2016 08:19:13 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  Alexandre Belloni <alexandre.belloni@free-electrons.com>,  rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>,  Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,  linux-arm-kernel@lists.infradead.org,  Shaker Daibes <shaker@marvell.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
	<20161208171010.29446-2-gregory.clement@free-electrons.com>
	<20161208172923.GQ26852@lunn.ch>
Date: Fri, 09 Dec 2016 17:19:07 +0100
In-Reply-To: <20161208172923.GQ26852@lunn.ch> (Andrew Lunn's message of "Thu,
	8 Dec 2016 18:29:23 +0100")
Message-ID: <8760mtf538.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Andrew,
=20
 On jeu., d=C3=A9c. 08 2016, Andrew Lunn <andrew@lunn.ch> wrote:

>> +struct str_value_to_freq {
>> +	unsigned long value;
>> +	u8 freq;
>> +} __packed;
>> +
>> +static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8=
 rtc_reg)
>> +{
>> +	unsigned long value_array[SAMPLE_NR], i, j, value;
>> +	unsigned long max =3D 0, index_max =3D SAMPLE_NR - 1;
>> +	struct str_value_to_freq value_to_freq[SAMPLE_NR];
>
> Hi Gregory
>
> This appears to be putting over 900 bytes on the stack. Is there any

Actually the structure being packed it is 500 bytes.

> danger of overflowing the stack? Would it be safer to make these
> arrays part of armada38x_rtc?

We could do this if you fear a stack overflow.

Gregory

>
>        Andrew

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
