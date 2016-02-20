Return-Path: <rtc-linux+bncBDS7HNEFSALRBSW3T63AKGQE5LC4FAQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si507717wmd.0.2016.02.19.20.38.33
        for <rtc-linux@googlegroups.com>;
        Fri, 19 Feb 2016 20:38:33 -0800 (PST)
Date: Sat, 20 Feb 2016 05:38:33 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, a.zummo@towertech.it,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 0/2] add Alphascale asm9260 RTC driver
Message-ID: <20160220043833.GF2222@piout.net>
References: <20160202102804.GT20165@piout.net>
 <1454442971-25225-1-git-send-email-linux@rempel-privat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454442971-25225-1-git-send-email-linux@rempel-privat.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/02/2016 at 20:56:09 +0100, Oleksij Rempel wrote :
> This patch set provide support for RTC controller found on Alphascale
> ASM9260 SoC.
> 
> v2:
> - change license to GPLv2 and later
> - remove HW_RTC_AUX and HW_RTC_AUXEN. Thay was taken from reference driver.
>   Documentation do not provide any info about it. According to my tests
>   this regs are not available on asm9260.
> - remove calibration from DT. It will be beter to set it over sysfs.
> 
> Oleksij Rempel (2):
>   rtc: add rtc-asm9260 driver
>   doc: dt: add documentation for alphascale,asm9260-rtc
> 
>  .../bindings/rtc/alphascale,asm9260-rtc.txt        |  19 ++
>  drivers/rtc/Kconfig                                |  10 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-asm9260.c                          | 355 +++++++++++++++++++++
>  4 files changed, 385 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
>  create mode 100644 drivers/rtc/rtc-asm9260.c
> 

Applied, thanks!


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
