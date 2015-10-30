Return-Path: <rtc-linux+bncBD747RFBYUPBBPXOZSYQKGQE5YAFZRY@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id vy6si632048pbc.1.2015.10.30.02.24.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 02:24:14 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NX1008ZQ0SCEJD0@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 30 Oct 2015 18:24:12 +0900 (KST)
Message-id: <56333771.4040507@samsung.com>
Date: Fri, 30 Oct 2015 14:55:05 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>,
 devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 1/4] dt-bindings: mfd: s2mps11: add
 documentation for s2mps15 PMIC
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-2-git-send-email-alim.akhtar@samsung.com>
 <56331F55.3060308@samsung.com>
In-reply-to: <56331F55.3060308@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On 10/30/2015 01:12 PM, Krzysztof Kozlowski wrote:
> On 30.10.2015 15:25, Alim Akhtar wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add dt-binding documentation for s2mps15 PMIC device. The s2mps15 device
>> is similar to s2mps11/14 PMIC device and has 27 LDO and 10 buck regulators.
>> This also supports RTC and three 32.768KHz clock outputs.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/s2mps11.txt |   21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
Thanks Krzysztof.

> Best regards,
> Krzysztof
>
>

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
