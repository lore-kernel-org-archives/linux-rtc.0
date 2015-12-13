Return-Path: <rtc-linux+bncBDS7HNEFSALRB37PWWZQKGQEDCXR5OY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s6si366612wmf.1.2015.12.13.05.51.42
        for <rtc-linux@googlegroups.com>;
        Sun, 13 Dec 2015 05:51:42 -0800 (PST)
Date: Sun, 13 Dec 2015 14:51:31 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: fix overflow and incorrect
 calculation in rtc_time64_to_tm
Message-ID: <20151213135131.GC11209@piout.net>
References: <1449201674-24344-1-git-send-email-sasha.levin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449201674-24344-1-git-send-email-sasha.levin@oracle.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/12/2015 at 23:01:14 -0500, Sasha Levin wrote :
> At some point after humans go extinct and robots cotrol the world, dividing
> he time64_t by 86400 to extract the days will overflow a 32bit integer,
> leading to incorrect conversion into rtc_time in rtc_time64_to_tm().
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  drivers/rtc/rtc-lib.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
Applied, thanks.

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
