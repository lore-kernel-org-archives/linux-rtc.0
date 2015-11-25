Return-Path: <rtc-linux+bncBDS7HNEFSALRB3UB3CZAKGQEDZLS4PY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q80si273365wmg.0.2015.11.25.10.41.50
        for <rtc-linux@googlegroups.com>;
        Wed, 25 Nov 2015 10:41:50 -0800 (PST)
Date: Wed, 25 Nov 2015 19:41:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] drivers/rtc/rtc-tps65910.c: Add IRQF_ONESHOT
 to interrupt flags
Message-ID: <20151125184149.GQ3950@piout.net>
References: <1448475597-11228-1-git-send-email-saurabh.truth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448475597-11228-1-git-send-email-saurabh.truth@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 25/11/2015 at 23:49:57 +0530, Saurabh Sengar wrote :
> If no primary handler is specified for threaded_irq then a
> default one is assigned which always returns IRQ_WAKE_THREAD.
> This handler requires the IRQF_ONESHOT, because the source of
> interrupt is not disabled
> 

Are you sure this is necessary? The parent irqchip is the mfd and it
sets IRQF_ONESHOT.

Does that solve a real problem or is it a false positive coming from a
static analysis tool?


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
