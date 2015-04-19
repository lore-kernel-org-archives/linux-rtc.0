Return-Path: <rtc-linux+bncBDS7HNEFSALRBSEXZ6UQKGQECUKSARQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si650765wia.1.2015.04.19.08.37.44
        for <rtc-linux@googlegroups.com>;
        Sun, 19 Apr 2015 08:37:44 -0700 (PDT)
Date: Sun, 19 Apr 2015 17:37:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: harald@ccbib.org
Cc: rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20150419153743.GA4353@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org>
 <20150417093023.GF29796@piout.net>
 <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
> >  - use syscon instead of passing callbacks to the watchdog driver
> 
> I will put looking into this onto my todo list, but I'm not familiar
> with syscon yet and it is not obvious to me how to port the rtc driver
> to syscon without breaking devicetree backwards compatibility. So I'd
> like to defer this for later unless somebody gives me some guidance.
> 

As the rtc driver is the one instantiating the watchdog driver, there is
no reason why the DT ABI would be broken. You simply have to create
the syscon in the RTC driver and then pass it to the watchdog driver,
the same way it is done with the callbacks.

I can have a look at doing it as I have some i.mx28 platforms.

> > It would be greatly appreciated if you could do those changes too.
> 
> Is it ok if I send the simple cleanup patch and a rebased version of
> my original patch without the syscon conversion? This will be more work
> for me testing two patch series, but I think GETBOOTSTATUS is an
> important feature that I'd like to see supported soon.
> 

I'm fine with your patch, I was simply suggesting cleanups that should
be sent as separate patches. However, I'd like more people to review the
watchdog part.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
