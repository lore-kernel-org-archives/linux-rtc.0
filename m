Return-Path: <rtc-linux+bncBDS7HNEFSALRBW7LSKXQKGQEJXU7PCQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si47090wid.0.2015.08.31.13.15.23
        for <rtc-linux@googlegroups.com>;
        Mon, 31 Aug 2015 13:15:23 -0700 (PDT)
Date: Mon, 31 Aug 2015 22:15:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Luis de Bethencourt <luis.bg@samsung.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Support Opensource <support.opensource@diasemi.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	linux-mediatek@lists.infradead.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	Tony Prisk <linux@prisktech.co.nz>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: Fix module autoload for OF platform drivers
Message-ID: <20150831201523.GB3409@piout.net>
References: <1440676322-19870-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1440676322-19870-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27/08/2015 at 13:52:02 +0200, Javier Martinez Canillas wrote :
> These platform drivers have a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-armada38x.c | 1 +
>  drivers/rtc/rtc-coh901331.c | 1 +
>  drivers/rtc/rtc-da9063.c    | 1 +
>  drivers/rtc/rtc-moxart.c    | 1 +
>  drivers/rtc/rtc-mpc5121.c   | 1 +
>  drivers/rtc/rtc-mt6397.c    | 1 +
>  drivers/rtc/rtc-mv.c        | 1 +
>  drivers/rtc/rtc-vt8500.c    | 1 +
>  8 files changed, 8 insertions(+)
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
