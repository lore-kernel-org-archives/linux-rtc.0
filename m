Return-Path: <rtc-linux+bncBD2OLRXW4ABBBYENTC2QKGQEHVNHBZA@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id 190si2154924pfb.1.2016.01.25.03.28.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:28:32 -0800 (PST)
Message-ID: <56A60451.1080309@nvidia.com>
Date: Mon, 25 Jan 2016 16:47:37 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-kernel@vger.kernel.org>
CC: Kukjin Kim <kgene@kernel.org>, <rtc-linux@googlegroups.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 03/10] rtc: max77686: Use usleep_range()
 instead of msleep()
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com> <1453407813-14646-4-git-send-email-javier@osg.samsung.com> <56A1F935.2040904@nvidia.com> <56A21B1D.8030303@osg.samsung.com>
In-Reply-To: <56A21B1D.8030303@osg.samsung.com>
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


On Friday 22 January 2016 05:35 PM, Javier Martinez Canillas wrote:
> Hello Laxman,
>
> On 01/22/2016 06:41 AM, Laxman Dewangan wrote:
>>
>> On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>>>       RTC_SEC = 0,
>>> @@ -130,7 +130,8 @@ static int max77686_rtc_update(struct 
>>> max77686_rtc_info *info,
>>>                   __func__, ret, data);
>>>       else {
>>>           /* Minimum 16ms delay required before RTC update. */
>>> -        msleep(MAX77686_RTC_UPDATE_DELAY);
>>> +        usleep_range(MAX77686_RTC_UPDATE_DELAY,
>>> +                 MAX77686_RTC_UPDATE_DELAY * 2);
>>>       }
>>>
>>
>> Instead of making usleep_range(16000, 32000), can we make small range as
>> usleep_range(16000, 17000)?
>>
>
> Yes, I also didn't know how to make the delay smaller. If I do for 
> example
>
> usleep_range(delay, delay + 10000), then the 10000 delta would be too big
> for max77802 (50 times the minimum required 200 delay).
>
> So I used delay * 2 for two reasons:
>
> 1) That way is generic enough and can work for any delay
>
> 2) My understanding is that most of times the delay should be precise and
>    is not that bad if sometimes the delay is the worst case (2 * X) since
>    after all the delay is the minimum required.
>
> I also see that usleep_range(X, X * 2) is a used pattern across the 
> kernel.

OK, fine to me here.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

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
