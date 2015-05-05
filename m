Return-Path: <rtc-linux+bncBDS7HNEFSALRBENAUKVAKGQEF67BVVY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si528473wib.3.2015.05.05.02.40.32
        for <rtc-linux@googlegroups.com>;
        Tue, 05 May 2015 02:40:32 -0700 (PDT)
Date: Tue, 5 May 2015 11:40:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: harald@ccbib.org
Cc: rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20150505094031.GH4276@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org>
 <20150417093023.GF29796@piout.net>
 <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
 <20150419153743.GA4353@piout.net>
 <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
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

On 20/04/2015 at 09:11:02 +0200, harald@ccbib.org wrote :
> Hi Alexandre,
> 
> On Sun, 19 Apr 2015 17:37:43 +0200, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
> >> >  - use syscon instead of passing callbacks to the watchdog driver
> >> 
> >> I will put looking into this onto my todo list, but I'm not familiar
> >> with syscon yet and it is not obvious to me how to port the rtc driver
> >> to syscon without breaking devicetree backwards compatibility. So I'd
> >> like to defer this for later unless somebody gives me some guidance.
> >> 
> > 
> > As the rtc driver is the one instantiating the watchdog driver, there is
> > no reason why the DT ABI would be broken. You simply have to create
> > the syscon in the RTC driver and then pass it to the watchdog driver,
> > the same way it is done with the callbacks.
> 
> Ok, this is less invasive than what I have been thinking. This makes
> sense. 
>  

I realized I confused syscon with regmap. So indeed, switching to syscon
will require a not nice change to the DT. But what I really meant was
creating a regmap from the rtc driver and pass it to the watchdog
driver.

> > I can have a look at doing it as I have some i.mx28 platforms.
> 
> If you can point me to a driver that is a good reference for your model,
> then I can do this myself. Otherwise I'd prefer if you wrote the code.
> I can do the testing though, if this helps.
> 

You can have a look at the devm_regmap_init_mmio() users.


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
