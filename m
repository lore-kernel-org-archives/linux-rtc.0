Return-Path: <rtc-linux+bncBDS7HNEFSALRBRPVTCVAKGQEZZEXVJI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si234695wiz.0.2015.05.03.08.12.04
        for <rtc-linux@googlegroups.com>;
        Sun, 03 May 2015 08:12:04 -0700 (PDT)
Date: Sun, 3 May 2015 17:12:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	kernel@pengutronix.de, Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCHv2] RTC/i.MX/DryICE: add recovery routines to
 the driver
Message-ID: <20150503151203.GY12076@piout.net>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
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

On 27/04/2015 at 15:59:46 +0200, Juergen Borleis wrote :
> The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
> monitor unit which can keep some (secret) keys. When it does its tamper
> detection job and a security violation is detected, the whole DryICE unit
> including the real-time counter locks completely. In this state the whole unit
> is completely useless. The only way to bring it out of this locked state is a
> power cylce with a POR (most of the case) or additionally a battery power
> cycle which includes the loss of the secret keys.
> At the next boot time some flags signals the security violation and a specific
> register access sequence must be done to finaly bring this unit into life
> again. Until this is done, there is no way to use it again as an RTC.
> 
> But also without any enabled tamper detection sometimes this unit tends to
> lock. And in this case the same steps must be done to bring it into life
> again.
> 
> The current implementation of the DryIce driver isn't able to unlock the
> device successfully in the case it is locked somehow. Only a full power cycle
> including *battery power* can help in this case.
> 
> The attached change set adds the required routines to be able to unlock the
> DryIce unit in the case the driver detects a locked unit. This includes
> unlocking it if it is locked by accident or malfunction and not by a real
> security violation.
> 
> The last patch of this series is for reference only and should not be part
> of the kernel. It just adds some code to force a locked DryIce unit to check
> if the new routines are able to unlock it again. This code was required
> because I had no hardware which really uses the tamper detection features of
> this unit.
> 
> This is the 2nd version of the patch series. Hopefully I addressed all comments
> from Alexandre.
> 
> In this version I added a new patch which replaces all __raw* register functions
> as recommended by Alexandre.
> 
> Comments are welcome.
> 

I've applied 1-5 after fixing a few parenthesis alignments you missed.
I've also reworked the commit subject prefix to the more concise "rtc:
imdi:" and you forgot the commit message in patch 2, you can check it
here:
https://github.com/alexandrebelloni/linux/commit/eff76de33878687dc1877f40ac2cc34794f499e0

Tell me if you have any objection.

BTW, I guess your email address has been recycled as patchwork recognize
it has belonging to Juergen Beisert ;)


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
