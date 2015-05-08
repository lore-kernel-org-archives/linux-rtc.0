Return-Path: <rtc-linux+bncBDEKVJM7XAHRBGN7WOVAKGQEKW5DK6A@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.130])
        by gmr-mx.google.com with ESMTPS id q10si328662wiz.0.2015.05.08.09.08.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 09:08:57 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Roman Yeryomin <roman@advem.lv>, Felix Fietkau <nbd@openwrt.org>, rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
Date: Fri, 08 May 2015 18:08:16 +0200
Message-ID: <2131951.l0j0CIttAZ@wuerfel>
In-Reply-To: <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <2349062.9v3Zz7HPLu@wuerfel> <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
MIME-Version: 1.0
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

On Thursday 07 May 2015 12:03:25 Roman Yeryomin wrote:
> On 2015-05-06 22:22, Arnd Bergmann wrote:
> > On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
> >> 
> >> > Thanks to point that, I'll merge that one which seems clean enough:
> >> > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
> >> 
> >> For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital.
> >> Without that timers are broken and cpu is super slow.
> > 
> > Do you know what part of the patch is the actual bug fix? We should 
> > probably
> > merge that separately and mark it for stable backports, while the bulk 
> > of that
> > patch seems to just rearrange code.
> > 
> >       Arnd
> 
> Sorry, didn't try to extract the exact lines it but I guess it's that 
> part which touches the scheduler clock code.
> Because without that patch sched clock runs at 100Hz instead of 25MHz.
> I can dive into this deeper if you want, I just didn't see the need.

I think that would be helpful, yes.

	Arnd

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
