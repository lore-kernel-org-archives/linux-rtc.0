Return-Path: <rtc-linux+bncBDE6RCFOWIARBJWNVW4AKGQE5VZYCAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com. [2607:f8b0:4003:c06::233])
        by gmr-mx.google.com with ESMTPS id k3si835193igt.1.2016.04.11.01.56.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 01:56:06 -0700 (PDT)
Received: by mail-oi0-x233.google.com with SMTP id y204so199533659oie.3
        for <rtc-linux@googlegroups.com>; Mon, 11 Apr 2016 01:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460361266-20664-1-git-send-email-linus.walleij@linaro.org>
References: <1460361266-20664-1-git-send-email-linus.walleij@linaro.org>
Date: Mon, 11 Apr 2016 10:56:05 +0200
Message-ID: <CACRpkdZVg0YmayO_Jioik0qXkemge77UdxXUVyY=NZBTxA8Tww@mail.gmail.com>
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

On Mon, Apr 11, 2016 at 9:54 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> commit 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
> introduced the dev_pm_set_wake_irq() call to register a wake
> IRQ for the AB8500 driver.
>
> However this causes a regression since device_init_wakeup() must be
> called *after* dev_pm_set_wake_irq() not *before* it. Before this
> patch we get an error message like this during system resume from
> sleep:

Bah it seems this is not the real problem :(

We end up with unbalanced wake disable for some totally
different reason, maybe in the core.

Drop this patch for now.

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
