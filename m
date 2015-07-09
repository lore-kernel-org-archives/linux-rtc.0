Return-Path: <rtc-linux+bncBCMNZUWXYYORBGGD7GWAKGQE4MCY4GI@googlegroups.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com. [209.85.220.43])
        by gmr-mx.google.com with ESMTPS id ct6si591644pdb.1.2015.07.09.04.57.12
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 04:57:12 -0700 (PDT)
Received: by pacws9 with SMTP id ws9so151140737pac.0
        for <rtc-linux@googlegroups.com>; Thu, 09 Jul 2015 04:57:12 -0700 (PDT)
Message-ID: <559E6191.3050202@linaro.org>
Date: Thu, 09 Jul 2015 17:27:05 +0530
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
References: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org> <20150709115533.GY3127@piout.net>
In-Reply-To: <20150709115533.GY3127@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On Thursday 09 July 2015 05:25 PM, Alexandre Belloni wrote:
> Hi,
>
> On 09/07/2015 at 12:25:51 +0530, Vaibhav Hiremath wrote :
>> Along with DT support, this patch also cleans up the unnecessary
>> code around 'rtc_wakeup' initialization.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> No need to resend, I'll take it. I'm current busy with other things and
> it is still early in the development cycle.
>

Thanks,

And sorry for noise,
I was not so sure about the status, so resent it.


>> -	if (pm80x_pdata) {
>> -		pdata = pm80x_pdata->rtc;
>> -		if (pdata)
>> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
>> -	}
>> +	/* remeber whether this power up is caused by PMIC RTC or not */
>
> I'll fix that typo...
>

Oops. Thankks for noting and correcting it.

Thanks,
Vaibhav

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
