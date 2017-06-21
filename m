Return-Path: <rtc-linux+bncBC27HSOJ44LBB3XXVDFAKGQEMAEDLHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp-out6.electric.net (smtp-out6.electric.net. [192.162.217.184])
        by gmr-mx.google.com with ESMTPS id i63si4485644wmf.0.2017.06.21.02.27.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 02:27:09 -0700 (PDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King - ARM Linux' <linux@armlinux.org.uk>, Benjamin Gaignard
	<benjamin.gaignard@linaro.org>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Baruch Siach
	<baruch@tkos.co.il>, "patches@opensource.wolfsonmicro.com"
	<patches@opensource.wolfsonmicro.com>, Linus Walleij
	<linus.walleij@linaro.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>, Sylvain Lemieux
	<slemieux.tyco@gmail.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Jason
 Cooper" <jason@lakedaemon.net>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"adi-buildroot-devel@lists.sourceforge.net"
	<adi-buildroot-devel@lists.sourceforge.net>, Vladimir Zapolskiy
	<vz@mleia.com>, John Stultz <john.stultz@linaro.org>, Gregory Clement
	<gregory.clement@free-electrons.com>, Michael Chan
	<michael.chan@broadcom.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alessandro Zummo
	<a.zummo@towertech.it>, Barry Song <baohua@kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve Twiss
	<stwiss.opensource@diasemi.com>, Maxime Ripard
	<maxime.ripard@free-electrons.com>
Subject: [rtc-linux] RE: [PATCH 00/51] rtc: stop using rtc deprecated functions
Date: Wed, 21 Jun 2017 09:26:51 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00278C0@AcuExch.aculab.com>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net> <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net> <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd> <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
 <20170620211536.GM4902@n2100.armlinux.org.uk>
In-Reply-To: <20170620211536.GM4902@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Russell King - ARM Linux
> Sent: 20 June 2017 22:16
..
> Consider that at the moment, we define the 32-bit RTC representation to
> start at a well known epoch.  We _could_ decide that when it wraps to
> 0x80000000 seconds, we'll define the lower 0x40000000 seconds to mean
> dates in the future - and keep rolling that forward each time we cross
> another 0x40000000 seconds.  Unless someone invents a real time machine,
> we shouldn't need to set a modern RTC back to 1970.

True, just treating the value as unsigned gives another 67 years.

If a 32bit RTC is programmed with the low 32bits of the 64bit 'seconds
since 1970' the kernel should have no real difficulty sorting out the
high bits from other available information.

Problems with things like the x86 bios setting the rtc to stupid values
are another matter.
ISTR the rtc chip has a bit for 'summertime' that is never set, on a
multi-os system you can get multiple summer time changes.

	David

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
