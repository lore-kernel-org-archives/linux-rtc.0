Return-Path: <rtc-linux+bncBDT6DFON3EBBB3USUG2QKGQEQEFLDDI@googlegroups.com>
Received: from mail-yk0-x242.google.com (mail-yk0-x242.google.com. [2607:f8b0:4002:c07::242])
        by gmr-mx.google.com with ESMTPS id y4si429352ywd.7.2016.01.26.20.37.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 20:37:02 -0800 (PST)
Received: by mail-yk0-x242.google.com with SMTP id k129so16298841yke.3
        for <rtc-linux@googlegroups.com>; Tue, 26 Jan 2016 20:37:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56A84636.2000107@samsung.com>
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
	<1453865806-4661-7-git-send-email-javier@osg.samsung.com>
	<56A84636.2000107@samsung.com>
Date: Wed, 27 Jan 2016 01:37:02 -0300
Message-ID: <CABxcv=n56YU4fFzdQkVD1EOdc9Q7Dfm1Qa0u5v9HPw1BYev8mg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 06/10] rtc: max77686: Add max77802 support
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
	Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
	Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
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

Hello Krzysztof,

On Wed, Jan 27, 2016 at 1:23 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 27.01.2016 12:36, Javier Martinez Canillas wrote:

[snip]

>>
>> +     if (!info->drv_data->separate_i2c_addr)
>> +             info->max77686->rtc_regmap = info->max77686->regmap;
>> +
>
> At this stage I don't like the idea of messing with parent's state
> structure. The driver should not modify any of parents data (the best
> way would be to take a pointer to const). In this patch this looks like
> breaking the encapsulation. If the parent is responsible for regmaps,
> then the parent should set rtc_regmap for children (parent also knows
> what type device it is working on).
>
> ...but I am assuming that a new patch will be following this one - the
> patch moving ownership of i2c dummy and regmap to the RTC driver. In
> that case this code makes a lot more sense. Am I thinking correctly?
>

You assumption is correct.

Modifying the parent's state is indeed a layering violation but I did
this to keep the changes self contained in the RTC subsystem and avoid
touching the MFD driver.

But this will be cleaned by Laxman once he moves the regmap
initialization from the MFD driver to the RTC.

> Best regards,
> Krzysztof

Best regards,
Javier

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
