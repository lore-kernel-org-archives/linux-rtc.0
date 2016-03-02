Return-Path: <rtc-linux+bncBCQJP74GSUDRBRHJ3K3AKGQETCFPGKI@googlegroups.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com. [2607:f8b0:4001:c06::243])
        by gmr-mx.google.com with ESMTPS id p10si310155igg.1.2016.03.02.01.39.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 01:39:15 -0800 (PST)
Received: by mail-io0-x243.google.com with SMTP id m184so924991iof.3
        for <rtc-linux@googlegroups.com>; Wed, 02 Mar 2016 01:39:15 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <mvmwpplns8n.fsf@hawking.suse.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
	<1456851608-3374907-2-git-send-email-arnd@arndb.de>
	<CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
	<mvmwpplns8n.fsf@hawking.suse.de>
Date: Wed, 2 Mar 2016 10:39:15 +0100
Message-ID: <CAMuHMdX2Jc4dT5omKmiie7GK+xDYDgJwm34hwANx3HzHt7LzxA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/6] rtc: generic: allow building on all architectures
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kyle McMartin <kyle@mcmartin.ca>,
	RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	Parisc List <linux-parisc@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Mar 2, 2016 at 10:28 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>>> +#else
>>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>>> +#endif
>>>
>>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>>  {
>>>         struct rtc_device *rtc;
>>> +       const struct rtc_class_ops *ops;
>>> +
>>> +       ops = dev_get_platdata(&dev->dev);
>>> +       if (!ops)
>>> +               ops = &generic_rtc_ops;
>>
>> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
>> undefined behavior?
>
> Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
> the operand is the result of a unary * operator, neither that operator
> nor the & operator is evaluated and the result is as if both were
> omitted).

Thanks for confirming.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
