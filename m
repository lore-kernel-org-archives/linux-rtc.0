Return-Path: <rtc-linux+bncBDS7HNEFSALRBS5446VQKGQE27MUDHQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ha2si480797wib.1.2015.06.11.12.15.23
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Jun 2015 12:15:23 -0700 (PDT)
Date: Thu, 11 Jun 2015 21:15:22 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] Re: [PATCH v2 2/4] sparc: time: Replace
 update_persistent_clock() with CONFIG_RTC_SYSTOHC
Message-ID: <20150611191522.GP5222@piout.net>
References: <1433236477-1724-1-git-send-email-xlpang@126.com>
 <1433236477-1724-2-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433236477-1724-2-git-send-email-xlpang@126.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/06/2015 at 17:14:35 +0800, Xunlei Pang wrote :
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> On Sparc systems, update_persistent_clock() uses RTC drivers to do
> the job, it makes more sense to hand it over to CONFIG_RTC_SYSTOHC.
> 
> In the long run, all the update_persistent_clock() should migrate to
> proper class RTC drivers if any and use CONFIG_RTC_SYSTOHC instead.
> 
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>

I could take that patch but you should probably get an ack for the sparc
maintainer:
"David S. Miller" <davem@davemloft.net> (maintainer:SPARC + UltraSPAR...,commit_signer:2/4=50%)
sparclinux@vger.kernel.org (open list:SPARC + UltraSPAR...)

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
