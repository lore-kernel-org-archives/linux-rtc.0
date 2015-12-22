Return-Path: <rtc-linux+bncBDS7HNEFSALRBWFY42ZQKGQEKGVOKJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si781448wmc.0.2015.12.22.10.54.15
        for <rtc-linux@googlegroups.com>;
        Tue, 22 Dec 2015 10:54:15 -0800 (PST)
Date: Tue, 22 Dec 2015 19:54:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	open list <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: rv8803: fix handling return value of i2c_smbus_read_byte_data
Message-ID: <20151222185414.GB8623@piout.net>
References: <1449734133-29235-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449734133-29235-1-git-send-email-a.hajda@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/12/2015 at 08:55:33 +0100, Andrzej Hajda wrote :
> The function can return negative values, so its result should
> be assigned to signed variable.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046107
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/rtc/rtc-rv8803.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
