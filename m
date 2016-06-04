Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBN2ZO5AKGQE6C4JQIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id j140si187865wmf.1.2016.06.04.06.52.05
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 06:52:05 -0700 (PDT)
Date: Sat, 4 Jun 2016 15:52:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc-pcf2123: use sign_extend32() for sign extension
Message-ID: <20160604135204.GK4594@piout.net>
References: <1460974664-7525-1-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460974664-7525-1-git-send-email-martink@posteo.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/04/2016 at 12:17:44 +0200, Martin Kepplinger wrote :
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/rtc/rtc-pcf2123.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
