Return-Path: <rtc-linux+bncBAABBGVVV6VAKGQEOHESFOQ@googlegroups.com>
Received: from mail.pbx.lv ([213.175.90.140])
        by gmr-mx.google.com with ESMTP id bm9si258772lbb.0.2015.05.07.14.35.21
        for <rtc-linux@googlegroups.com>;
        Thu, 07 May 2015 14:35:21 -0700 (PDT)
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Fri, 08 May 2015 00:35:20 +0300
From: Roman Yeryomin <roman@advem.lv>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>, Felix Fietkau <nbd@openwrt.org>
In-Reply-To: <alpine.LNX.2.00.1505071936170.19877@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2694895.MomHLoCaoZ@wuerfel>
 <alpine.LNX.2.00.1505070455130.32495@T520.local>
 <5043733.xO9lSCKvly@wuerfel>
 <alpine.LNX.2.00.1505071936170.19877@T520.local>
Message-ID: <beaeec189608d669a47cac8ad589ee25@advem.lv>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 2015-05-07 20:46, Hans Ulli Kroll wrote:
> Hi
> 
> On Thu, 7 May 2015, Arnd Bergmann wrote:
> 
>> On Thursday 07 May 2015 05:00:03 Hans Ulli Kroll wrote:
>> > On Wed, 6 May 2015, Arnd Bergmann wrote:
>> > > As far as I'm concerned, we should just merge all the patches from
>> > > http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
>> > >
>> > > We should also try to find a maintainer that can respond to patches
>> > > in a timely manner. If Ulli has time for that again, that would be great,
>> > > otherwise I think we should find someone from OpenWRT to take over.
>> >
>> > I'm back in busyness.
>> > Currently me dev device is right next to me.
>> > I moved some time ago and haav to find it in some 'hidden' box.
>> 
>> Awesome, welcome back!
>> 
>> Are you able to look at the patches I mentioned above and submit them
>> to arm@kernel.org, cc linux-arm-kernel@lists.infradead.org with proper
>> patch descriptions?
>> 
>> 	Arnd
>> 
> 
> Already done,
> RTC driver send.
> Compilder fix for MACH-RECORD send.
> Maintainer Update send.
> 
> This device is a (very) bad design, to be polite !
> I think they didn't test this properly.
> And they fixed some software issues in hardware.
> To be exact :
> They switched the IDE channels in hardware, to get around the stupid
> Sausalito software.

AFAIK, ide channels are switchable in the driver.

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
