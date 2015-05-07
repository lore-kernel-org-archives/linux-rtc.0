Return-Path: <rtc-linux+bncBCH4V2OOTYHBBTGFV2VAKGQE3XDVLPQ@googlegroups.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id p9si294164wiz.3.2015.05.07.10.37.16
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 10:37:16 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id k4so142986wiz.1
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 10:37:15 -0700 (PDT)
Date: Thu, 7 May 2015 19:35:52 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Roman Yeryomin <roman@advem.lv>
cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Felix Fietkau <nbd@openwrt.org>, rtc-linux@googlegroups.com,
    Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
    Russell King <rmk+kernel@arm.linux.org.uk>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
Message-ID: <alpine.LNX.2.00.1505071935100.19877@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <20150506095312.GU4276@piout.net> <d97c3a8a29aa85c83973daf4a22ca4c9@advem.lv> <2349062.9v3Zz7HPLu@wuerfel> <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>


Hi

On Thu, 7 May 2015, Roman Yeryomin wrote:

> On 2015-05-06 22:22, Arnd Bergmann wrote:
> > On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
> > > 
> > > > Thanks to point that, I'll merge that one which seems clean enough:
> > > > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
> > > 
> > > For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital.
> > > Without that timers are broken and cpu is super slow.
> > 
> > Do you know what part of the patch is the actual bug fix? We should probably
> > merge that separately and mark it for stable backports, while the bulk of
> > that
> > patch seems to just rearrange code.
> > 
> >  Arnd
> 
> Sorry, didn't try to extract the exact lines it but I guess it's that part
> which touches the scheduler clock code.
> Because without that patch sched clock runs at 100Hz instead of 25MHz.
> I can dive into this deeper if you want, I just didn't see the need.
> 
> Regards,
> Roman
> 
> 

I've send the RTC driver for Gemini SoC upstream-

Ulli 
