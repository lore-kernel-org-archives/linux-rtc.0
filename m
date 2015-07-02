Return-Path: <rtc-linux+bncBDS7HNEFSALRB5UY22WAKGQE7YM4UCI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si341183wiz.0.2015.07.02.12.09.41
        for <rtc-linux@googlegroups.com>;
        Thu, 02 Jul 2015 12:09:41 -0700 (PDT)
Date: Thu, 2 Jul 2015 21:09:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Wei-Ning Huang <wnhuang@google.com>, eddie.huang@mediatek.com,
	a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-mt6397: enable wakeup before registering
 rtc device
Message-ID: <20150702190939.GE3467@piout.net>
References: <1435826216-11982-1-git-send-email-wnhuang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1435826216-11982-1-git-send-email-wnhuang@google.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/07/2015 at 16:36:56 +0800, Wei-Ning Huang wrote :
> rtc_sysfs_add_device checks if device can wakeup before creating the
> wakealarm file in sysfs. Thus the driver must set wakeup capability
> before registering the rtc device.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied on rtc-fixes, thanks.

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
