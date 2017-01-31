Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDXYYPCAKGQEROOZZHI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 66si1249359wml.3.2017.01.31.13.05.17
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Jan 2017 13:05:17 -0800 (PST)
Date: Tue, 31 Jan 2017 22:05:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: sun6i: Fix compatibility with old DT binding
Message-ID: <20170131210517.jkhwe3e2d7mjfgti@piout.net>
References: <20170129101343.7222-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170129101343.7222-1-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/01/2017 at 18:13:43 +0800, Chen-Yu Tsai wrote:
> Commit 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator") adds
> a new clock for the rtc block with a 2 step probe mechanism. To share
> the register region between both the clock and rtc instance, a static
> pointer is used to keep the related data structure.
> 
> To preserve compatibility with the old binding, the data structure
> should be saved as soon as the registers are mapped in, regardless
> of the presence of the clock bindings, so that the rtc device can
> retrieve it when it is probed.
> 
> This fixes the rtc device not probing when we use the updated driver
> with an old device tree blob.
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/rtc/rtc-sun6i.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

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
