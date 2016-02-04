Return-Path: <rtc-linux+bncBDS7HNEFSALRB3NKZ62QKGQE47465GA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q64si839013wmg.0.2016.02.04.14.49.17
        for <rtc-linux@googlegroups.com>;
        Thu, 04 Feb 2016 14:49:17 -0800 (PST)
Date: Thu, 4 Feb 2016 23:49:06 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	ldewangan@nvidia.com, javier@osg.samsung.com
Subject: [rtc-linux] Re: [PATCH] rtc: max77686: Properly handle
 regmap_irq_get_virq() error code
Message-ID: <20160204224906.GD4782@piout.net>
References: <1454545595-31725-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454545595-31725-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/02/2016 at 09:26:35 +0900, Krzysztof Kozlowski wrote :
> The regmap_irq_get_virq() can return 0 or -EINVAL in error conditions
> but driver checked only for value of 0.
> 
> This could lead to a cast of -EINVAL to an unsigned int used as a
> interrupt number for devm_request_threaded_irq(). Although this is not
> yet fatal (devm_request_threaded_irq() will just fail with -EINVAL) but
> might be a misleading when diagnosing errors.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq")
> 
> ---
> 
> Patch rebased on current mainline, not RTC tree, because IMHO it is
> a candidate for current RC-cycle.
> 
> Not marking cc-stable because behavior is not fatal - unless there is
> an interrupt with number 4294967274 (then it would be successfully
> requested for RTC driver).
> ---
>  drivers/rtc/rtc-max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
