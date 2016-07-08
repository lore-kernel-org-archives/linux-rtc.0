Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB47P725QKGQEHPU4FMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q124si121760wme.3.2016.07.08.07.25.55
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jul 2016 07:25:55 -0700 (PDT)
Date: Fri, 8 Jul 2016 16:25:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, nm@ti.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Fix relying on reset value for weekday
Message-ID: <20160708142554.GI22202@piout.net>
References: <1464778147-22075-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1464778147-22075-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/06/2016 at 16:19:07 +0530, Keerthy wrote :
> The reset value of weekday is 0x1. This is wrong since
> the reset values of the day/month/year make up to Jan 1 2001.
> When computed weekday comes out to be Monday. On a scale
> of 1-7(Sunday - Saturday) it should be 0x2. So we should not
> be relying on the reset value.
> 
> Hence compute the wday using the current date/month/year values.
> Check if reset wday is any different from the computed wday,
> If different then set the wday which we computed using
> date/month/year values.
> 
> Document Referred:
> http://ww1.microchip.com/downloads/en/DeviceDoc/20002266F.pdf
> 
> Fixes: 1d1945d261a2af "drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips"
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
Applied, thanks.

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
