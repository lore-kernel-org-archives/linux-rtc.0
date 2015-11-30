Return-Path: <rtc-linux+bncBDS7HNEFSALRBNX76GZAKGQESZZJTCI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q80si884772wmg.0.2015.11.30.08.56.21
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 08:56:21 -0800 (PST)
Date: Mon, 30 Nov 2015 17:56:21 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Burton <paul.burton@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 16/28] rtc: m41t80: add devicetree probe support
Message-ID: <20151130165621.GG22136@piout.net>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 30/11/2015 at 16:21:41 +0000, Paul Burton wrote :
> Allow the m41t80 RTC driver to be probed via devicetree.
> 

This patch is probably unnecessary as "m41t81s" is already part of
m41t80_id[] and will be matched with "st,m41t81s" by the i2c core. See
http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L700

I actually don't know how to get people to stop submitting that kind of
patches :)

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
