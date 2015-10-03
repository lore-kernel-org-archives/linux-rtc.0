Return-Path: <rtc-linux+bncBDS7HNEFSALRBVXVX6YAKGQERKQMIWA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c1si108171wiv.3.2015.10.03.08.57.10
        for <rtc-linux@googlegroups.com>;
        Sat, 03 Oct 2015 08:57:10 -0700 (PDT)
Date: Sat, 3 Oct 2015 17:57:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Wim Van Sebroeck <wim@iguana.be>, rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: stmp3xxx: unify register access macros
Message-ID: <20151003155709.GE2694@piout.net>
References: <1443817082-24370-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443817082-24370-1-git-send-email-harald@ccbib.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/10/2015 at 20:18:01 +0000, Harald Geyer wrote :
> Use STMP_OFFSET_REG_(SET|CLR) instead of defining _SET and _CLR for
> STMP3XXX_RTC_CTRL and STMP3XXX_RTC_PERSISTENT0 - no functional changes.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  drivers/rtc/rtc-stmp3xxx.c |   27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
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
