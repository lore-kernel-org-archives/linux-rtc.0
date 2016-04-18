Return-Path: <rtc-linux+bncBDS7HNEFSALRBIMT2S4AKGQEU3GN2JI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a80si2365683wma.0.2016.04.18.09.21.52
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 09:21:52 -0700 (PDT)
Date: Mon, 18 Apr 2016 18:21:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Qianyu Gong <qianyu.gong@nxp.com>
Cc: "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: rtc ds3232 call trace in kernel
Message-ID: <20160418162151.GR25196@piout.net>
References: <AM2PR04MB09643A16272FB78B0D9FA103E76B0@AM2PR04MB0964.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <AM2PR04MB09643A16272FB78B0D9FA103E76B0@AM2PR04MB0964.eurprd04.prod.outlook.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/04/2016 at 06:15:40 +0000, Qianyu Gong wrote :
> Hi Akinobu,
> 
> I got an rtc call trace when booting 4.6 kernel on our board and I found it
> was caused by this patch:
> 
> commit fc1dcb0b39dbb10d3290f2fcd6e154670f699166
> Author: Akinobu Mita <akinobu.mita@gmail.com>
> Date:   Mon Mar 7 00:27:53 2016 +0900
> 
>     rtc: ds3232: use rtc->ops_lock to protect alarm operations
> 
>     ds3232->mutex is used to protect for alarm operations which
>     need to access status and control registers.
> 
>     But we can use rtc->ops_lock instead.  rtc->ops_lock is held when most
>     of rtc_class_ops methods are called, so we only need to explicitly
>     acquire it from irq handler in order to protect form concurrent
>     accesses.
> 
>     Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com
> 
> The problem is that rtc->ops_lock would be accessed in ds3232_irq()
> without being initialized as rtc_device_register() is called too late.
> 
> As I'm not familiar with rtc things, could I just revert the patch or you already
> have a solution to this problem? Thanks in advance.
> 
> 

Well, many RTC drivers actually suffer from that. I'm planning to change
the infrastructure to handle this case better.
Meanwhile, this is worth fixing.


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
