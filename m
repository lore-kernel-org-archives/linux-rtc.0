Return-Path: <rtc-linux+bncBDKZNNNLXAHBBGHQYCWQKGQEJTDUIQI@googlegroups.com>
Received: from mail-qg0-x235.google.com (mail-qg0-x235.google.com. [2607:f8b0:400d:c04::235])
        by gmr-mx.google.com with ESMTPS id b64si128468ywc.0.2015.07.22.17.40.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 17:40:56 -0700 (PDT)
Received: by mail-qg0-x235.google.com with SMTP id 5so110925819qgy.3
        for <rtc-linux@googlegroups.com>; Wed, 22 Jul 2015 17:40:56 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150722205735.GP2853@piout.net>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
	<1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
	<CAJKOXPevQGGwCYgcH9zJ6b9c4u=XV6pO2tzne0Ub3uinDjLqvQ@mail.gmail.com>
	<20150722205735.GP2853@piout.net>
Date: Thu, 23 Jul 2015 09:40:56 +0900
Message-ID: <CAJKOXPcaw3XCR+fx-wPZztLVuoB_4VOSxzSVjdjDnoB5W=cWew@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 4/4] RTC: switch to using is_visible() to
 control sysfs attributes
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-07-23 5:57 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> (Krzysztof, be careful, Dmitry was not in copy of your maili, you should
> probably check your mailer config)

Right, I need to fix my Google group settings. Thank you for pointing
this. Probably my other emails also were not sent to Dmitry...

Best regards,
Krzysztof

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
