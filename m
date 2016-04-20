Return-Path: <rtc-linux+bncBDS7HNEFSALRBSVI324AKGQEBLZWYAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si231182wmc.3.2016.04.20.07.38.02
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Apr 2016 07:38:02 -0700 (PDT)
Date: Wed, 20 Apr 2016 16:37:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	johnstul@us.ibm.com
Subject: [rtc-linux] Re: [1/3] rtc: mc13xxx: remove UIE signaling
Message-ID: <20160420143751.GT29844@piout.net>
References: <1304523088-17039-2-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1304523088-17039-2-git-send-email-w.sang@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/05/2011 at 17:31:26 +0200, Wolfram Sang wrote :
> The RTC core handles it since 6610e08 (RTC: Rework RTC code to use
> timerqueue for events). So far, only the callbacks to the RTC core have
> been removed, but not the handlers. Do this now.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/rtc/rtc-mc13xxx.c |   23 -----------------------
>  1 files changed, 0 insertions(+), 23 deletions(-)
> 

Almost five years ago, you sent that patch...

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
