Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXOQ3XBQKGQE2XMHGVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 133si160714wmj.1.2017.01.12.03.28.28
        for <rtc-linux@googlegroups.com>;
        Thu, 12 Jan 2017 03:28:28 -0800 (PST)
Date: Thu, 12 Jan 2017 12:28:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: hide maybe-uninitialized warning
Message-ID: <20170112112818.q2gxfgw7j3alo2ln@piout.net>
References: <20170111145112.722743-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170111145112.722743-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On 11/01/2017 at 15:50:31 +0100, Arnd Bergmann wrote :
> The function is too complicated for gcc to realize that this variable
> does eventually get initialized, causing a harmless warning:
> 
> drivers/rtc/rtc-armada38x.c: In function 'read_rtc_register_wa':
> drivers/rtc/rtc-armada38x.c:131:25: warning: 'index_max' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This adds an explicit initializion at the start of the function.
> I generally try to avoid that, but it seems appropriate here,
> as we start out with max=0 as well.
> 
> Fixes: 61cffa2438e3 ("rtc: armada38x: Follow the new recommendation for errata implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually, I fixed that one directly in the commit yesterday as it has
been reported to me multiple times already.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
