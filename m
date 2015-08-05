Return-Path: <rtc-linux+bncBAABBSX2Q6XAKGQEI5YZUAI@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id x3si311706pdh.2.2015.08.05.05.10.50
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Aug 2015 05:10:50 -0700 (PDT)
Date: Wed, 5 Aug 2015 20:10:32 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v5 0/6] add device tree support for mxc rtc
Message-ID: <20150805121032.GK12927@tiger>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sun, Jul 26, 2015 at 11:37:47PM +0200, Philippe Reynes wrote:
> Philippe Reynes (6):
>   imx31: add a second rtc clock

clk: imx: ...

>   imx35: define two clocks for rtc

clk: imx35: ...

>   rtc: mxc: use a second rtc clock
>   dt-binding: document the binding for mxc rtc
>   rtc: mxc: add support of device tree
>   imx27: dt: add support of internal rtc

ARM: dts: imx27: ...

Applied all with above minor changes on subject prefix.

Shawn

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
