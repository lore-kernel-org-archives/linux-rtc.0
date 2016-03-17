Return-Path: <rtc-linux+bncBDS7HNEFSALRBG7PVK3QKGQEIQ4ZX3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si115346wmp.0.2016.03.17.06.56.43
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 06:56:43 -0700 (PDT)
Date: Thu, 17 Mar 2016 14:56:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Burton <paul.burton@imgtec.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/5] rtc: rtc-jz4740: Add support for devicetree
Message-ID: <20160317135632.GG3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-3-git-send-email-paul@crapouillou.net>
 <20160317120804.GD3362@piout.net>
 <56EAB210.70900@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56EAB210.70900@imgtec.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 17/03/2016 at 13:33:04 +0000, Harvey Hunt wrote :
> On 17/03/16 12:08, Alexandre Belloni wrote:
> >On 05/03/2016 at 23:38:49 +0100, Paul Cercueil wrote :
> >>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>---
> >>  drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> >>index 47617bd..3914b1c 100644
> >>--- a/drivers/rtc/rtc-jz4740.c
> >>+++ b/drivers/rtc/rtc-jz4740.c
> >>@@ -17,6 +17,7 @@
> >>  #include <linux/io.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >>+#include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/rtc.h>
> >>  #include <linux/slab.h>
> >>@@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
> >>  }
> >>  EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
> >>
> >>+static const struct of_device_id jz4740_rtc_of_match[] = {
> >>+	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
> >>+	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
> >
> >ingenic is not in Documentation/devicetree/bindings/vendor-prefixes.txt,
> >you have to add it there before using it.
> 
> Ingenic is in vendor-prefixes.txt - it was added by Commit f289cc7
> ("devicetree/bindings: add Ingenic Semiconductor vendor prefix").
> 

Indeed, I was looking at an old v4.1 based branch instead of master.

You can forget that comment :)


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
