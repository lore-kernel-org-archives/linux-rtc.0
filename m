Date: Tue, 3 Mar 2015 02:11:16 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
Message-ID: <20150303011116.GW4094@piout.net>
References: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
List-ID: <rtc-linux.googlegroups.com>

On 02/03/2015 at 15:53:37 -0800, Andrew Morton wrote :
> On Sun,  1 Mar 2015 11:27:15 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > Add support for the i2c RTC from Abracon.
> 
> What is the relationship between this patch and
> http://ozlabs.org/~akpm/mmots/broken-out/rtc-add-rtc-abx805-a-driver-for-the-abracon-ab-1805-i2c-rtc.patch?
> 

I'd say drop mine, I couldn't find the other one before writing it...

I'll try to build on Philippe's driver.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
