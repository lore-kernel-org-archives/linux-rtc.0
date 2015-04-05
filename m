Return-Path: <rtc-linux+bncBDS7HNEFSALRBVMXQSUQKGQEEM53M2Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i8si66526wif.1.2015.04.05.03.17.56
        for <rtc-linux@googlegroups.com>;
        Sun, 05 Apr 2015 03:17:56 -0700 (PDT)
Date: Sun, 5 Apr 2015 12:17:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Joshua Kinard <kumba@gentoo.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Use more standard kernel logging styles
Message-ID: <20150405101755.GT20669@piout.net>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
 <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
 <20150401030124.GO3849@piout.net>
 <1427858308.18175.30.camel@perches.com>
 <20150401104210.GT3849@piout.net>
 <1427904771.31790.20.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427904771.31790.20.camel@perches.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 01/04/2015 at 09:12:51 -0700, Joe Perches wrote :
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
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
