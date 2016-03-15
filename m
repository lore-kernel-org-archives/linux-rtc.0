Date: Tue, 15 Mar 2016 01:18:44 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sergei Ianovich <ynvich@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:REAL TIME CLOCK RTC SUBSYSTEM" <rtc-linux@googlegroups.com>,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v7] rtc: rewrite DS1302 using SPI
Message-ID: <20160315001844.GJ28277@piout.net>
References: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
 <1456224900-4877-1-git-send-email-ynvich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456224900-4877-1-git-send-email-ynvich@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

Thank you for your work!

On 23/02/2016 at 13:54:57 +0300, Sergei Ianovich wrote :
> -#ifdef CONFIG_SH_SECUREEDGE5410
> -#include <asm/rtc.h>
> -#include <mach/secureedge5410.h>
> -
> -#define	RTC_RESET	0x1000
> -#define	RTC_IODATA	0x0800
> -#define	RTC_SCLK	0x0400
> -
> -#define set_dp(x)	SECUREEDGE_WRITE_IOPORT(x, 0x1c00)
> -#define get_dp()	SECUREEDGE_READ_IOPORT()
> -#define ds1302_set_tx()
> -#define ds1302_set_rx()
> -

I would like to have a solution for secureedge5410 even if it is
untested. Else, we are breaking an existing platform without any
solution.

I've put the sh maintainers in copy, maybe they have an opinion. Else
I'll let your patch sit in linux-next for the next cycle.

I have further cleanups in that driver but they can probably be done
later.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
