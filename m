Return-Path: <rtc-linux+bncBDKZNNNLXAHBBJWY4C5AKGQENSCUBYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id i191si227597pfe.1.2016.06.08.07.31.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 08 Jun 2016 07:31:02 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8G00D15IZMCR50@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 08 Jun 2016 15:30:58 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH v7 1/6] mfd: max8997: Use regmap to access registers
To: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
References: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
 <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
 <20160608142621.GG14888@dell>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, r.baldyga@hackerion.com,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <57582C1F.5040306@samsung.com>
Date: Wed, 08 Jun 2016 16:30:55 +0200
MIME-version: 1.0
In-reply-to: <20160608142621.GG14888@dell>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/08/2016 04:26 PM, Lee Jones wrote:
> On Wed, 01 Jun 2016, Krzysztof Kozlowski wrote:
> 
>> From: Robert Baldyga <r.baldyga@samsung.com>
>>
>> This patch modifies max8997 driver and each associated function driver,
>> to use regmap instead of operating directly on i2c bus. It will allow to
>> simplify IRQ handling using regmap-irq.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Bryan Wu <cooloney@gmail.com>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Acked-by: Sebastian Reichel <sre@kernel.org>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> [k.kozlowski: Collect acks, rebase on v4.6-rc6]
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>> ---
>>  drivers/extcon/extcon-max8997.c       |  31 ++++----
>>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
>>  drivers/leds/leds-max8997.c           |  13 ++--
>>  drivers/mfd/Kconfig                   |   1 +
>>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
>>  drivers/mfd/max8997.c                 | 141 +++++++++++++++-------------------
>>  drivers/power/max8997_charger.c       |  33 ++++----
>>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
> 
> Is it just Mark's Ack you require?

Yes, only Mark's is missing here. All other patches got everything they
need.

Best regards,
Krzysztof

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
