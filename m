Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBRUWVTDAKGQEX7MTSZQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l138si36369wmg.0.2017.03.16.15.01.42
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Mar 2017 15:01:42 -0700 (PDT)
Date: Thu, 16 Mar 2017 23:01:31 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	patches@opensource.wolfsonmicro.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-wm8350: Remove unused to_wm8350_from_rtc_dev
Message-ID: <20170316220131.sp6tubyxqkqvjr3o@piout.net>
References: <20170311064213.30752-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170311064213.30752-1-iwamatsu@nigauri.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/03/2017 at 15:42:13 +0900, Nobuhiro Iwamatsu wrote:
> The to_wm8350_from_rtc_dev macro is not used by anything in the
> rtc-wm8350 driver.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/rtc/rtc-wm8350.c | 2 --
>  1 file changed, 2 deletions(-)
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
