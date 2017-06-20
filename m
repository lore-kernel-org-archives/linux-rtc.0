Return-Path: <rtc-linux+bncBAABBNGIU3FAKGQEF6EUOKY@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id i63si4137024wmf.0.2017.06.20.15.39.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 15:39:47 -0700 (PDT)
Date: Tue, 20 Jun 2017 23:38:59 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Baruch Siach <baruch@tkos.co.il>,
	"patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Len Brown <len.brown@intel.com>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	John Stultz <john.stultz@linaro.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Barry Song <baohua@kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
Message-ID: <20170620223859.GO4902@n2100.armlinux.org.uk>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <alpine.DEB.2.20.1706202343120.2157@nanos>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jun 21, 2017 at 12:00:30AM +0200, Thomas Gleixner wrote:
> Yes, but there are still quite some issues to solve there:
> 
>      1) How do you tell the system that it should apply the offset in the
>      	first place, i.e at boot time before NTP or any other mechanism can
>      	correct it?
> 
>      2) Deal with creative vendors who have their own idea about the 'start
>      	of the epoch'
> 	
>      3) Add the information of wraparound time to the rtc device which
>      	needs to be filled in for each device. That way the rtc_***
>      	accessor functions can deal with them whether they wrap in 2038 or
>      	2100 or whatever.
> 
> #3 is the simplest problem of them :)	

Well, if there's additional non-volatile storage, you can store
additional information in there, but you still need the RTC
subsystem to be aware that the hardware is only 32-bit capable.

You'd also still need something along the lines I detailed
(redefining what dates the past 32-bit values indicate) to cope
with the RTC being set backwards after the machine thinks (possibly
incorrectly) that the date has jumped forwards.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
