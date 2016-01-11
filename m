Return-Path: <rtc-linux+bncBDKZNNNLXAHBBCEWZW2AKGQE2C7EJ3A@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id a76si1663008pfj.2.2016.01.10.22.26.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jan 2016 22:26:16 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0R000VDZ7ORV30@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 11 Jan 2016 06:26:12 +0000 (GMT)
Subject: Re: [rtc-linux] [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
To: Lee Jones <lee.jones@linaro.org>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
 <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
 <20160111054627.GB3331@x1>
Cc: rtc-linux@googlegroups.com, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
 Laxman Dewangan <ldewangan@nvidia.com>, Chaitanya Bandi <bandik@nvidia.com>,
 Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56934AFD.5060008@samsung.com>
Date: Mon, 11 Jan 2016 15:26:05 +0900
MIME-version: 1.0
In-reply-to: <20160111054627.GB3331@x1>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11.01.2016 14:46, Lee Jones wrote:
> On Fri, 08 Jan 2016, Krzysztof Kozlowski wrote:
> 
> Thanks for taking the time to review.
> 
>> ()2016-01-07 23:38 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
>>> MAX77620/MAX20024 are Power Management IC from the MAXIM.
>>> It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
>>> watchdog, clock etc.
>>>
>>> Add MFD drier to provides common support for accessing the
>>> device; additional drivers is developed on respected subsystem
>>> in order to use the functionality of the device.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
>>> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
>>> Tested-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
>>
>> The Testing and Reviewed are statements (see SubmittingPatches) so
>> they should be made explicitly by people. As this is v1 how they could
>> make a public statement so far?
> 
> SubmittingPatches bears no mention that Reviewed-by/Tested-by
> statements have to be provided on one of the public mailing lists.
> These can be provided privately prior to upstream submission v1.

Indeed the document does not mention that they have to be provided by
public.

In the same time these are statements given by a reviewer ("By offering
my Reviewed-by: tag, I state that:")... and how can you validate a
statement given through a private channel? Is it true? Is it a thorough
testing or just copy-paste from Gerrit (or other automated system)?

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
