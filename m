Return-Path: <rtc-linux+bncBDKZNNNLXAHBBCMMVS2AKGQELNCRWEI@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id q192si6633290pfq.2.2016.01.04.15.53.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jan 2016 15:53:45 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0G00JEXD1G6G00@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 04 Jan 2016 23:53:40 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: s5m: Cleanup by removing useless
 'rtc' prefix from fields
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
 <20160104170841.GD32724@piout.net>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Lee Jones <lee.jones@linaro.org>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Yadwinder Singh Brar <yadi.brar01@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <568B0601.5020808@samsung.com>
Date: Tue, 05 Jan 2016 08:53:37 +0900
MIME-version: 1.0
In-reply-to: <20160104170841.GD32724@piout.net>
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

On 05.01.2016 02:08, Alexandre Belloni wrote:
> Hi,
> 
> On 30/12/2015 at 13:47:25 +0900, Krzysztof Kozlowski wrote :
>> Remove the 'rtc' prefix from some of the fields in struct
>> s5m_rtc_reg_config because it is obvious - this is a RTC driver. No
>> functional changes.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
> 
> I was going to apply those patches but they don't apply cleanly on
> rtc-next. Did I miss something?
> 

Probably that's my fault because I rebased it on linux-next. I will
rebase the patches on rtc-next and resend.

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
