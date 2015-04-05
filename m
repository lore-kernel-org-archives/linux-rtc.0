Date: Sun, 5 Apr 2015 11:06:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: akpm@linux-foundation.org, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH] rtc: hym8563: fix swapped enable/disable of
 clockout control bit
Message-ID: <20150405090603.GR20669@piout.net>
References: <6712839.2ZD6yJNGY8@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6712839.2ZD6yJNGY8@diego>
List-ID: <rtc-linux.googlegroups.com>

On 05/04/2015 at 02:20:24 +0200, Heiko Stübner wrote :
> The hym8563 datasheet describes the clock output control-bit as "when set
> to logic 0, the square wave output is enable, when set to logic 1, the
> CLKOUT output is inhibited". But in reality the setting is exactly
> opposite.
> 
> Before now, the clock output was not really used, but on the rk3288 soc
> this generated clock is used to supply the temperature sensor block and
> the swapped bit value prevented it from working. With the corrected value,
> the tsadc now reports correct values.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Should that patch be applied on any stable version too?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
