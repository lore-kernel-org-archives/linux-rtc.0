Return-Path: <rtc-linux+bncBDKZNNNLXAHBBYM2R62AKGQEPO7ESTQ@googlegroups.com>
Received: from mail-io0-x235.google.com (mail-io0-x235.google.com. [2607:f8b0:4001:c06::235])
        by gmr-mx.google.com with ESMTPS id mv7si2986865igb.0.2015.12.30.04.26.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 04:26:09 -0800 (PST)
Received: by mail-io0-x235.google.com with SMTP id 1so24147966ion.1
        for <rtc-linux@googlegroups.com>; Wed, 30 Dec 2015 04:26:09 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <5683AE8C.2050204@samsung.com>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
	<1451450847-928-3-git-send-email-k.kozlowski@samsung.com>
	<5683AE8C.2050204@samsung.com>
Date: Wed, 30 Dec 2015 21:26:09 +0900
Message-ID: <CAJKOXPcf9uESKeEZS1+fSwuWRVWw=11tRNssk6oc46KQZk4yRQ@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH v2 3/3] rtc: s5m: Make register
 configuration per S2MPS device to remove exceptions
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Yadwinder Singh Brar <yadi.brar01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2015-12-30 19:14 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
>
> Hi Krzysztof,
>
> On 12/30/2015 10:17 AM, Krzysztof Kozlowski wrote:
>>
>> Before updating time and alarm the driver must set appropriate mask in
>> UDR register. For that purpose the driver uses common register
>> configuration and a lot of exceptions per device in the code. The
>> exceptions are not obvious, for example except the change in the logic
>> sometimes the fields are swapped (WUDR and AUDR between S2MPS14 and
>> S2MPS15). This leads to quite complicated code.
>>
>> Try to make it more obvious by:
>> 1. Documenting the UDR masks for devices and operations.
>> 2. Adding fields in register configuration structure for each operation
>>     (read time, write time and alarm).
>> 3. Splitting the configuration per S2MPS13, S2MPS14 and S2MPS15 thus
>>     removing exceptions for them.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
> Tested for s2mps15 pmic on exynos7-espresso board. rtc and timer works as expected.
> Fill free to add
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
>

Thank you, I really appreciate this!

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
