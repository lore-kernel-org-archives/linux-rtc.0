Return-Path: <rtc-linux+bncBDCIDJ4RTAOBBAOD5SVQKGQE7WDWMGI@googlegroups.com>
Received: from shards.monkeyblade.net (shards.monkeyblade.net. [2001:4f8:3:36:211:85ff:fe63:a549])
        by gmr-mx.google.com with ESMTP id u1si614710qck.0.2015.06.12.11.14.25
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Jun 2015 11:14:25 -0700 (PDT)
Date: Fri, 12 Jun 2015 11:14:20 -0700 (PDT)
Message-Id: <20150612.111420.1641483331763914330.davem@davemloft.net>
To: alexandre.belloni@free-electrons.com
Cc: xlpang@126.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, a.zummo@towertech.it, john.stultz@linaro.org,
 arnd@arndb.de, sparclinux@vger.kernel.org, pang.xunlei@linaro.org
Subject: [rtc-linux] Re: [PATCH v3 2/3] sparc: time: Replace
 update_persistent_clock() with CONFIG_RTC_SYSTOHC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150612084238.GE3890@piout.net>
References: <1434078618-16373-1-git-send-email-xlpang@126.com>
	<1434078618-16373-2-git-send-email-xlpang@126.com>
	<20150612084238.GE3890@piout.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Fri, 12 Jun 2015 10:42:38 +0200

> I would like to take that patch as part of the series once you have
> acked it.

Sure:

Acked-by: David S. Miller <davem@davemloft.net>
