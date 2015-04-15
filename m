Return-Path: <rtc-linux+bncBCUYRNXYZECRBXPBXCUQKGQEKLOLWMA@googlegroups.com>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id ec7si262965wib.3.2015.04.15.02.35.21
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Apr 2015 02:35:21 -0700 (PDT)
Date: Wed, 15 Apr 2015 10:35:10 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] Re: [PATCH 4/5] drivers/rtc/pl030: Replace deprecated
 rtc_tm_to_time() and rtc_time_to_tm()
Message-ID: <20150415093510.GW12732@n2100.arm.linux.org.uk>
References: <1429089611-29776-1-git-send-email-xlpang@126.com>
 <1429089611-29776-4-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1429089611-29776-4-git-send-email-xlpang@126.com>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, Apr 15, 2015 at 05:20:10PM +0800, Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
> which will overflow in year 2106 on 32-bit machines.
> 
> This patch solves this by:
>  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
>  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>

NAK.

How does this fix anything?  The RTC contains 32-bit registers.  Even
if you convert the struct tm to a 64-bit time, you can only write the
lowest 32-bits to the hardware.  You can onyl read the lowest 32-bits
from the hardware too.

This patch solves /nothing/.  In fact, it hides the fact that this RTC
is unable to represent dates after 2106.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

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
