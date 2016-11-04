Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBOEO6TAAKGQEFXOT2BA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id y7si651616wme.0.2016.11.04.15.09.59
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Nov 2016 15:09:59 -0700 (PDT)
Date: Fri, 4 Nov 2016 23:09:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mirza Krak <mirza.krak@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	Mirza Krak <mirza.krak@hostmobility.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: pcf85063: do not register a RTC
 device if chip is not present
Message-ID: <20161104220959.4puwnl7icixa6fdh@piout.net>
References: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 17/10/2016 at 15:53:31 +0200, Mirza Krak wrote :
> From: Mirza Krak <mirza.krak@hostmobility.com>
> 
> Add a sanity check to see if chip is present. If we can not communicate
> with the chip there is no point in registering a RTC device.
> 
> Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
Applied, thanks.

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
