Date: Sun, 12 Feb 2017 01:05:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hartley Sweeten <HartleyS@visionengravers.com>
Cc: Alexander Clouter <alex@digriz.org.uk>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: Re: [rtc-linux] RE: [PATCH 0/3] rtc: m48t86: cleanup driver and add
 NVRAM support
Message-ID: <20170212000505.nx5lw6zsr5cbwm2v@piout.net>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
 <20170210224505.GK24768@quatermain.digriz.org.uk>
 <SN1PR0101MB1565C312398D334B5B81B2E1D0440@SN1PR0101MB1565.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SN1PR0101MB1565C312398D334B5B81B2E1D0440@SN1PR0101MB1565.prod.exchangelabs.com>
List-ID: <rtc-linux.googlegroups.com>

On 10/02/2017 at 22:56:12 +0000, Hartley Sweeten wrote:
> On Friday, February 10, 2017 3:45 PM, Alexander Clouter wrote:
> > On Fri, Feb 10, 2017 at 11:11:54AM -0700, H Hartley Sweeten wrote:
> >>
> >>Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
> >>if it is actually present before registering the rtc device. This "probing"
> >>just checks if the NVRAM is present by reading/writing the last two bytes
> >>of the NVRAM. I'm not sure if this is really necessary. If it can be removed
> >>all the m48t86_ops stuff could also be removed from this driver, along with
> >>platform_data/rtc-m48t86.h.
> >
> > The RTC is an optional upgrade on the TS-7800[1].  Not sure what would happen 
> > if the RTC driver kicks in with no actual RTC being present?
> 
> How about modifying the m48t86 probe so that it does the NVRAM check that
> you are doing in the ts78xx platform code. If the NVRAM check fails the probe
> will return -ENODEV. Reading the NVRAM to check the 0x55 0xaa signature in
> the last locations might be adequate. Not sure if making sure they can be written
> is necessary.
> 
> Then you can just register the driver and let it figure out if the rtc is actually there.
> 
> >> If I was to do this over again, I probably would have the driver check that the 
> >> HMS is actually incrementing after being instantiated, if it looks weird then 
> >> to unbind its-self.
> 
> Or the probe could do that check and return -ENODEV if it fails.
> 

If it is always incrementing, even when it has never been set (first
boot or battery is dead), then this can be done in the probe.

The other option would be to switch to DT but that's far from trivial,
especially seeing how they are connected ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
