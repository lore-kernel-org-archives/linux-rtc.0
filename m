Return-Path: <rtc-linux+bncBDS7HNEFSALRBEW2TS2QKGQEYY4H6GY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b4si54048wme.3.2016.01.26.00.23.46
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 00:23:46 -0800 (PST)
Date: Tue, 26 Jan 2016 09:23:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Tianping Fang <tianping.fang@mediatek.com>,
	Henry Chen <henryc.chen@mediatek.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: add IRQ domain dependency
Message-ID: <20160126082345.GD11740@piout.net>
References: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 25/01/2016 at 17:04:46 +0100, Arnd Bergmann wrote :
> The mt6397 RTC driver can be built either when the MFD_MT6397 driver
> is enabled (which selects IRQ_DOMAIN), or when compile testing.
> The latter however fails without IRQ domains:
> 
> drivers/rtc/rtc-mt6397.c: In function 'mtk_rtc_probe':
> drivers/rtc/rtc-mt6397.c:326:13: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
>   rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> 
> This adds an explicit dependency for the COMPILE_TEST case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
