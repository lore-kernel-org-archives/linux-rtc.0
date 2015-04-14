Return-Path: <rtc-linux+bncBCC6ZWOPXENRBYNTWOUQKGQEQFN3WQI@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id ec7si57256wib.3.2015.04.14.02.12.00
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 02:12:00 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 2nd try] RTC/i.MX/DryICE: add recovery routines to
 the driver
Date: Tue, 14 Apr 2015 11:11:51 +0200
Message-Id: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2nd try, this time with a cover letter... m(

The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
monitor unit which can keep some keys. When it does its tamper detection job
and a tamper violation is detected, this RTC unit locks completely including
the real-time counter. In this state the unit is completely useless. The only
way to bring it out of this locked state is a power on reset. At the next boot
time some flags signals the tamper violation and a specific register access
sequence must be done to finaly bring this unit into life again. Until this is
done, there is no way to use it again as an RTC.
But also without any enabled tamper detection sometimes this unit tends to
lock. And in this case the same steps must be done to bring it into life
again.
The current implementation of the DryIce driver isn't able to unlock the
device successfully in the case it is locked somehow. Only a full power cycle
including *battery power* can help in this case.

The attached change set adds the required routines to be able to unlock the
DryIce unit in the case the driver detects a locked unit. This includes
unlocking it if it is locked by accident or malfunction and not by a real
tamper violation.

The last patch of this series is for reference only and should not be part
of the kernel. It just adds some code to force a locked DryIce unit to check
if the new routines are able to unlock it again. This code was required
because I had no hardware which really uses the tamper detection features of
this unit.

Comments are welcome.

jbe

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
