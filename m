Return-Path: <rtc-linux+bncBDE6RCFOWIARBV6ZXOXQKGQEY6G53WY@googlegroups.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com. [209.85.218.48])
        by gmr-mx.google.com with ESMTPS id a11si257911igv.3.2015.09.08.07.12.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2015 07:12:37 -0700 (PDT)
Received: by mail-oi0-f48.google.com with SMTP id w128so59244283oiw.2
        for <rtc-linux@googlegroups.com>; Tue, 08 Sep 2015 07:12:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441305318-24773-1-git-send-email-festevam@gmail.com>
References: <1441305318-24773-1-git-send-email-festevam@gmail.com>
Date: Tue, 8 Sep 2015 16:12:36 +0200
Message-ID: <CACRpkdbypR_LO9txaHqh24V1h0YDcm1BLpHicU9txJTpe6ORKg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]
From: Linus Walleij <linus.walleij@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Sep 3, 2015 at 8:35 PM, Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Add a sentinel to ab85xx_rtc_ids[] in order to fix the following error:
>
> drivers/rtc/rtc-ab8500: struct platform_device_id is 24 bytes.  The last of 2 is:
> 0x61 0x62 0x38 0x35 0x34 0x30 0x2d 0x72 0x74 0x63 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x8c
> FATAL: drivers/rtc/rtc-ab8500: struct platform_device_id is not terminated with a NULL entry!
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

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
