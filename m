Return-Path: <rtc-linux+bncBDJIP47K7MERBSMPU27AKGQEAFITZUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com. [209.85.218.41])
        by gmr-mx.google.com with ESMTPS id i2si308112ith.1.2016.09.02.07.08.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 07:08:07 -0700 (PDT)
Received: by mail-oi0-f41.google.com with SMTP id p186so127281076oia.2
        for <rtc-linux@googlegroups.com>; Fri, 02 Sep 2016 07:08:06 -0700 (PDT)
Date: Fri, 2 Sep 2016 09:08:05 -0500
From: Rob Herring <robh@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH] rtc: add support for EPSON TOYOCOM RTC-7301SF/DG
Message-ID: <20160902140805.GA18646@rob-hp-laptop>
References: <1472396118-13424-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1472396118-13424-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Aug 28, 2016 at 11:55:18PM +0900, Akinobu Mita wrote:
> This adds support for EPSON TOYOCOM RTC-7301SF/DG which has parallel
> interface compatible with SRAM.
> 
> This driver supports basic clock, calendar and alarm functionality.
> 
> Tested with Microblaze linux running on Artix7 FPGA board with my own
> custom IP for RTC-7301.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/epson,rtc7301.txt      |  15 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/Kconfig                                |  11 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-r7301.c                            | 458 +++++++++++++++++++++
>  4 files changed, 485 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rtc7301.txt
>  create mode 100644 drivers/rtc/rtc-r7301.c

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
