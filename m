Return-Path: <rtc-linux+bncBDKZNNNLXAHBBPE6Y2XAKGQEB5B2N7Q@googlegroups.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com. [2607:f8b0:400d:c04::232])
        by gmr-mx.google.com with ESMTPS id j14si1729875ywa.5.2015.08.17.00.37.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2015 00:37:32 -0700 (PDT)
Received: by mail-qg0-x232.google.com with SMTP id 62so88566828qgj.2
        for <rtc-linux@googlegroups.com>; Mon, 17 Aug 2015 00:37:32 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <SN1PR0301MB161656D00F33D665B6CD488B9D790@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1439370853-32282-1-git-send-email-dongsheng.wang@freescale.com>
	<SN1PR0301MB161656D00F33D665B6CD488B9D790@SN1PR0301MB1616.namprd03.prod.outlook.com>
Date: Mon, 17 Aug 2015 16:37:32 +0900
Message-ID: <CAJKOXPdLijdXT=UG42JzdA4spKz6z+9WEbkXrj-4hCk_v8WN8Q@mail.gmail.com>
Subject: Re: [rtc-linux] RE: [PATCH v2] rtc/ds3232: fix ds3232 get a WARNING
 trace in resume function
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com, Wang Dongsheng <Dongsheng.Wang@freescale.com>
Cc: "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>,
	"a.zummo@towertech.it" <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-08-17 16:10 GMT+09:00 Wang Dongsheng <Dongsheng.Wang@freescale.com>:
> Hi Alexandre,
>
> Could you apply this patch?

Give some time before pinging.

>
> Regards,
> -Dongsheng
>
>> -----Original Message-----
>> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
>> Sent: Wednesday, August 12, 2015 5:14 PM
>> To: alexandre.belloni@free-electrons.com
>> Cc: a.zummo@towertech.it; rtc-linux@googlegroups.com; linux-
>> kernel@vger.kernel.org; Wang Dongsheng-B40534
>> Subject: [PATCH v2] rtc/ds3232: fix ds3232 get a WARNING trace in resume
>> function
>>
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> If ds3232 work on some platform that is not implementation
>> irq_set_wake, ds3232 will get a WARNING trace in resume.
>> So fix ds3232->suspended state to false when irq_set_irq_wake
>> return error.
>>
>> ------------[ cut here ]------------

Please cut of the cut-here.

>> WARNING: CPU: 0 PID: 729 at kernel/irq/manage.c:604
>> irq_set_irq_wake+0x4b/0x8c()
>> Unbalanced IRQ 201 wake disable
>> Modules linked in:
>> CPU: 0 PID: 729 Comm: sh Not tainted 3.12.19-rt30+ #25
>> [<800107d9>] (unwind_backtrace+0x1/0x88) from [<8000e4ef>]
>> (show_stack+0xb/0xc)
>> [<8000e4ef>] (show_stack+0xb/0xc) from [<802b5fa9>]
>> (dump_stack+0x4d/0x60)
>> [<802b5fa9>] (dump_stack+0x4d/0x60) from [<800186dd>]
>> (warn_slowpath_common+0x45/0x64)
>> [<800186dd>] (warn_slowpath_common+0x45/0x64) from [<80018717>]
>> (warn_slowpath_fmt+0x1b/0x24)
>> [<80018717>] (warn_slowpath_fmt+0x1b/0x24) from [<8003a8d3>]
>> (irq_set_irq_wake+0x4b/0x8c)
>> [<8003a8d3>] (irq_set_irq_wake+0x4b/0x8c) from [<80204fcb>]
>> (ds3232_resume+0x2d/0x36)
>> [<80204fcb>] (ds3232_resume+0x2d/0x36) from [<801954c7>]
>> (dpm_run_callback.isra.13+0xb/0x28)
>> [<801954c7>] (dpm_run_callback.isra.13+0xb/0x28) from [<80195b1b>]
>> (device_resume+0x7b/0xa2)
>> [<80195b1b>] (device_resume+0x7b/0xa2) from [<80195f0f>]
>> (dpm_resume+0xbb/0x19c)
>> [<80195f0f>] (dpm_resume+0xbb/0x19c) from [<801960d9>]
>> (dpm_resume_end+0x9/0x12)
>> [<801960d9>] (dpm_resume_end+0x9/0x12) from [<80037e1d>]
>> (suspend_devices_and_enter+0x17d/0x1d0)
>> [<80037e1d>] (suspend_devices_and_enter+0x17d/0x1d0) from [<80037ee1>]
>> (pm_suspend+0x71/0x128)
>> [<80037ee1>] (pm_suspend+0x71/0x128) from [<80037449>]
>> (state_store+0x6d/0x80)
>> [<80037449>] (state_store+0x6d/0x80) from [<800af4d5>]
>> (sysfs_write_file+0x9f/0xde)
>> [<800af4d5>] (sysfs_write_file+0x9f/0xde) from [<8007a437>]
>> (vfs_write+0x7b/0x104)
>> [<8007a437>] (vfs_write+0x7b/0x104) from [<8007a7f7>]
>> (SyS_write+0x27/0x48)
>> [<8007a7f7>] (SyS_write+0x27/0x48) from [<8000c121>]
>> (ret_fast_syscall+0x1/0x44)
>> ---[ end trace 640959d2e8de6ccc ]---

The dmesg here is not readable. Please fix it. For example by not
wrapping it or removing unnecessary information like kernel addresses.

>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>> ---
>> *v2*
>> - Use dev_warn_once to instead of dev_info
>>
>> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
>> index 7e48e53..3554970 100644
>> --- a/drivers/rtc/rtc-ds3232.c
>> +++ b/drivers/rtc/rtc-ds3232.c
>> @@ -463,7 +463,10 @@ static int ds3232_suspend(struct device *dev)
>>
>>       if (device_can_wakeup(dev)) {
>>               ds3232->suspended = true;
>> -             irq_set_irq_wake(client->irq, 1);
>> +             if (irq_set_irq_wake(client->irq, 1)) {
>> +                     dev_warn_once(dev, "Can not set wakeup sources\n");

s/Can not/Cannot/
One wakeup source or multiple sources?

Best regards,
Krzysztof

>> +                     ds3232->suspended = false;
>> +             }
>>       }
>>
>>       return 0;
>> --
>> 2.1.0.27.g96db324
>
> --
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> ---
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

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
