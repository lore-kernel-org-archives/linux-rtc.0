Return-Path: <rtc-linux+bncBAABBOWGUC2QKGQEG6LWPQY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id tn7si478897pac.1.2016.01.26.17.54.01
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 17:54:01 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v3 07/10] rtc: max77686: Use dev_warn()
 instead of pr_warn()
To: Andi Shyti <andi.shyti@samsung.com>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-8-git-send-email-javier@osg.samsung.com>
 <20160127012230.GE14296@samsunx.samsung>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A82331.5050403@osg.samsung.com>
Date: Tue, 26 Jan 2016 22:53:53 -0300
MIME-Version: 1.0
In-Reply-To: <20160127012230.GE14296@samsunx.samsung>
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

Hello Andi,

Thanks a lot for your feedback and review.

On 01/26/2016 10:22 PM, Andi Shyti wrote:
> Hi Javier,
>
>>   		if (tm->tm_year < 100) {
>> -			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
>> -				1900 + tm->tm_year);
>> +			dev_warn(info->dev,
>> +				 "RTC can't handle year %d. Assume it's 2000\n",
>> +				 1900 + tm->tm_year);
>>   			return -EINVAL;
>
> Because we are returning an error value, why not use dev_err()?
>

You are absolutely right. Since the driver was using pr_warn(), I used
dev_warn() but dev_err() would had been correct.

If you don't mind I plan to do it as a follow up patch to avoid having
to resend the whole series only for this change.
  
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
