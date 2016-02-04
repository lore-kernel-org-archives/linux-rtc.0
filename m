Return-Path: <rtc-linux+bncBD2OLRXW4ABBBWONZS2QKGQE7PDCSVA@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si1369219pab.0.2016.02.04.02.24.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 02:24:25 -0800 (PST)
Message-ID: <56B3242E.1060504@nvidia.com>
Date: Thu, 4 Feb 2016 15:43:02 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>, <javier@osg.samsung.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com> <1454507233-9959-6-git-send-email-ldewangan@nvidia.com> <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com> <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com>
In-Reply-To: <56B314F4.6010605@samsung.com>
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


On Thursday 04 February 2016 02:38 PM, Krzysztof Kozlowski wrote:
> On 04.02.2016 15:58, Krzysztof Kozlowski wrote:
>> On 04.02.2016 11:03, Laxman Dewangan wrote:
>>> 3. Can you try locally to not use devm_regmap_init_i2c() and just use
>>> the regmap_init_i2c() and proper removal of this from error path and
>>> remove callback?
>> I'll try to find some time for that. Maybe tomorrow.
> regmap_init_i2c does not help. However helps commenting out the:
> 	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
> from remove() callback.
>
>

Thanks for debugging.  I do not see anything on regmap_del_irq_chip() 
which can be suspected. Is this because of sharing interrupt between mfd 
and rtc driver?

What is your suggestion here?  Should we avoid this inside RTC driver 
(creating this in mfd) and pass this information to the rtc driver using 
customized platform driver?

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
