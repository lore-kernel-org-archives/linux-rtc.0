Return-Path: <rtc-linux+bncBDE6RCFOWIARBXVP7KWAKGQEFDZI26Y@googlegroups.com>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com. [209.85.214.182])
        by gmr-mx.google.com with ESMTPS id fk9si598975igb.0.2015.07.09.08.48.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 08:48:46 -0700 (PDT)
Received: by mail-ob0-f182.google.com with SMTP id km3so174107899obb.1
        for <rtc-linux@googlegroups.com>; Thu, 09 Jul 2015 08:48:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e6214ee669fbd797ad2ef257ce52068@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
	<2131951.l0j0CIttAZ@wuerfel>
	<f22e65faa7d86074cda27973f83d7a52@advem.lv>
	<1781580.JRD7b0UrJA@wuerfel>
	<alpine.LNX.2.00.1507091343150.24357@localhost>
	<5e6214ee669fbd797ad2ef257ce52068@advem.lv>
Date: Thu, 9 Jul 2015 17:48:45 +0200
Message-ID: <CACRpkdYm-W8FqBgvustJUweizocmX9LtVS6Q=7j8EjF8D+H77Q@mail.gmail.com>
Subject: [rtc-linux] Re: Gemini Soc timers
From: Linus Walleij <linus.walleij@linaro.org>
To: Roman Yeryomin <roman@advem.lv>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felix Fietkau <nbd@openwrt.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>
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

On Thu, Jul 9, 2015 at 3:02 PM, Roman Yeryomin <roman@advem.lv> wrote:
> On 2015-07-09 14:58, Hans Ulli Kroll wrote:
>>
>> Hi
>>
>> On Thu, 9 Jul 2015, Arnd Bergmann wrote:
>>
>>> On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
>>> >
>>> > OK, here are the minimal changes required (see attachment). Tested on
>>> > 4.1.1
>>> > Let me know if you want me to submit it in some other way.
>>> >
>>>
>>> The changes look ok to me. Please submit them as two separate
>>> patches (1. set up and use timer3, 2. register sched_clock) according
>>> to the Documentation/SubmittingPatches description.
>>>
>>> Thanks,
>>>
>>>         Arnd
>>>
>>
>> have you seen this thread ...
>> [PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state
>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/423992
>>
>> arch/arm/mach-gemini/time.c              | 69 ++++++++++++------------
>>
>> Two or more weeks ago I send a patchset fixing this problem.
>> At this time Arnd was in holiday and until today I was very busy at work.
>
>
> Sorry, I didn't see your patches.
> Arnd requested minimal changes and until yesterday I was very busy too.
>
>> I can rework my patches on top of Viresh's patchset
>
>
> It looks that this patchset doesn't conflict with the fix needed.

Can any of you guys just look at this thing from OpenWRT:
http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/patches-3.18/160-gemini-timers.patch;h=4b0edb45d162f751bfb7475f5b3158f28d69fe84;hb=HEAD

As usual they are just keeping it out of mainline, and this
is adding sched_clock() and other goodies so should
probably be upstreamed ASAP.

Yours,
Linus Walleij

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
