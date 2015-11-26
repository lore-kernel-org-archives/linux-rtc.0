Return-Path: <rtc-linux+bncBDS7HNEFSALRBDP33SZAKGQED3D3PTI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y203si85295wmc.2.2015.11.26.09.12.45
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Nov 2015 09:12:45 -0800 (PST)
Date: Thu, 26 Nov 2015 18:12:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Yoann Sculo <yoann@printk.fr>
Subject: [rtc-linux] Re: [PATCH v3] rtc: ds1307: fix alarm reading at probe time
Message-ID: <20151126171245.GU3950@piout.net>
References: <1448548633-651-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448548633-651-1-git-send-email-simon.guinot@sequanux.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 26/11/2015 at 15:37:13 +0100, Simon Guinot wrote :
> With the actual code, read_alarm() always returns -EINVAL when called
> during the RTC device registration. This prevents from retrieving an
> already configured alarm in hardware.
> 
> This patch fixes the issue by moving the HAS_ALARM bit configuration
> (if supported by the hardware) above the rtc_device_register() call.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  drivers/rtc/rtc-ds1307.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
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
