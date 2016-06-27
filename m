Return-Path: <rtc-linux+bncBCPM5SUWUYIRBL75YO5QKGQEQSCB7FA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com. [2607:f8b0:400d:c09::232])
        by gmr-mx.google.com with ESMTPS id v70si854094ywc.2.2016.06.27.03.23.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 03:23:43 -0700 (PDT)
Received: by mail-qk0-x232.google.com with SMTP id p10so200391235qke.3
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 03:23:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160626005534.GY5809@piout.net>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
 <20160410151237.GD5377@piout.net> <1460301781.17404.171.camel@gmail.com>
 <20160410153855.GG5377@piout.net> <20160412012518.GQ3351@sirena.org.uk>
 <CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
 <20160427135012.GP3217@sirena.org.uk> <1461765799.2957.4.camel@gmail.com>
 <CAC5umyhLZ7Nvakf84qS73HG=H39mjYf5Lv=BPFnqZt-rTrZvCA@mail.gmail.com> <20160626005534.GY5809@piout.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 27 Jun 2016 19:23:23 +0900
Message-ID: <CAC5umyizTq+widuMa2s24D2BdJHddL5a9meD1mE+64Suu11r0Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sergei Ianovich <ynvich@gmail.com>, Mark Brown <broonie@kernel.org>, rtc-linux@googlegroups.com,
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

2016-06-26 9:55 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 29/04/2016 at 14:40:25 +0900, Akinobu Mita wrote :
>> So I think that the way like the patch 3 and 4 in this series showed
>> is reasonable.  And rtc-ds2404, rtc-moxart, and rtc-v3020 do something
>> similar.
>>
>> If there is no complaint, I'll resend patch 3 and 4 with small fixes.
>
> Are you still planning to send a new version? I understand you had some
> fixes.

I'll be sending the updated patches.  The update contains white space fixes
reported by checkpatch.pl and simplification for ds1302_ops.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
