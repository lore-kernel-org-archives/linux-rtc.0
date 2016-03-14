Return-Path: <rtc-linux+bncBDS7HNEFSALRBH5VTO3QKGQEAWB7CZQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si543491wmp.0.2016.03.14.08.37.02
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 08:37:02 -0700 (PDT)
Date: Mon, 14 Mar 2016 16:36:57 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: pcf2127: convert to use regmap
Message-ID: <20160314153657.GE2693@piout.net>
References: <1457966701-6532-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457966701-6532-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/03/2016 at 23:44:59 +0900, Akinobu Mita wrote :
> pcf2127 has selectable I2C-bus and SPI-bus interface support.
> Currently rtc-pcf2127 driver only supports I2C.
> 
> This is preparation for support for SPI interface.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> * v2
> - fix typo in subject line
> - add comment for custom regmap_bus
> 
>  drivers/rtc/rtc-pcf2127.c | 214 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 144 insertions(+), 70 deletions(-)
All applied, thanks.

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
