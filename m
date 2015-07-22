Return-Path: <rtc-linux+bncBDS7HNEFSALRBAH4X6WQKGQE4BNXFMY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v8si768802wiw.1.2015.07.22.13.33.03
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jul 2015 13:33:03 -0700 (PDT)
Date: Wed, 22 Jul 2015 22:32:59 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Vasiliy Kulikov <segooon@gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/4] RTC: fix double free in
 rtc_register_device() error path
Message-ID: <20150722203259.GL2853@piout.net>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 20/07/2015 at 16:02:49 -0700, Dmitry Torokhov wrote :
> Commit 59cca865f21e9e7beab73fcf79ba4eb776a4c228 correctly noted that naked
> kfree() should not be used after failed device_register() call, however,
> while it added the needed put_device() it forgot to remove the original
> kfree() causing double-free.
> 
> Cc: Vasiliy Kulikov <segooon@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/class.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
Applied after fixing the commit description in the commit log, thanks.


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
