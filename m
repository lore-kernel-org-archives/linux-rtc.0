Return-Path: <rtc-linux+bncBCPM5SUWUYIRBZVGQS2QKGQE3XGCF2Y@googlegroups.com>
Received: from mail-vk0-x232.google.com (mail-vk0-x232.google.com. [2607:f8b0:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id v71si124025vkd.3.2016.01.21.09.20.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 09:20:37 -0800 (PST)
Received: by mail-vk0-x232.google.com with SMTP id e185so26995188vkb.1
        for <rtc-linux@googlegroups.com>; Thu, 21 Jan 2016 09:20:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160120225156.GC3367@piout.net>
References: <1450310296-12153-1-git-send-email-akinobu.mita@gmail.com>
	<20160120225156.GC3367@piout.net>
Date: Fri, 22 Jan 2016 02:20:37 +0900
Message-ID: <CAC5umyiiQ84jSNiRzSyKLOGJSjpghMyJyLbkiPRapEXpz8BG0A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-ds1307: add temperature sensor
 support for ds3231
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-01-21 7:51 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> This seems very valuable. However, instead of creating a new sysfs
> interface, I think this should be using the hwmon framework. I've just
> check and it doesn't seem to be an issue to register an hwmon device
> from an other framework, some ethernet and graphic drivers are doing it.
>
> Can you try to do that?

Sounds good.  It can be done with small changes from this patch.

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
