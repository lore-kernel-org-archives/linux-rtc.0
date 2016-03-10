Return-Path: <rtc-linux+bncBDS7HNEFSALRBTXQQ63QKGQEU7OVVZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si13355wmp.0.2016.03.10.14.42.22
        for <rtc-linux@googlegroups.com>;
        Thu, 10 Mar 2016 14:42:22 -0800 (PST)
Date: Thu, 10 Mar 2016 23:42:19 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: hym8563: fix invalid year calculation
Message-ID: <20160310224219.GO9868@piout.net>
References: <1457257437-18975-1-git-send-email-al.kochet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457257437-18975-1-git-send-email-al.kochet@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/03/2016 at 12:43:57 +0300, Alexander Kochetkov wrote :
> Year field must be in BCD format, according to
> hym8563 datasheet.
> 
> Due to the bug year 2016 became 2010.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  drivers/rtc/rtc-hym8563.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
