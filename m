Return-Path: <rtc-linux+bncBD6MT7EH5AARBUPE3K3AKGQESMKDN3A@googlegroups.com>
Received: from mail-out.m-online.net (mail-out.m-online.net. [212.18.0.9])
        by gmr-mx.google.com with ESMTPS id 71si23870wmp.0.2016.03.02.01.28.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 01:28:49 -0800 (PST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,  Alexandre Belloni <alexandre.belloni@free-electrons.com>,  "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,  Kyle McMartin <kyle@mcmartin.ca>,  RTCLINUX <rtc-linux@googlegroups.com>,  Alessandro Zummo <a.zummo@towertech.it>,  "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,  Linux-sh list <linux-sh@vger.kernel.org>,  Parisc List <linux-parisc@vger.kernel.org>,  linux-m68k <linux-m68k@lists.linux-m68k.org>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 1/6] rtc: generic: allow building on all architectures
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
	<1456851608-3374907-2-git-send-email-arnd@arndb.de>
	<CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
Date: Wed, 02 Mar 2016 10:28:40 +0100
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
	(Geert Uytterhoeven's message of "Wed, 2 Mar 2016 09:57:27 +0100")
Message-ID: <mvmwpplns8n.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> +#else
>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>> +#endif
>>
>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>  {
>>         struct rtc_device *rtc;
>> +       const struct rtc_class_ops *ops;
>> +
>> +       ops = dev_get_platdata(&dev->dev);
>> +       if (!ops)
>> +               ops = &generic_rtc_ops;
>
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
the operand is the result of a unary * operator, neither that operator
nor the & operator is evaluated and the result is as if both were
omitted).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

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
