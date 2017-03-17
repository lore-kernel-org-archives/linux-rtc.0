Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNXWV7DAKGQEWMEFYUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n128si159284wmf.2.2017.03.17.08.05.25
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 08:05:25 -0700 (PDT)
Date: Fri, 17 Mar 2017 16:05:24 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Brandt <Chris.Brandt@renesas.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 2/5] rtc: Add rtc-sh
Message-ID: <20170317150524.oijto6gtjxycdnwn@piout.net>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-3-chris.brandt@renesas.com>
 <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
 <SG2PR06MB1165A9931C930DF9BCD5C0A98A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdW0nHiZkE_RxVLX3G0MuwQLPHVFyNq5C1tx0yAqDQefaA@mail.gmail.com>
 <SG2PR06MB11653BB788CADBEE78FE4CF58A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdWs3NtKLiBnKCmxGYNBW3zzWYydj=JGKr+mH7ao97L2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMuHMdWs3NtKLiBnKCmxGYNBW3zzWYydj=JGKr+mH7ao97L2_Q@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 17/03/2017 at 14:55:48 +0100, Geert Uytterhoeven wrote:
> >> it would still be good to have phandles to the external clock sources as
> >> well, as that describes the hardware topology.
> >
> > I'm confused, you mean make new clocks node for RTC_X1 (fixed at 32.768kHZ) and
> > RTC_X3 (fixed at 4MHz), but then not really do anything with then? (the driver
> 
> You still do something with them, as they'll be linked from the rtc device node.
> 
> > doesn't need them)
> 
> The driver may use them in the future.
> E.g. to select among X1, X3, or EXTAL, depending on availability.
> 

I'm on Geert's side here, I wouldn't rely on the bootloader to set
everything up correctly.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
