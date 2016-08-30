Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBN76S67AKGQEP4TL4NQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y7si2562781wmd.0.2016.08.30.14.48.38
        for <rtc-linux@googlegroups.com>;
        Tue, 30 Aug 2016 14:48:38 -0700 (PDT)
Date: Tue, 30 Aug 2016 23:48:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: changed raw spi calls to register map calls
Message-ID: <20160830214837.4muxmee3mueimhg4@piout.net>
References: <57C5E569.4050605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57C5E569.4050605@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Please fix the subject, this patch is ds1347 specific.

On 31/08/2016 at 01:28:33 +0530, RAGHAVENDRA GANIGA wrote :
> From 2ec82b6c9b99647e31d26c4c828dc7c51af8a633 Mon Sep 17 00:00:00 2001
> From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
> Date: Wed, 31 Aug 2016 01:13:30 +0530
> Subject: [PATCH] rtc: changed raw spi calls to register map calls
> 
> This patch changes calls of spi read write calls to register map
> read and write calls
> 

Can you explain why you need that change? I'm not sure what you gain
from it (it makes the driver and the kernel bigger).

>  	/* year in linux is from 1900 i.e in range of 100
> -	in rtc it is from 00 to 99 */
> +	 * in rtc it is from 00 to 99
> +	 */

Unrelated change.


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
