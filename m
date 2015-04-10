Return-Path: <rtc-linux+bncBCT4XGV33UIBBC7JUCUQKGQEXHU3TEQ@googlegroups.com>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id iw3si390778pbd.1.2015.04.10.13.37.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2015 13:37:31 -0700 (PDT)
Date: Fri, 10 Apr 2015 13:37:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Keerthy <a0393675@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, <rtc-linux@googlegroups.com>,
 Keerthy <j-keerthy@ti.com>, <a.zummo@towertech.it>,
 <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Message-Id: <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
In-Reply-To: <5527894E.9000807@ti.com>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
	<20150324155916.cfd1b7ab442271466160283f@linux-foundation.org>
	<55234F25.5060708@ti.com>
	<5523820C.2010709@compulab.co.il>
	<5527894E.9000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, 10 Apr 2015 13:56:54 +0530 Keerthy <a0393675@ti.com> wrote:

> >>> How do we know that all systems have this external clock and that it
> >>> works OK?
> >>>
> >>
> >> AM335 and AM43X have the external clock feature which we choose using
> >> RTC_OSC_REG. I verified it works OK by seeing the RTC seconds ticking
> >> even after switching the source to the external 32k Clock.
> >
> > AFAIU, this is related to the external (outside of SoC) oscillator, right?
> > If so, there is a possibility to not assemble it on the board (at least
> > on AM335) and use the internal clock source instead.
> 
> Yes. The register 'OMAP_RTC_OSC_REG' is part of the RTC IP register set
> so i assumed that it would be with the RTCs of those particular SoCs.

I'm a bit lost here.  AFAICT there's a risk that some manufacturers
have not wired up the external oscillator, so this patch will break
those systems.  Do we know for sure that this cannot be the case?

Is there any way in which we can get all systems working properly?  If
there's no way of auto-detecting an external oscillator then perhaps a
module parameter is needed.  If so, it would be better if the driver
were to default to internal oscillator (ie: current behaviour), and the
module parameter selects the external oscillator.  This way, existing
systems are unaffected by the kernel upgrade.

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
