Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXXZ6LGAKGQEVFUKQ5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 74si86895wmf.8.2017.08.22.16.23.09
        for <rtc-linux@googlegroups.com>;
        Tue, 22 Aug 2017 16:23:09 -0700 (PDT)
Date: Wed, 23 Aug 2017 01:23:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eric Cooper <ecc@cmu.edu>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: m41t80: enable wakealarm when
 "wakeup-source" is specified
Message-ID: <20170822232309.g4k37pnle2no3mgr@piout.net>
References: <20170730001054.20118-1-ecc@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170730001054.20118-1-ecc@cmu.edu>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/07/2017 at 20:10:54 -0400, Eric Cooper wrote:
> Don't require an IRQ if the wakeup-source device-tree property is present.
> 
> Signed-off-by: Eric Cooper <ecc@cmu.edu>
> ---
>  drivers/rtc/rtc-m41t80.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 

I've applied it but it didn't apply cleanly, please check rtc-next or
linux-next, thanks.

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
