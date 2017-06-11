Return-Path: <rtc-linux+bncBDE6RCFOWIARBT4A67EQKGQEI667GDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x235.google.com (mail-it0-x235.google.com. [2607:f8b0:4001:c0b::235])
        by gmr-mx.google.com with ESMTPS id q80si38119itb.4.2017.06.11.15.12.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jun 2017 15:12:31 -0700 (PDT)
Received: by mail-it0-x235.google.com with SMTP id m62so16985361itc.0
        for <rtc-linux@googlegroups.com>; Sun, 11 Jun 2017 15:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530075332.3740-1-linus.walleij@linaro.org>
References: <20170530075332.3740-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Jun 2017 00:12:30 +0200
Message-ID: <CACRpkdZdm=DtiHCRaLxGL0BE8LfsV+qxyZNVyS4e+kf3HsXn7Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/3 v2] rtc: gemini: Add optional clock handling
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, May 30, 2017 at 9:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

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

Alessandro, Alexandre:
Is this v2 series fine, or do I need to fix something?

Just restless, sorry ...

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
