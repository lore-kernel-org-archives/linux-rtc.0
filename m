Return-Path: <rtc-linux+bncBCH4V2OOTYHBBB5LVOVAKGQEBWRLF6Q@googlegroups.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com. [2a00:1450:400c:c00::230])
        by gmr-mx.google.com with ESMTPS id q10si47948wiz.0.2015.05.06.20.01.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 20:01:27 -0700 (PDT)
Received: by mail-wg0-x230.google.com with SMTP id c8so3293475wgi.1
        for <rtc-linux@googlegroups.com>; Wed, 06 May 2015 20:01:27 -0700 (PDT)
Date: Thu, 7 May 2015 05:00:03 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>,
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
    rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>,
    Russell King <rmk+kernel@arm.linux.org.uk>,
    Felix Fietkau <nbd@openwrt.org>, Roman Yeryomin <roman@advem.lv>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <2694895.MomHLoCaoZ@wuerfel>
Message-ID: <alpine.LNX.2.00.1505070455130.32495@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <20150501234214.GK12076@piout.net> <2694895.MomHLoCaoZ@wuerfel>
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

Hello

On Wed, 6 May 2015, Arnd Bergmann wrote:

> On Saturday 02 May 2015 01:42:14 Alexandre Belloni wrote:
> > Hi,
> > 
> > On 14/12/2010 at 16:08:26 +0100, Hans Ulli Kroll wrote :
> > > driver for the rtc device
> > > on Cortina Systems CS3516 or StormlinkSemi SL3516 aka Gemini SoC
> > > 
> > > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> > 
> > This driver has never been merged and the platform doesn't seem to be
> > active anymore. Is there still any interest in getting this driver
> > mainlined?
> > 
> > Only tree wide cleanups happened in mach-gemini since end of 2010, the
> > listed git repository (git://git.berlios.de/gemini-board) was on berliOS
> > (closed since 2011) and the sourceforge mirror seems empty. Is there
> > still interest in keeping that platform in the mainline?
> 
> As far as I know, the platform is still used by a number of people,
> and is supported by OpenWRT. The reason we haven't seen updates is that
> Ulli has been mostly absent from upstream development, and we haven't
> had any other person step up as maintainer.
> 
> I have a patch to convert the platform to ARCH_MULTIPLATFORM, and
> the code doesn't really get in the way otherwise.
> 
> As far as I'm concerned, we should just merge all the patches from
> http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
y> 
> We should also try to find a maintainer that can respond to patches
> in a timely manner. If Ulli has time for that again, that would be great,
> otherwise I think we should find someone from OpenWRT to take over.
> 
> 	Arnd
> 

I'm back in busyness.
Currently me dev device is right next to me.
I moved some time ago and haav to find it in some 'hidden' box.


Ulli
