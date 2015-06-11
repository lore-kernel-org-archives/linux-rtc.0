Return-Path: <rtc-linux+bncBDS7HNEFSALRBPN646VQKGQEY3YPEBI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si1689wiz.0.2015.06.11.12.19.24
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Jun 2015 12:19:24 -0700 (PDT)
Date: Thu, 11 Jun 2015 21:19:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] Re: [PATCH v2 4/4] cris: time: Cleanup of persistent
 clock stuff
Message-ID: <20150611191923.GQ5222@piout.net>
References: <1433236477-1724-1-git-send-email-xlpang@126.com>
 <1433236477-1724-4-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433236477-1724-4-git-send-email-xlpang@126.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/06/2015 at 17:14:37 +0800, Xunlei Pang wrote :
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> - Remove update_persistent_clock(), as it does nothing now.
> - Remove read_persistent_clock(), let it fall back to the weak version.
> 
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>

That patch doesn't seem to have any dependencies, it should go through
the cris maintainers tree:
Mikael Starvik <starvik@axis.com> (maintainer:CRIS PORT)
Jesper Nilsson <jesper.nilsson@axis.com> (maintainer:CRIS PORT)
linux-cris-kernel@axis.com (open list:CRIS PORT)

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
