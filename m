Return-Path: <rtc-linux+bncBAABBLFBU3FAKGQEEJUZOLY@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id i19si4236714wme.2.2017.06.20.14.16.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 14:16:28 -0700 (PDT)
Date: Tue, 20 Jun 2017 22:15:36 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Baruch Siach <baruch@tkos.co.il>,
	"patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
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
Message-ID: <20170620211536.GM4902@n2100.armlinux.org.uk>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
 <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd>
 <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 20, 2017 at 05:07:46PM +0200, Benjamin Gaignard wrote:
> 2017-06-20 15:48 GMT+02:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> >> Yes, that's argument against changing rtc _drivers_ for hardware that
> >> can not do better than 32bit. For generic code (such as 44/51 sysfs,
> >> 51/51 suspend test), the change still makes sense.
> 
> What I had in mind when writing those patches was to remove the limitations
> coming from those functions usage, even more since they been marked has
> deprecated.

I'd say that they should not be marked as deprecated.  They're entirely
appropriate for use with hardware that only supports a 32-bit
representation of time.

It's entirely reasonable to fix the ones that use other representations
that exceed that, but for those which do not, we need to keep using the
32-bit versions.  Doing so actually gives us _more_ flexibility in the
future.

Consider that at the moment, we define the 32-bit RTC representation to
start at a well known epoch.  We _could_ decide that when it wraps to
0x80000000 seconds, we'll define the lower 0x40000000 seconds to mean
dates in the future - and keep rolling that forward each time we cross
another 0x40000000 seconds.  Unless someone invents a real time machine,
we shouldn't need to set a modern RTC back to 1970.

If we convert the 32-bit counter RTC drivers to use 64-bit conversions,
then we're completely stuffed, because the lower 32-bits will always
be relative to the epoch, and we can't change that without breaking
the 64-bit users.

So, keep the 32-bit conversion functions, do not deprecate them, and
think about the future possibilities.

I really think this "get rid of 32-bit time representations" is a much
to narrow focus on the wrong problem.  You can't ever fix 32-bit time
representations by just adding additional zeros into the MSB bits.

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
