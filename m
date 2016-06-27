Return-Path: <rtc-linux+bncBDKOZ45RYIGRBBM3YW5QKGQEUWFVHJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0110.outbound.protection.outlook.com. [65.55.169.110])
        by gmr-mx.google.com with ESMTPS id x204si1328869ywb.1.2016.06.27.09.00.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 09:00:05 -0700 (PDT)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ryan Mallon <rmallon@gmail.com>, "Alexander
 Clouter" <alex@digriz.org.uk>, Jason Cooper <jason@lakedaemon.net>, "Andrew
 Lunn" <andrew@lunn.ch>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Gregory Clement
	<gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] RE: [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
Date: Mon, 27 Jun 2016 16:00:02 +0000
Message-ID: <SN1PR0101MB15655C9A2095FDADB98A0703D0210@SN1PR0101MB1565.prod.exchangelabs.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sunday, June 26, 2016 3:03 PM, Alexandre Belloni wrote:
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

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
