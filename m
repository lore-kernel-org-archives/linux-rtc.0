Return-Path: <rtc-linux+bncBDS7HNEFSALRBEP4X6WQKGQE7BCB5XA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si717143wiz.0.2015.07.22.13.33.21
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jul 2015 13:33:21 -0700 (PDT)
Date: Wed, 22 Jul 2015 22:33:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/4] RTC: remove unnecessary device_get() in rtc_device_unregister
Message-ID: <20150722203319.GM2853@piout.net>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437433372-15425-2-git-send-email-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437433372-15425-2-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 20/07/2015 at 16:02:50 -0700, Dmitry Torokhov wrote :
> Technically the address of rtc->dev can never be NULL, so get_device()
> can never fail. Also caller of rtc_device_unregister() supposed to be
> the owner of the device and thus have a valid reference. Therefore
> call to get_device() is not needed here.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/class.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
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
