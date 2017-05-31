Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCF6XDEQKGQEPEH64GY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 196si463578wma.3.2017.05.30.18.40.23
        for <rtc-linux@googlegroups.com>;
        Tue, 30 May 2017 18:40:23 -0700 (PDT)
Date: Wed, 31 May 2017 03:40:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/4] rtc: m41t80: improve SQW support
Message-ID: <20170531014013.r5kdqdl3rykpue2z@piout.net>
References: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 25/04/2017 at 16:45:13 +0200, Gary Bisson wrote:
> Hi,
> 
> This series aims at improving the square-wave support for some of the
> devices supported by the m41t80 driver.
> 
> The first two patches are fixes that prevent the driver from overriding
> the SQW configuration (divider & enable bit).
> 
> Then the last two remove the old sysfs entry and replace it with a clock
> provider approach.
> 
> It has been tested on a Boundary Devices Nitrogen6_MAX which features a
> MicroCrystal RV4162 RTC. The SQW (named clkout in RV4162 datasheet) can be
> probed on TP70 on the platform.
> 
> Let me know if you have any question/suggestion.
> 
> Regards,
> Gary
> 
> Gary Bisson (4):
>   rtc: m41t80: fix SQWE override when setting an alarm
>   rtc: m41t80: fix SQW dividers override when setting a date
>   rtc: m41t80: remove sqw sysfs entry
>   rtc: m41t80: add clock provider support
> 
>  drivers/rtc/rtc-m41t80.c | 251 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 175 insertions(+), 76 deletions(-)
> 

All applied now, I had to rebase the last patch on top of v4.12-rc1

Thanks!

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
