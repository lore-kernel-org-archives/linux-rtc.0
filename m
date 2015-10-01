Return-Path: <rtc-linux+bncBAABBYWWWWYAKGQEVCAWJTA@googlegroups.com>
Received: from mail.cosmopool.net (mail.cosmopool.net. [2a01:4f8:160:20c1::10:107])
        by gmr-mx.google.com with ESMTP id c1si121055wiv.3.2015.10.01.10.20.33
        for <rtc-linux@googlegroups.com>;
        Thu, 01 Oct 2015 10:20:33 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2015 19:20:32 +0200
From: <harald@ccbib.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: <rtc-linux@googlegroups.com>, Wolfram Sang <wsa@the-dreams.de>,
 Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <20150505094031.GH4276@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org> <20150417093023.GF29796@piout.net> <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net> <20150419153743.GA4353@piout.net> <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net> <20150505094031.GH4276@piout.net>
Message-ID: <c75c3f0a5a1a136bac7c882178b01815@imap.cosmopool.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

sorry for the very long delay. 

I tried your suggestion to switch the watchdog driver to regmap several
times but couldn't come up with something that wasn't either very ugly
or completely pointless - i.e. no better then passing a pointer to the
register block. See below.

On Tue, 5 May 2015 11:40:31 +0200, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
> 
> On 20/04/2015 at 09:11:02 +0200, harald@ccbib.org wrote :
>> Hi Alexandre,
>> 
>> On Sun, 19 Apr 2015 17:37:43 +0200, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
>> >> >  - use syscon instead of passing callbacks to the watchdog driver
>> >> 
>> >> I will put looking into this onto my todo list, but I'm not familiar
>> >> with syscon yet and it is not obvious to me how to port the rtc
driver
>> >> to syscon without breaking devicetree backwards compatibility. So
I'd
>> >> like to defer this for later unless somebody gives me some guidance.
>> > 
>> > As the rtc driver is the one instantiating the watchdog driver, there
>> > is
>> > no reason why the DT ABI would be broken. You simply have to create
>> > the syscon in the RTC driver and then pass it to the watchdog driver,
>> > the same way it is done with the callbacks.
>> 
>> Ok, this is less invasive than what I have been thinking. This makes
>> sense. 
> 
> I realized I confused syscon with regmap. So indeed, switching to syscon
> will require a not nice change to the DT. But what I really meant was
> creating a regmap from the rtc driver and pass it to the watchdog
> driver.

Since the rtc and watchdog drivers need different bits of the same control
register, we would need to use regmap_fields to pass them around.
Unfortunately this means we can't use the _SET and _CLR registers, which
means we need to use regmap everywhere to get proper locking. A lot of
overhead for no benefit.

After reading lots of messages around the genesis and usage of
regmap_mmio,
it seems to me the intended usecases are to fix some endianness issues
and to have a register cache available during suspend - both of which
don't
apply in this case.

If you want to get rid of the callbacks we should just pass the pointer
to the register block to the child device, I think. Which way is
preferable
is probably only a matter of taste so I won't override the driver authors
decision unless there is some clear statement that this is the preferred
style in the rtc subsystem.

I will send the other patch (unify register access macros) you asked about
shortly.

Harald

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
