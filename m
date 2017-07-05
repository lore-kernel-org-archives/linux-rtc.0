Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBL5H6XFAKGQE3HFXANA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 71si3149821wmp.3.2017.07.05.14.01.35
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Jul 2017 14:01:35 -0700 (PDT)
Date: Wed, 5 Jul 2017 23:01:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Po-Yu Chuang <ratbert@faraday-tech.com>
Subject: [rtc-linux] Re: [PATCH 3/3 v2] rtc: gemini/ftrtc010: rename driver
 and symbols
Message-ID: <20170705210135.n6i33mxuhxqlrp62@piout.net>
References: <20170530075332.3740-1-linus.walleij@linaro.org>
 <20170530075332.3740-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170530075332.3740-3-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30/05/2017 at 09:53:32 +0200, Linus Walleij wrote:
> The Gemini RTC is actually a generic IP block from Faraday
> Technology names FTRTC010. Rename the driver file and all
> symbols to match this IP name.
> 
> The relationship can be clearly seen in the U-Boot driver
> posted by Po-Yu Chuang for the Faraday A320 board:
> https://lists.denx.de/pipermail/u-boot/2009-September/061326.html
> 
> Remove the dependency on ARCH_GEMINI but select the driver
> for ARCH_GEMINI so we get a smooth transition. The IP block
> is synthsized on different silicon and architectures.
> 
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add Hans' ACK.
> ---
>  MAINTAINERS                                  |  2 +-
>  drivers/rtc/Kconfig                          | 10 +--
>  drivers/rtc/Makefile                         |  2 +-
>  drivers/rtc/{rtc-gemini.c => rtc-ftrtc010.c} | 91 ++++++++++++++--------------
>  4 files changed, 53 insertions(+), 52 deletions(-)
>  rename drivers/rtc/{rtc-gemini.c => rtc-ftrtc010.c} (62%)
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
