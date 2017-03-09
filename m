Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDWEQLDAKGQEO7Z5A4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id t131si433746wmf.1.2017.03.08.16.30.06
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Mar 2017 16:30:06 -0800 (PST)
Date: Thu, 9 Mar 2017 01:30:06 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
Message-ID: <20170309003006.j5y7zabuto7er676@piout.net>
References: <20170303142925.17915-1-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170303142925.17915-1-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/03/2017 at 11:29:11 -0300, Javier Martinez Canillas wrote:
> Hello,
> 
> This series add OF device ID tables to RTC I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.
> 
> That's done because the plan is to change the I2C core to report proper OF
> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
> a device was registered via DT or using the legacy platform data.
> 
> So these patches will make sure that RTC I2C drivers modules will continue
> to be autoloaded once the I2C core is changed to report proper OF modalias.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (13):
>   rtc: rv8803: Add OF device ID table
>   rtc: rv3029: Add OF device ID table
>   rtc: bq32k: Add OF device ID table
>   rtc: ds1307: Add OF device ID table
>   rtc: rx8010: Add OF device ID table
>   rtc: ds3232: Add OF device ID table
>   rtc: rtc-ds1672: Add OF device ID table
>   rtc: ds1374: Set .of_match_table to OF device ID table
>   rtc: isl1208: Add OF device ID table
>   rtc: s35390a: Add OF device ID table
>   rtc: rx8581: Add OF device ID table
>   rtc: m41t80: Add OF device ID table
>   rtc: rs5c372: Add OF device ID table
> 

All applied, thanks!

>  drivers/rtc/rtc-bq32k.c    |  7 +++++
>  drivers/rtc/rtc-ds1307.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/rtc/rtc-ds1374.c   |  1 +
>  drivers/rtc/rtc-ds1672.c   |  9 +++++-
>  drivers/rtc/rtc-ds3232.c   |  7 +++++
>  drivers/rtc/rtc-isl1208.c  | 12 ++++++--
>  drivers/rtc/rtc-m41t80.c   | 63 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/rtc/rtc-rs5c372.c  | 37 ++++++++++++++++++++++++-
>  drivers/rtc/rtc-rv3029c2.c |  9 ++++++
>  drivers/rtc/rtc-rv8803.c   | 21 +++++++++++++-
>  drivers/rtc/rtc-rx8010.c   |  7 +++++
>  drivers/rtc/rtc-rx8581.c   |  7 +++++
>  drivers/rtc/rtc-s35390a.c  |  8 ++++++
>  13 files changed, 248 insertions(+), 8 deletions(-)
> 
> -- 
> 2.9.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
