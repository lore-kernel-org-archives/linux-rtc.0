Return-Path: <rtc-linux+bncBD2OLRXW4ABBBC654G2QKGQE2EAWBEI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id u66si4400452pfa.2.2016.02.08.02.31.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2016 02:31:39 -0800 (PST)
Message-ID: <56B86BD6.2010607@nvidia.com>
Date: Mon, 8 Feb 2016 15:50:06 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V4 6/6] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com> <1454769447-785-7-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1454769447-785-7-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Saturday 06 February 2016 08:07 PM, Laxman Dewangan wrote:
> -	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
> -					max77686_rtc_alarm_irq, 0,
> -					"rtc-alarm1", info);
> -	if (ret < 0)
> +	ret = request_threaded_irq(info->virq, NULL, max77686_rtc_alarm_irq, 0,
> +				   "rtc-alarm1", info);
> +	if (ret < 0) {
>   		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>   			info->virq, ret);
> +		goto err_rtc;
> +	}
> +
> +	return 0;
>   
>   err_rtc:

Oops.. I wish I should have called regmap_irq_put_virq(info->virq); here.

Please let me know if I can respin this patch only instead of entire series.


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
