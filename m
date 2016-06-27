Return-Path: <rtc-linux+bncBDMNVCMSWQLBB25AYW5QKGQETLJMBNA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from outbound1a.ore.mailhop.org (outbound1a.ore.mailhop.org. [54.213.22.21])
        by gmr-mx.google.com with ESMTPS id zj2si2489262pac.1.2016.06.27.09.12.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 09:12:26 -0700 (PDT)
Date: Mon, 27 Jun 2016 16:12:22 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Alexander Clouter <alex@digriz.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
Message-ID: <20160627161222.GY9922@io.lakedaemon.net>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hey Alexandre,

On Mon, Jun 27, 2016 at 12:03:02AM +0200, Alexandre Belloni wrote:
> m48t86.h belongs to include/linux/platform_data/
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
>  arch/arm/mach-ep93xx/ts72xx.c                          | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c                   | 2 +-
>  drivers/rtc/rtc-m48t86.c                               | 2 +-
>  include/linux/{m48t86.h => platform_data/rtc-m48t86.h} | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)

For the orion5x bit,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
