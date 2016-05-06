Return-Path: <rtc-linux+bncBCV3BI7CVEDRBFVAWG4QKGQE7E4DKUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id d141si2619742pfd.1.2016.05.06.01.04.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 01:04:38 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O6Q00BL9X3MIX10@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 06 May 2016 09:04:34 +0100 (BST)
Message-id: <572C5010.1090102@samsung.com>
Date: Fri, 06 May 2016 10:04:32 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>, Lee Jones <lee.jones@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, r.baldyga@hackerion.com,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v6 2/9] mfd: max8997: Use regmap to access registers
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Krzysztof,

On 05/06/2016 09:27 AM, Krzysztof Kozlowski wrote:
> From: Robert Baldyga <r.baldyga@samsung.com>
>
> This patch modifies max8997 driver and each associated function driver,
> to use regmap instead of operating directly on i2c bus. It will allow to
> simplify IRQ handling using regmap-irq.
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> [For extcon part]
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> [For leds part]
> Acked-by: Bryan Wu <cooloney@gmail.com>
>

Since I've replaced Bryan on the position of LED subsystem maintainer
feel free to use my ack:

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski

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
