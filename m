Return-Path: <rtc-linux+bncBD3LJCMI5QBBBLXIS7AAKGQEL32UJEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com. [2a00:1450:4010:c07::236])
        by gmr-mx.google.com with ESMTPS id x14si4336351vkd.3.2016.10.17.11.16.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2016 11:16:59 -0700 (PDT)
Received: by mail-lf0-x236.google.com with SMTP id l131so253115512lfl.2
        for <rtc-linux@googlegroups.com>; Mon, 17 Oct 2016 11:16:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161017161403.fkppk6fbvdjbp2lz@piout.net>
References: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com> <20161017161403.fkppk6fbvdjbp2lz@piout.net>
From: Mirza Krak <mirza.krak@hostmobility.com>
Date: Mon, 17 Oct 2016 20:16:58 +0200
Message-ID: <CAJ=nTstobcK7oZEhy54Meggo-iXViW98R0umFcK+2b=JmOtQAQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: pcf85063: do not register a RTC
 device if chip is not present
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mirza Krak <mirza.krak@gmail.com>, a.zummo@towertech.it, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-10-17 18:23 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 17/10/2016 at 15:53:31 +0200, Mirza Krak wrote :
>> From: Mirza Krak <mirza.krak@hostmobility.com>
>>
>> Add a sanity check to see if chip is present. If we can not communicate
>> with the chip there is no point in registering a RTC device.
>>
>
> Does it makes sense? If the device is not present, why has it been
> registered in the first place?

It made sense to me, that if you can not communicated with a chip at
probe time for whatever reason (chip fault, bus problem, "not
present") then probe should fail.

Maybe I shouldn't have used the word "present", because obviously we
expect the chip to be there, but I experienced this on a board where
the chip was not mounted and the driver produces a lot of errors
because it registered an RTC device for something that is not there.

Looking around in other rtc drivers, it is common to do a
communication check at probe time and fail probe if the communication
check does not go trough.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
Fax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************

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
