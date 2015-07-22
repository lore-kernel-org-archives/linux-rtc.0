Return-Path: <rtc-linux+bncBDS7HNEFSALRBW77X6WQKGQEF2BQDGY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si139932wib.1.2015.07.22.13.40.59
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jul 2015 13:40:59 -0700 (PDT)
Date: Wed, 22 Jul 2015 22:40:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/4] RTC: properly manage lifetime of dev and
 cdev in rtc device
Message-ID: <20150722204057.GN2853@piout.net>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437433372-15425-3-git-send-email-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437433372-15425-3-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 20/07/2015 at 16:02:51 -0700, Dmitry Torokhov wrote :
> struct rtc embeds both struct dev and struct cdev.  Unfortunately character
> device structure may outlive the parent rtc structure unless we set it up
> as parent of character device so that it will stay pinned until character
> device is freed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/rtc-dev.c | 1 +
>  1 file changed, 1 insertion(+)
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
