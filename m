Return-Path: <rtc-linux+bncBDS7HNEFSALRBX4NXCVAKGQEAI5CCBY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si123051wib.2.2015.05.09.06.08.47
        for <rtc-linux@googlegroups.com>;
        Sat, 09 May 2015 06:08:47 -0700 (PDT)
Date: Sat, 9 May 2015 15:08:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Tomasz Figa <tfiga@google.com>
Subject: [rtc-linux] Re: [PATCH v4 0/3] Add Mediatek SoC RTC driver
Message-ID: <20150509130846.GD3338@piout.net>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/05/2015 at 15:23:39 +0800, Eddie Huang wrote :
> RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series
> support RTC driver that work with Mediatek SoC like MT8135, MT8173.
> It implements second counter and also provide alarm function.
> 
> This series base on 4.1-rc1, Test ok on MT8173 platform.
> 
> [1] https://lkml.org/lkml/2015/1/23/325
> 

All applied, thanks!


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
