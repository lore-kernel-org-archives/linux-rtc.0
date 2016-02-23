Return-Path: <rtc-linux+bncBDS7HNEFSALRB56TWO3AKGQEUOTRHFA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v197si1108988wmv.1.2016.02.23.15.23.35
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 15:23:35 -0800 (PST)
Date: Wed, 24 Feb 2016 00:23:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Wolfgang Grandegger <wg@grandegger.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 1/4] rtc-rx8025: fix irq handler registration
Message-ID: <20160223232334.GF10681@piout.net>
References: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/02/2016 at 23:49:06 +0900, Akinobu Mita wrote :
> When IRQ line for this chips is connected, devm_request_threaded_irq()
> refuses to register irq handler with the following message.
> 
> genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-rx8025.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
All applied, thanks.

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
