Date: Mon, 24 Aug 2015 09:19:07 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	a.zummo@towertech.it, sbkim73@samsung.com, k.kozlowski@samsung.com
Subject: Re: [PATCH v2] rtc: s5m: fix to update ctrl register
Message-ID: <20150824071907.GD13155@piout.net>
References: <1440150221-2609-1-git-send-email-jy0922.shim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440150221-2609-1-git-send-email-jy0922.shim@samsung.com>
List-ID: <rtc-linux.googlegroups.com>

On 21/08/2015 at 18:43:41 +0900, Joonyoung Shim wrote :
> According to datasheet, the S2MPS13X and S2MPS14X should update write
> buffer via setting WUDR bit to high after ctrl register is written.
> 
> If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
> tools/testing/selftests/timers/rtctest.c test program and hour format is
> used to 12 hour mode in Odroid-XU3 board.
> 
> One more issue is the RTC doesn't keep time on Odroid-XU3 board when i
> turn on board after power off even if RTC battery is connected. It can
> be solved as setting WUDR & RUDR bits to high at the same time after
> RTC_CTRL register is written. It's same with condition of only writing
> ALARM registers, so this is for only S2MPS14 and we should set WUDR &
> A_UDR bits to high on S2MPS13.
> 
> I can't find any reasonable description about this like fix from
> datasheet, but can find similar codes from rtc driver source of
> hardkernel kernel and vender kernel.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: <stable@vger.kernel.org> # v3.16
> ---
> Changelog for v2:
> - update commit description and code to fix time keeping problem
> - update the stable tag with the kernel version
> 
>  drivers/rtc/rtc-s5m.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
Applied, thanks. I fixed the small typo.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
