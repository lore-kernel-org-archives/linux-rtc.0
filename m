Return-Path: <rtc-linux+bncBDEKVJM7XAHRBKMOY25AKGQEGPGAUKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l184si1856483wmg.2.2016.06.03.06.33.28
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Jun 2016 06:33:28 -0700 (PDT)
Received: from localhost (132.230.147.77.rev.sfr.net [77.147.230.132])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 373FD1C2
	for <rtc-linux@googlegroups.com>; Fri,  3 Jun 2016 15:33:26 +0200 (CEST)
Resent-Message-ID: <20160603133325.GD4594@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH] mn10300: Add missing include file to proc-init.c
Date: Fri, 03 Jun 2016 13:53:00 +0200
Message-ID: <3931924.RYdh90gyDe@wuerfel>
In-Reply-To: <1464914308-10906-1-git-send-email-linux@roeck-us.net>
References: <1464914308-10906-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thursday, June 2, 2016 5:38:28 PM CEST Guenter Roeck wrote:
> mn10300:asb2303_defconfig fails to build as follows.
> 
> arch/mn10300/proc-mn103e010/proc-init.c: In function 'processor_init':
> arch/mn10300/proc-mn103e010/proc-init.c:59:24: error: 'NR_IRQS' undeclared
> 
> Fixes: 4511118b5b44 ("char/genrtc: remove mn10300 support")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Applies to next-20160602. Feel free to merge into the original patch.
> 

Thanks for the report.

Acked-by: Arnd Bergmann <arnd@arndb.de>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
