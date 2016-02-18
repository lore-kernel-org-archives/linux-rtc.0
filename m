Return-Path: <rtc-linux+bncBCPM5SUWUYIRBD6VS63AKGQEOYWHMLI@googlegroups.com>
Received: from mail-vk0-x231.google.com (mail-vk0-x231.google.com. [2607:f8b0:400c:c05::231])
        by gmr-mx.google.com with ESMTPS id b196si248773vkf.1.2016.02.18.08.00.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2016 08:00:14 -0800 (PST)
Received: by mail-vk0-x231.google.com with SMTP id k196so48808470vka.0
        for <rtc-linux@googlegroups.com>; Thu, 18 Feb 2016 08:00:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160218150422.GT2189@piout.net>
References: <1455806972-27284-1-git-send-email-akinobu.mita@gmail.com>
	<20160218150422.GT2189@piout.net>
Date: Fri, 19 Feb 2016 01:00:14 +0900
Message-ID: <CAC5umygbXqWsTP3tWvBvfh0r_TDcVJMg+ZFB1QFr9R-26zFzyg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 1/4] rtc: ds3232: rename rtc-ds3232.c to
 rtc-ds3232-core.c for preparation
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
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

2016-02-19 0:04 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> I didn't have a close look at it yet but could the abstraction be done
> using regmap? This would nicely abstract I2C/SPI accesses.

OK.  I'll try and see if they'll fit into regmap usage.

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
