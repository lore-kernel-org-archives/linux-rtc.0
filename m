Date: Thu, 9 Apr 2015 18:52:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [rtc-linux] Re: [PATCH v2 1/2] Documentation: bindings: add
 abracon,abx80x
Message-ID: <20150409165242.GB20669@piout.net>
References: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427856743-26625-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20150409132523.GA4421@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150409132523.GA4421@frolo.macqel>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 09/04/2015 at 15:25:23 +0200, Philippe De Muyter wrote :
> Hi Alexandre,
> 
> when I look into Documentation/devicetree/bindings/rtc, it seems that
> all rtc but a few (mainly old ones) have the "-rtc" suffix in the
> "compatible" property.
> 
> Would it not be better to keep it here also, like what I had written ?
> 

No, they have that suffix because they are RTC IPs part of a SoC so the
chosen compatible is <soc>-rtc. In the case of the abracon RTC, it would
be redundant.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
