Return-Path: <rtc-linux+bncBDS7HNEFSALRBBHC4G2QKGQETTD7QDI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si348898wmw.3.2016.02.08.02.42.11
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Feb 2016 02:42:12 -0800 (PST)
Date: Mon, 8 Feb 2016 11:42:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, k.kozlowski@samsung.com, javier@osg.samsung.com,
	broonie@kernel.org, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, cw00.choi@samsung.com,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V4 6/6] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
Message-ID: <20160208104211.GQ4782@piout.net>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
 <1454769447-785-7-git-send-email-ldewangan@nvidia.com>
 <56B86BD6.2010607@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56B86BD6.2010607@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/02/2016 at 15:50:06 +0530, Laxman Dewangan wrote :
> 
> On Saturday 06 February 2016 08:07 PM, Laxman Dewangan wrote:
> >-	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
> >-					max77686_rtc_alarm_irq, 0,
> >-					"rtc-alarm1", info);
> >-	if (ret < 0)
> >+	ret = request_threaded_irq(info->virq, NULL, max77686_rtc_alarm_irq, 0,
> >+				   "rtc-alarm1", info);
> >+	if (ret < 0) {
> >  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> >  			info->virq, ret);
> >+		goto err_rtc;
> >+	}
> >+
> >+	return 0;
> >  err_rtc:
> 
> Oops.. I wish I should have called regmap_irq_put_virq(info->virq); here.
> 
> Please let me know if I can respin this patch only instead of entire series.
> 

Sure, you can.

> 

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
