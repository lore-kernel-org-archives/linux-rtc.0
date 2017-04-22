Return-Path: <rtc-linux+bncBAABBVFR53DQKGQEHD5LXYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 65si2309004pff.4.2017.04.22.10.54.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Apr 2017 10:54:27 -0700 (PDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 960B320120
	for <rtc-linux@googlegroups.com>; Sat, 22 Apr 2017 17:54:25 +0000 (UTC)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8A054200E9
	for <rtc-linux@googlegroups.com>; Sat, 22 Apr 2017 17:54:24 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id y33so89551507qta.2
        for <rtc-linux@googlegroups.com>; Sat, 22 Apr 2017 10:54:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170420172538.GA13892@tyrael.amer.corp.natinst.com>
References: <1492468810-17224-1-git-send-email-mdf@kernel.org>
 <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop> <20170420172538.GA13892@tyrael.amer.corp.natinst.com>
From: Moritz Fischer <mdf@kernel.org>
Date: Sat, 22 Apr 2017 10:54:23 -0700
Message-ID: <CAAtXAHfNuRXninLWySAOdtV99ih4PBt=JPszn3UkNa08OvXLFQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Add trickle charger device tree binding
To: Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, rtc-linux <rtc-linux@googlegroups.com>,
	Devicetree List <devicetree@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Apr 20, 2017 at 10:25 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Apr 20, 2017 at 10:56:34AM -0500, Rob Herring wrote:
>> On Mon, Apr 17, 2017 at 03:40:10PM -0700, Moritz Fischer wrote:
>> > Introduce a device tree binding for specifying the trickle charger
>> > configuration for ds1374. This is based on the code for ds13390.
>> >
>> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> > ---
>> >  .../devicetree/bindings/rtc/dallas,ds1374.txt      | 18 ++++++++
>> >  drivers/rtc/rtc-ds1374.c                           | 54 ++++++++++++++++++++++
>> >  2 files changed, 72 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
>> > new file mode 100644
>> > index 0000000..4cf5bd7
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
>> > @@ -0,0 +1,18 @@
>> > +* Dallas DS1374            I2C Real-Time Clock / WDT
>>
>> Please remove from trivial-devices.txt, too. (which is moving in 4.12
>> BTW)
>
> Ok, I'll redo this on top of b7e252fcddfa573bb1ee275b53bba6cef85671d4
> (Documentation: devicetree: move trivial-devices out of I2C realm) then.

Follow up question, right now one selects between WDT and ALARM mode with
a CONFIG_RTC_DRV_DS1374_WDT=y statically at compile time.

I'd like to add a 'dallas,mode = <DS1374_WDT>;' or
dallas,enable-watchdog property
to the binding, same goes for the ability to remap the WDT reset output to the
interrupt pin (which is currently not supported, but my hardware needs this).

Would be the right way to add the remapping something like
'dallas,remap-reset-to-int' ?

Ideas? This change would obviously break people's setups where they
select one or
the other behavior via the build time option. Is that acceptable seen
that relying on
build time CONFIG_FOO seems like a bad assumption to begin with?

A bit of background: I currently started cleaning up a bunch of issues
in this driver,
like refactoring it to use the watchdog framework instead of open
coding everything,
make setting the timeout actually work (right now it the timeout to
tick conversion is
hosed).

Thanks,

Moritz

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
