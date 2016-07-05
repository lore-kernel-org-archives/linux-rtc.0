Return-Path: <rtc-linux+bncBDKZNNNLXAHBB37J5W5QKGQECYI4QAQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id i135si338023pfe.0.2016.07.05.01.50.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 01:50:54 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O9U00LA938Q1X60@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 05 Jul 2016 09:50:50 +0100 (BST)
Subject: [rtc-linux] Re: [RFC PATCH 1/2] rtc: s3c: Remove unnecessary call to
 disable already disabled clock
To: Alim Akhtar <alim.akhtar@samsung.com>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
 <577B5F28.1010905@samsung.com> <577B73FE.1020509@samsung.com>
Cc: alexandre.belloni@free-electrons.com, javier@osg.samsung.com,
 pankaj.dubey@samsung.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <577B74E8.3010208@samsung.com>
Date: Tue, 05 Jul 2016 10:50:48 +0200
MIME-version: 1.0
In-reply-to: <577B73FE.1020509@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/05/2016 10:46 AM, Alim Akhtar wrote:
> Hi Krzsztof,
> 
> On 07/05/2016 12:48 PM, Krzysztof Kozlowski wrote:
>> On 07/04/2016 01:03 PM, Alim Akhtar wrote:
>>> At the end of s3c_rtc_probe(), s3c_rtc_disable_clk() being called
>>> with rtc
>>> clock already disabled, which looks extra and unnecessary call.
>>> Lets clean it up.
>>
>> Does not look right. Till that place, the clocks are enabled. Then
>> s3c_rtc_setaie() is called which expects that clocks are disabled...
>> otherwise counters get mixed.
>>
> 
> The clock is always disabled when it reach s3c_rtc_setfreq() in probe(),
> because s3c_rtc_gettime() will always disable the clock.
> 
> As far as s3c_rtc_setaie() is concern, it enables clock while entering
> and disables it while leaving the function. And in
> s3c_rtc_{enable,disable}_clk() there is check info->clk_disabled flag
> which will make sure clock balancing.

Ah, you're right. Looks correct although the information that clock is
disabled because of s3c_rtc_gettime() would be useful in the commit message.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
