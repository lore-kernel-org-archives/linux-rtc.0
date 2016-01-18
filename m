Return-Path: <rtc-linux+bncBDKZNNNLXAHBBTGR6G2AKGQEO3L7Q6Q@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id jj4si2455712pac.2.2016.01.17.20.23.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 20:23:40 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1400IJTS7BM130@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 18 Jan 2016 04:23:35 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 5/6] rtc: max77xxx: add RTC driver for
 Maxim MAX77xxx series RTC IP
To: Mark Brown <broonie@kernel.org>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-6-git-send-email-ldewangan@nvidia.com>
 <569594F0.4020007@samsung.com> <5695CD73.5010709@nvidia.com>
 <5695D268.3060705@samsung.com> <5695D1AF.9000806@nvidia.com>
 <5696665A.5030508@nvidia.com> <5696F0C4.1060904@samsung.com>
 <5696F7F8.108@samsung.com> <20160114142048.GS6588@sirena.org.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com, swarren@nvidia.com,
 treding@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <569C68BE.3030804@samsung.com>
Date: Mon, 18 Jan 2016 13:23:26 +0900
MIME-version: 1.0
In-reply-to: <20160114142048.GS6588@sirena.org.uk>
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

On 14.01.2016 23:20, Mark Brown wrote:
> On Thu, Jan 14, 2016 at 10:20:56AM +0900, Krzysztof Kozlowski wrote:
> 
>> 2. It has different register address.
>>    We need a register-layout/configuration structure. The logic is the
>> same except few differences (e.g. presence of MAX77802_RTC_AE1).
> 
> Depending on what the differences are either just some variables in the
> driver data that get set on probe with the different registers (if it's
> just the register) or using regmap_field (if things get shifted as well,
> or if it happens to make more sense) should work.

Thanks for the hints!

The addresses for registers are indeed shifted. It is non-linear because
apart of different offset at beginning, a new field appears. Anyway it
would be good for me (or other person doing this work) to get more
knowledge of what regmap API provides.

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
