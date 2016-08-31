Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBTMJTS7AKGQEDD7QBRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p199si2456955wmd.1.2016.08.31.09.24.45
        for <rtc-linux@googlegroups.com>;
        Wed, 31 Aug 2016 09:24:45 -0700 (PDT)
Date: Wed, 31 Aug 2016 18:24:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v6 1/4] rtc: ac100: support clock-output-names
 in device tree binding
Message-ID: <20160831162443.idwfr6efztiwtydd@piout.net>
References: <20160819074226.16636-1-wens@csie.org>
 <20160819074226.16636-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160819074226.16636-2-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/08/2016 at 15:42:23 +0800, Chen-Yu Tsai wrote :
> The ac100 device tree binding specifies the usage of clock-output-names
> to specify the names of its 3 clock outputs. This is needed for orphan
> clock resolution, when the ac100 is probed much later than any clocks
> that consume any of its outputs. This wasn't supported by the driver.
> 
> Add support for this.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v5:
> 
>   - New patch, based on mfd-rtc immutable branch given in
> 
>      http://www.spinics.net/lists/devicetree/msg137991.html
> 
> ---
>  drivers/rtc/rtc-ac100.c | 2 ++
>  1 file changed, 2 insertions(+)
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
