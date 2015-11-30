Return-Path: <rtc-linux+bncBDS7HNEFSALRBK536KZAKGQE2PMRIQI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y203si585171wmc.2.2015.11.30.11.04.11
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 11:04:11 -0800 (PST)
Date: Mon, 30 Nov 2015 20:04:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nizam Haider <nizamhaider786@gmail.com>
Cc: ulli.kroll@googlemail.com, a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
Subject: [rtc-linux] Re: [PATCH] Rtc: rtc-gemini.c: Remove unnecessary platform_set_drvdata()
Message-ID: <20151130190410.GJ22136@piout.net>
References: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 14/11/2015 at 01:51:29 +0530, Nizam Haider wrote :
> The driver core clears the driver data to NULL after device_release
> or on probe failure
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
> ---
>  drivers/rtc/rtc-gemini.c | 1 -
>  1 file changed, 1 deletion(-)
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
