Return-Path: <rtc-linux+bncBDS7HNEFSALRBIFMQC2QKGQEUVWHSCQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q64si838631wmg.0.2016.01.20.15.20.00
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jan 2016 15:20:00 -0800 (PST)
Date: Thu, 21 Jan 2016 00:19:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geliang Tang <geliangtang@163.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1305: use to_spi_device and kobj_to_dev
Message-ID: <20160120231959.GD3367@piout.net>
References: <69d9b6de4c0a2c10544f9982bce92d3132bf6d21.1450875144.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <69d9b6de4c0a2c10544f9982bce92d3132bf6d21.1450875144.git.geliangtang@163.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/12/2015 at 20:54:33 +0800, Geliang Tang wrote :
> For better readability, use to_spi_device() and kobj_to_dev() instead
> of container_of().
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/rtc/rtc-ds1305.c | 4 ++--
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
