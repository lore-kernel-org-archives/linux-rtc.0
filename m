Return-Path: <rtc-linux+bncBCPM5SUWUYIRBTGZ224AKGQE3AVCRTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id m62si920746vkg.3.2016.04.18.20.58.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 20:58:04 -0700 (PDT)
Received: by mail-vk0-x242.google.com with SMTP id e185so590722vkb.2
        for <rtc-linux@googlegroups.com>; Mon, 18 Apr 2016 20:58:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM2PR04MB0964532D38F8EF2C4F279034E76C0@AM2PR04MB0964.eurprd04.prod.outlook.com>
References: <AM2PR04MB09643A16272FB78B0D9FA103E76B0@AM2PR04MB0964.eurprd04.prod.outlook.com>
	<CAC5umyjh9fWigbS-xzcwpSyUgA9KkSWkMiSYur3iYWt1_2-vcA@mail.gmail.com>
	<AM2PR04MB0964532D38F8EF2C4F279034E76C0@AM2PR04MB0964.eurprd04.prod.outlook.com>
Date: Tue, 19 Apr 2016 12:58:03 +0900
Message-ID: <CAC5umyhUdHtOahu6Mw00VF4qNKfLG1citQc+FpPdhsoF4r-Qqw@mail.gmail.com>
Subject: [rtc-linux] Re: rtc ds3232 call trace in kernel
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Qianyu Gong <qianyu.gong@nxp.com>
Cc: "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-04-19 11:36 GMT+09:00 Qianyu Gong <qianyu.gong@nxp.com>:
>
>> -----Original Message-----
>> From: Akinobu Mita [mailto:akinobu.mita@gmail.com]
>> Sent: Monday, April 18, 2016 9:02 PM
>> To: Qianyu Gong <qianyu.gong@nxp.com>
>> Cc: alexandre.belloni@free-electrons.com; Mingkai Hu <mingkai.hu@nxp.com=
>;
>> rtc-linux@googlegroups.com; linux-kernel@vger.kernel.org
>> Subject: Re: rtc ds3232 call trace in kernel
>>
>> 2016-04-18 15:15 GMT+09:00 Qianyu Gong <qianyu.gong@nxp.com>:
>> > Hi Akinobu,
>> >
>> >
>> >
>> > I got an rtc call trace when booting 4.6 kernel on our board and I
>> > found it
>> >
>> > was caused by this patch:
>> >
>> >
>> >
>> > commit fc1dcb0b39dbb10d3290f2fcd6e154670f699166
>> >
>> > Author: Akinobu Mita <akinobu.mita@gmail.com>
>> >
>> > Date:   Mon Mar 7 00:27:53 2016 +0900
>> >
>> >
>> >
>> >     rtc: ds3232: use rtc->ops_lock to protect alarm operations
>> >
>> >
>> >
>> >     ds3232->mutex is used to protect for alarm operations which
>> >
>> >     need to access status and control registers.
>> >
>> >
>> >
>> >     But we can use rtc->ops_lock instead.  rtc->ops_lock is held when
>> > most
>> >
>> >     of rtc_class_ops methods are called, so we only need to explicitly
>> >
>> >     acquire it from irq handler in order to protect form concurrent
>> >
>> >     accesses.
>> >
>> >
>> >
>> >     Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> >
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com
>> >
>> >
>> >
>> > The problem is that rtc->ops_lock would be accessed in ds3232_irq()
>> >
>> > without being initialized as rtc_device_register() is called too late.
>>
>> You have already identified the root cause of this issue.
>>
>> > As I=E2=80=99m not familiar with rtc things, could I just revert the p=
atch or
>> > you already
>> >
>> > have a solution to this problem? Thanks in advance.
>>
>> Could you check if the problem is resolved by moving the call of
>> devm_rtc_device_register() from the end of ds3232_probe() to just before
>> registering irq handler?
>
> Yes. It works(no call trace now).

Thanks for testing.  Do you mind submitting your patch to
rtc-linux@googlegroups.com ?

--=20
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
