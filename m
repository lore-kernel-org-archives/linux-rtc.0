Date: Sun, 31 Jan 2016 13:08:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Andi Shyti <andi.shyti@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] rtc: max77686: Cleanup and reduce dmesg output
Message-ID: <20160131120822.GN20165@piout.net>
References: <1453877171-30510-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453877171-30510-1-git-send-email-k.kozlowski@samsung.com>
List-ID: <rtc-linux.googlegroups.com>

On 27/01/2016 at 15:46:11 +0900, Krzysztof Kozlowski wrote :
> Cleanup of entire driver of its dmesg output:
> 1. Remove printing of the function name, because printing device name is
>    sufficient. This also makes the dev_err()-like functions more compact
>    and readable (not need of line break).
> 2. Lower from info to debug printing of each RTC interrupt (no need to
>    make noise on each alarm).
> 3. Remove dev_info() at beginning of probe because a message is already
>    always printed by either probe failure or from registering the RTC
>    device as /dev/rtcX.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Patch rebased on top of Javier's v4:
> [PATCH v4 00/10] rtc: max77686: Extend driver and add max77802 support
> http://www.spinics.net/lists/arm-kernel/msg477194.html
> 
> Feel free to join with these series.
> ---
>  drivers/rtc/rtc-max77686.c | 39 ++++++++++++++-------------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
