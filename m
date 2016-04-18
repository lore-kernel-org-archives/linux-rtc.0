Return-Path: <rtc-linux+bncBDS7HNEFSALRB4WC2W4AKGQE7F6OA6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a80si50269wma.0.2016.04.18.15.36.34
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 15:36:34 -0700 (PDT)
Date: Tue, 19 Apr 2016 00:36:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Zhuang Yuyao <mlistz@gmail.com>,
	Zhuang Yuyao <zhuangyy@syan.com.cn>,
	Michael Tatarinov <kukabu@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: ds3231 temperature s16 overflow
Message-ID: <20160418223623.GD25196@piout.net>
References: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/04/2016 at 09:21:42 +0900, Akinobu Mita wrote :
> From: Zhuang Yuyao <mlistz@gmail.com>
> 
> while retrieving temperature from ds3231, the result may be overflow
> since s16 is too small for a multiplication with 250.
> 
> ie. if temp_buf[0] == 0x2d, the result (s16 temp) will be negative.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Zhuang Yuyao <mlistz@gmail.com>
> Cc: Zhuang Yuyao <zhuangyy@syan.com.cn>
> Cc: Michael Tatarinov <kukabu@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
