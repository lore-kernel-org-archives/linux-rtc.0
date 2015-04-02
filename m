Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHPI6OUAKGQEYBTN2LI@googlegroups.com>
Received: from mail-yh0-x232.google.com (mail-yh0-x232.google.com. [2607:f8b0:4002:c01::232])
        by gmr-mx.google.com with ESMTPS id d31si205995yhb.1.2015.04.02.00.47.40
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 00:47:40 -0700 (PDT)
Received: by yhpt93 with SMTP id t93so18922444yhp.0
        for <rtc-linux@googlegroups.com>; Thu, 02 Apr 2015 00:47:40 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1427904771.31790.20.camel@perches.com>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
	<1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
	<20150401030124.GO3849@piout.net>
	<1427858308.18175.30.camel@perches.com>
	<20150401104210.GT3849@piout.net>
	<1427904771.31790.20.camel@perches.com>
Date: Thu, 2 Apr 2015 09:47:40 +0200
Message-ID: <CAJKOXPeW7ShWWeRXkgCD0Nih3A6yOEnvNyhaj5XZSyRYWRzMyw@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH] rtc: Use more standard kernel logging styles
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, Joshua Kinard <kumba@gentoo.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-04-01 18:12 GMT+02:00 Joe Perches <joe@perches.com>:
> Neaten the logging a bit by adding #define pr_fmt
>
> Miscellanea:
>
> o Remove __FILE__/__func__ uses
> o Coalesce formats adding missing spaces
> o Align arguments
> o (rtc-cmos) Integrated 2 consecutive messages
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

[Tested on Arndale Octa (rtc-s5m) and Trats2 (rtc-max77686)]
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
