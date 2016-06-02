Return-Path: <rtc-linux+bncBDE6RCFOWIARBFPWYC5AKGQEM4V5ETY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com. [2607:f8b0:4003:c06::236])
        by gmr-mx.google.com with ESMTPS id p65si1509695itb.1.2016.06.02.06.56.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2016 06:56:37 -0700 (PDT)
Received: by mail-oi0-x236.google.com with SMTP id e72so76267299oib.1
        for <rtc-linux@googlegroups.com>; Thu, 02 Jun 2016 06:56:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org>
References: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org>
Date: Thu, 2 Jun 2016 15:56:36 +0200
Message-ID: <CACRpkdYNus_ck2bAoU=KhrGGp_0VbOGPtmzGxd9nHa2ZPt8+9g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ab8500: move device_init_wakeup() call
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Linus Walleij <linus.walleij@linaro.org>,
	stable <stable@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jun 2, 2016 at 3:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> commit 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
> introduced the dev_pm_set_wake_irq() call to register a wake
> IRQ for the AB8500 driver.

If this looks like a deja vu it is because I sent it before, then thought my
suspend/resume bugs were due to something else, fixed the other things,
and return to the conclusion that this patch is indeed needed too.

Sorry if it's confusing, please apply this patch.

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
