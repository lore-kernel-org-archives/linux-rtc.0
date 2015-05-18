Return-Path: <rtc-linux+bncBDS7HNEFSALRBE6O5GVAKGQEAHYZBIA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u10si444352wif.1.2015.05.18.15.26.27
        for <rtc-linux@googlegroups.com>;
        Mon, 18 May 2015 15:26:27 -0700 (PDT)
Date: Tue, 19 May 2015 00:26:26 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Dale Farnsworth <dale@farnsworth.org>,
	Minkyu Kang <mk7.kang@samsung.com>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: RTC: Add MODULE_DEVICE_TABLE to rtc-ds1672/rtc-max6900/rtc-max8998
Message-ID: <20150518222625.GY3338@piout.net>
References: <1303129017.8158.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1303129017.8158.1.camel@phoenix>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 18/04/2011 at 20:16:57 +0800, Axel Lin wrote :
> The device table is required to load modules based on modaliases.
> After adding MODULE_DEVICE_TABLE, below entries will be added to modules.alias:
> 
> alias i2c:ds1672 rtc_ds1672
> alias i2c:max6900 rtc_max6900
> alias platform:lp3974-rtc rtc_max8998
> alias platform:max8998-rtc rtc_max8998
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Dale Farnsworth <dale@farnsworth.org>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/rtc/rtc-ds1672.c  |    1 +
>  drivers/rtc/rtc-max6900.c |    1 +
>  drivers/rtc/rtc-max8998.c |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
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
