Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSWPUTFAKGQE6VECC2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f207si3774344wme.5.2017.06.20.06.48.28
        for <rtc-linux@googlegroups.com>;
        Tue, 20 Jun 2017 06:48:28 -0700 (PDT)
Date: Tue, 20 Jun 2017 15:48:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	"adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ingo Molnar <mingo@redhat.com>, Jason Cooper <jason@lakedaemon.net>,
	John Stultz <john.stultz@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
Message-ID: <20170620134827.ubvzhh25klaotupv@piout.net>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
 <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170620134458.GA10104@amd>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/06/2017 at 15:44:58 +0200, Pavel Machek wrote:
> On Tue 2017-06-20 13:37:22, Steve Twiss wrote:
> > Hi Pavel,
> > 
> > On 20 June 2017 14:26, Pavel Machek wrote:
> > 
> > > Subject: Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
> > > 
> > > On Tue 2017-06-20 14:24:00, Alexandre Belloni wrote:
> > > > On 20/06/2017 at 14:10:11 +0200, Pavel Machek wrote:
> > > > > On Tue 2017-06-20 12:03:48, Alexandre Belloni wrote:
> > > > > > On 20/06/2017 at 11:35:08 +0200, Benjamin Gaignard wrote:
> > > > > > > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > > > > > > rely on 32bits variables and that will make rtc break in y2038/2016.
> > > > > >
> > > > > > Please don't, because this hide the fact that the hardware will not
> > > > > > handle dates in y2038 anyway and as pointed by Russell a few month ago,
> > > > > > rtc_time_to_tm will be able to catch it but the 64 bit version will
> > > > > > silently ignore it.
> > > > >
> > > > > Reference? Because rtc on PCs stores date in binary coded decimal, so
> > > > > it is likely to break in 2100, not 2038...
> > > >
> > > > I'm not saying it should be done but clearly, that is not the correct
> > > > thing to do for RTCs that are using a single 32 bits register to store
> > > > the time.
> > > > You give one example, I can give you three: armada38x, at91sam9,
> > > > at32ap700x and that just in the beginning of the series.
> > > 
> > > I wanted reference to Russell's mail.
> > 
> > This is it.
> > https://patchwork.kernel.org/patch/6219401/
> 
> Thanks.
> 
> Yes, that's argument against changing rtc _drivers_ for hardware that
> can not do better than 32bit. For generic code (such as 44/51 sysfs,
> 51/51 suspend test), the change still makes sense.
> 

Yes, we agree on that but I won't cherry pick working patches from a 51
patches series.


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
