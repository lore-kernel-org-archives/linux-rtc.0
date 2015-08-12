Return-Path: <rtc-linux+bncBDEZ72H55YIBBO5ZVKXAKGQEB7I33ZY@googlegroups.com>
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id ff6si437004pac.2.2015.08.11.18.09.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 18:09:14 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSY021U437CNA60@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 12 Aug 2015 10:09:12 +0900 (KST)
Message-id: <55CA9CB9.1050007@samsung.com>
Date: Wed, 12 Aug 2015 10:09:13 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com
Subject: [rtc-linux] Re: [PATCH 4/4] rtc: s3c: enable/disable clocks for alarm
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
 <1439292502-22912-4-git-send-email-jy0922.shim@samsung.com>
 <55CA9330.9070700@samsung.com>
In-reply-to: <55CA9330.9070700@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 08/12/2015 09:28 AM, Krzysztof Kozlowski wrote:
> On 11.08.2015 20:28, Joonyoung Shim wrote:
>> The clock enable/disable codes for alarm have removed from
> 
> What do you mean in this paragraph? The clock code was removing something?
> 
>> 'commit 24e1455493da ("drivers/rtc/rtc-s3c.c: delete duplicate clock
> 
> Remove the 'apostrophe.
> 
>> control")' and the clocks keep disabling even if alarm is set, so alarm
>> interrupt can't happen.
> ...and the clocks are disabled even...
> 
> 
>>
>> The s3c_rtc_setaie function can be called several times with that
>> enabled argument has same value,
> ...several times with 'enabled' argument having same value
> 
>> so it needs to check whether clocks is
>> enabled or not.
> s/is/are/
> 
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> Please add Cc-stable and fixes tag. To backport the patch probably
> you'll have to remove the dependency on previous patches.

Thanks for the point, i didn't think it.

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
