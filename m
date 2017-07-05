Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFVH6XFAKGQEHBWRA7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o207si1639042wme.0.2017.07.05.14.01.09
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Jul 2017 14:01:09 -0700 (PDT)
Date: Wed, 5 Jul 2017 23:01:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3 v2] rtc: gemini: Add optional clock handling
Message-ID: <20170705210109.mdallygdkpzqgazh@piout.net>
References: <20170530075332.3740-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170530075332.3740-1-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30/05/2017 at 09:53:30 +0200, Linus Walleij wrote:
> This makes the Gemini optionally take two clock references to
> the PCLK and EXTCLK. As we are adding a clock framework to the
> Gemini platform we need to make sure that we get the right
> references.
> 
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use devm_clk_get() so we do not leave dangling clocks
>   behind.
> - Add Hans' ACK.
> ---
>  drivers/rtc/rtc-gemini.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
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
