Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUFXZO5AKGQEBLKNKJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f142si112942wmf.3.2016.06.04.06.46.56
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 06:46:56 -0700 (PDT)
Date: Sat, 4 Jun 2016 15:46:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 1/1] rtc: ds1685: correct check of day of month
Message-ID: <20160604134655.GJ4594@piout.net>
References: <20160520223829.GA4963@piout.net>
 <1463869135-32575-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1463869135-32575-1-git-send-email-xypron.glpk@gmx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/05/2016 at 00:18:55 +0200, Heinrich Schuchardt wrote :
> The day of month is checked in ds1685_rtc_read_alarm
> and ds1685_rtc_set_alarm.
> 
> Multiple errors exist in the day of month check.
> 
> Operator ! has a higher priority than &&.
> (!(mday >= 1) && (mday <= 31)) is false for mday == 32.
> 
> When verifying the day of month the binary and the BCD mode
> have to be considered.
> 
> v2:
> 	consider ds1685_rtc_read_alarm
> 	consider rtc->bcd_mode as indicated by Alexandre Belloni
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/rtc/rtc-ds1685.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
