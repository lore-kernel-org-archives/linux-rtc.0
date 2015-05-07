Return-Path: <rtc-linux+bncBDF47HN2VEIRBN4GV6VAKGQEISGVGFA@googlegroups.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com. [209.85.212.170])
        by gmr-mx.google.com with ESMTPS id p12si190569wiv.1.2015.05.07.12.55.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 12:55:34 -0700 (PDT)
Received: by mail-wi0-f170.google.com with SMTP id n10so4092666wiu.1
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 12:55:34 -0700 (PDT)
Date: Thu, 7 May 2015 20:55:29 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings:
 Supply knowledge of a third supported device - clocksource
Message-ID: <20150507195529.GA28554@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507191909.GC16220@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150507191909.GC16220@x1>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

<snip>

> > >  Required properties
> > >  
> > > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > > -				  "st,stih415-lpc" "st,stid127-lpc"
> > > +- compatible 	: Must be one of: "st,stih407-lpc"
> > 
> > The same comment as the RTC DT patch, you are removing the compatibles
> > documentation for the other supported platforms like stih416-lpc.
> > AFAIK they are required in the driver to get the correct sysconfig register.
> 
> That's intentional.  I haven't yet tested any of this IP on
> STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
> sure if this IP even exists on some of the other platforms.  I will
> add them back when support is added to both driver and DTB and I've
> been able to test them.

That was kind of my point, the driver code AFAIK already contains support
for these SoC's.

I would either expect the patch to remove support from the DT docs AND the
driver, or leave it as is.

It seems odd to only change the DT docs, and become unaligned to the
code (this assumes I'm looking at the latest patchset here 
https://lkml.org/lkml/2015/3/4/1088 which includes support for these SoCs).

regards,

Peter.

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
