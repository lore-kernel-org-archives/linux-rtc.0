Return-Path: <rtc-linux+bncBDKZNNNLXAHBB5XUX22AKGQEDBIURXA@googlegroups.com>
Received: from mail-ig0-x243.google.com (mail-ig0-x243.google.com. [2607:f8b0:4001:c05::243])
        by gmr-mx.google.com with ESMTPS id ti5si1033155igb.2.2016.01.08.05.32.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 05:32:37 -0800 (PST)
Received: by mail-ig0-x243.google.com with SMTP id mw1so7765525igb.2
        for <rtc-linux@googlegroups.com>; Fri, 08 Jan 2016 05:32:37 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <568FB757.9080303@nvidia.com>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
	<1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
	<CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
	<568F7E7B.1010501@nvidia.com>
	<568FB62C.9020109@samsung.com>
	<568FB757.9080303@nvidia.com>
Date: Fri, 8 Jan 2016 22:32:37 +0900
Message-ID: <CAJKOXPfOKoV2A1NMyyL5kc=3v6eyTS2T4tRmqM_0=3jBoAZiNg@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rtc-linux@googlegroups.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
	Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-01-08 22:19 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
>
> On Friday 08 January 2016 06:44 PM, Krzysztof Kozlowski wrote:
>>
>>
>> To avoid compilation warning,  I need to use inline here.
>> Because this shouldn't be defined in header at the first place. Instead
>> define it in main MFD driver with EXPORT_SYMBOL() and put in headers
>> just declaration.
>>
> what about __maybe_unused instead on inline and keep in header.
>
> Anyhow, I do not have any personal choice here.

This just shouldn't be defined in header because that makes it
spreading over many object files. There are just no benefits.

Best regards,
Krzysztof

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
