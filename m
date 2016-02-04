Return-Path: <rtc-linux+bncBDS7HNEFSALRBNFPZ62QKGQERZURK4I@googlegroups.com>
Date: Thu, 4 Feb 2016 23:58:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 03/11] drivers: rtc: allow compilation of
 sun6i RTC for all sunxi SoCs
Message-ID: <20160204225859.GF4782@piout.net>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/02/2016 at 17:39:22 +0000, Andre Przywara wrote :
> At the moment the "sun6i" RTC drivers depends on having two specific
> SoC families selected.
> The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
> to allow inclusion of the driver for all Allwinner SoCs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/rtc/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
