Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPOAUHBAKGQEBWGU3YQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si1039627wmd.3.2016.12.07.11.17.16
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Dec 2016 11:17:16 -0800 (PST)
Date: Wed, 7 Dec 2016 20:17:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH v3] rtc: add support for EPSON TOYOCOM RTC-7301SF/DG
Message-ID: <20161207191715.63i3exilseqasak5@piout.net>
References: <1480860279-4570-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1480860279-4570-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/12/2016 at 23:04:39 +0900, Akinobu Mita wrote :
> This adds support for EPSON TOYOCOM RTC-7301SF/DG which has parallel
> interface compatible with SRAM.
> 
> This driver supports basic clock, calendar and alarm functionality.
> 
> Tested with Microblaze linux running on Artix7 FPGA board with my own
> custom IP for RTC-7301.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> * Changes from v2
> - Convert enum to usual #defines
> 
>  .../devicetree/bindings/rtc/epson,rtc7301.txt      |  16 +
>  drivers/rtc/Kconfig                                |  11 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-r7301.c                            | 453 +++++++++++++++++++++
>  4 files changed, 481 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rtc7301.txt
>  create mode 100644 drivers/rtc/rtc-r7301.c
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
