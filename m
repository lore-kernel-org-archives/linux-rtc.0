Return-Path: <rtc-linux+bncBDKZNNNLXAHBBH4RVS2AKGQE42S7ITQ@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id dz2si2769610pab.1.2016.01.04.16.04.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jan 2016 16:04:46 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0G00MODDJUZZ00@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 05 Jan 2016 00:04:42 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: s5m: Cleanup by removing useless
 'rtc' prefix from fields
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
 <20160104170841.GD32724@piout.net> <568B0601.5020808@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Lee Jones <lee.jones@linaro.org>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Yadwinder Singh Brar <yadi.brar01@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <568B0897.4020403@samsung.com>
Date: Tue, 05 Jan 2016 09:04:39 +0900
MIME-version: 1.0
In-reply-to: <568B0601.5020808@samsung.com>
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

On 05.01.2016 08:53, Krzysztof Kozlowski wrote:
> On 05.01.2016 02:08, Alexandre Belloni wrote:
>> Hi,
>>
>> On 30/12/2015 at 13:47:25 +0900, Krzysztof Kozlowski wrote :
>>> Remove the 'rtc' prefix from some of the fields in struct
>>> s5m_rtc_reg_config because it is obvious - this is a RTC driver. No
>>> functional changes.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>
>> I was going to apply those patches but they don't apply cleanly on
>> rtc-next. Did I miss something?
>>
> 
> Probably that's my fault because I rebased it on linux-next. I will
> rebase the patches on rtc-next and resend.

Ah, no need for rebasing. I forgot about dependency - the support for
S2MPS15 was added recently through Lee Jones' tree. Fortunately Lee put
S2MPS15 patches in a separate branch and tag: "ib-mfd-regulator-rtc-4.5"

This means that to apply the patches this is needed first:
https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-regulator-rtc-4.5

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
