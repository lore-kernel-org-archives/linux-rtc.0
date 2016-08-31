Return-Path: <rtc-linux+bncBDJN3U5DZYHRBCUWTS7AKGQEAFAXC2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id ph9si293568pac.1.2016.08.31.09.51.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 09:51:22 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id cf3so2893150pad.2
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 09:51:22 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: changed raw spi calls to register map calls
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <57C5E569.4050605@gmail.com>
 <20160830214837.4muxmee3mueimhg4@piout.net>
From: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 a.zummo@towertech.it
Message-ID: <57C70B06.7030207@gmail.com>
Date: Wed, 31 Aug 2016 22:21:18 +0530
MIME-Version: 1.0
In-Reply-To: <20160830214837.4muxmee3mueimhg4@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On Wednesday 31 August 2016 03:18 AM, Alexandre Belloni wrote:
> Hi,
> 
> Please fix the subject, this patch is ds1347 specific.
> 
Yes I will fix the subject

> On 31/08/2016 at 01:28:33 +0530, RAGHAVENDRA GANIGA wrote :
>> From 2ec82b6c9b99647e31d26c4c828dc7c51af8a633 Mon Sep 17 00:00:00 2001
>> From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
>> Date: Wed, 31 Aug 2016 01:13:30 +0530
>> Subject: [PATCH] rtc: changed raw spi calls to register map calls
>>
>> This patch changes calls of spi read write calls to register map
>> read and write calls
>>
> 
> Can you explain why you need that change? I'm not sure what you gain
> from it (it makes the driver and the kernel bigger).
> 
Regmaps abstract layer are a better way of accessing register through 
spi interface rather than accessing directly through SPI layer

>>  	/* year in linux is from 1900 i.e in range of 100
>> -	in rtc it is from 00 to 99 */
>> +	 * in rtc it is from 00 to 99
>> +	 */
> 
> Unrelated change.
> 
> 
will have a seperate patch for this checkpatch.pl fix

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
