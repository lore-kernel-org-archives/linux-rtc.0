Return-Path: <rtc-linux+bncBAABBAX7VCVAKGQEMRGNWSY@googlegroups.com>
Received: from mail.pbx.lv ([213.175.90.140])
        by gmr-mx.google.com with ESMTP id bm9si1533584lbb.0.2015.05.06.09.21.21
        for <rtc-linux@googlegroups.com>;
        Wed, 06 May 2015 09:21:21 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Wed, 06 May 2015 19:21:21 +0300
From: Roman Yeryomin <roman@advem.lv>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Ulli Kroll
 <ulli.kroll@googlemail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Linus Walleij
 <linus.walleij@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>,
 Felix Fietkau <nbd@openwrt.org>
In-Reply-To: <20150506095312.GU4276@piout.net>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <20150501234214.GK12076@piout.net> <2694895.MomHLoCaoZ@wuerfel>
 <20150506095312.GU4276@piout.net>
Message-ID: <d97c3a8a29aa85c83973daf4a22ca4c9@advem.lv>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 2015-05-06 12:53, Alexandre Belloni wrote:
> On 06/05/2015 at 11:39:58 +0200, Arnd Bergmann wrote :
>> On Saturday 02 May 2015 01:42:14 Alexandre Belloni wrote:
>> > Hi,
>> >
>> > On 14/12/2010 at 16:08:26 +0100, Hans Ulli Kroll wrote :
>> > > driver for the rtc device
>> > > on Cortina Systems CS3516 or StormlinkSemi SL3516 aka Gemini SoC
>> > >
>> > > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>> >
>> > This driver has never been merged and the platform doesn't seem to be
>> > active anymore. Is there still any interest in getting this driver
>> > mainlined?
>> >
>> > Only tree wide cleanups happened in mach-gemini since end of 2010, the
>> > listed git repository (git://git.berlios.de/gemini-board) was on berliOS
>> > (closed since 2011) and the sourceforge mirror seems empty. Is there
>> > still interest in keeping that platform in the mainline?
>> 
>> As far as I know, the platform is still used by a number of people,
>> and is supported by OpenWRT. The reason we haven't seen updates is 
>> that
>> Ulli has been mostly absent from upstream development, and we haven't
>> had any other person step up as maintainer.
>> 
>> I have a patch to convert the platform to ARCH_MULTIPLATFORM, and
>> the code doesn't really get in the way otherwise.
>> 
>> As far as I'm concerned, we should just merge all the patches from
>> http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
>> 
>> We should also try to find a maintainer that can respond to patches
>> in a timely manner. If Ulli has time for that again, that would be 
>> great,
>> otherwise I think we should find someone from OpenWRT to take over.
>> 
> 
> Thanks to point that, I'll merge that one which seems clean enough:
> http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039

For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital. 
Without that timers are broken and cpu is super slow.

Regards,
Roman

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
