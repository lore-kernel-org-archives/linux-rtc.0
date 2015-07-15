Return-Path: <rtc-linux+bncBAABBB47S6WQKGQEFYV72CA@googlegroups.com>
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id fv10si274806pac.2.2015.07.14.20.12.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 20:12:07 -0700 (PDT)
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NRI02U0QE85OX40@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 15 Jul 2015 12:12:05 +0900 (KST)
Date: Wed, 15 Jul 2015 03:12:05 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
Subject: [rtc-linux] Re: [PATCH 1/1] drivers/rtc/rtc-bq32k.c: remove redundant check
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
 PANKAJ MISHRA <pankaj.m@samsung.com>
Reply-to: rtc-linux@googlegroups.com
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
Message-id: <948552175.761871436929924254.JavaMail.weblogic@ep2mlwas06a>
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello
>> removing below static analysis error:-

>What tool did you use?

Its coverity analysis (static analysis) tool.
Or you can also use cppcheck tool.

>> (error) Possible null pointer dereference: client
>> 
>> if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>> 							^^^^^^^
>> Error comes beacause client is dereferenced before NULL check.
>> So probabily NULL this check is not required.
>> 
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>> ---
>>  drivers/rtc/rtc-bq32k.c |    2 +-
>Applied, to rtc-next.

Thanks.
Maninder
............

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
