Return-Path: <rtc-linux+bncBDEKVJM7XAHRBO5SVSVAKGQE72TDAGI@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.10])
        by gmr-mx.google.com with ESMTPS id g5si214157wix.1.2015.05.07.00.50.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 00:50:19 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Felix Fietkau <nbd@openwrt.org>, Roman Yeryomin <roman@advem.lv>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
Date: Thu, 07 May 2015 09:49:36 +0200
Message-ID: <5043733.xO9lSCKvly@wuerfel>
In-Reply-To: <alpine.LNX.2.00.1505070455130.32495@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <2694895.MomHLoCaoZ@wuerfel> <alpine.LNX.2.00.1505070455130.32495@T520.local>
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

On Thursday 07 May 2015 05:00:03 Hans Ulli Kroll wrote:
> On Wed, 6 May 2015, Arnd Bergmann wrote:
> > As far as I'm concerned, we should just merge all the patches from
> > http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
> > 
> > We should also try to find a maintainer that can respond to patches
> > in a timely manner. If Ulli has time for that again, that would be great,
> > otherwise I think we should find someone from OpenWRT to take over.
> 
> I'm back in busyness.
> Currently me dev device is right next to me.
> I moved some time ago and haav to find it in some 'hidden' box.

Awesome, welcome back!

Are you able to look at the patches I mentioned above and submit them
to arm@kernel.org, cc linux-arm-kernel@lists.infradead.org with proper
patch descriptions?

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
