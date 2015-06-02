Return-Path: <rtc-linux+bncBCMNZUWXYYORBK65WWVQKGQE5R2RN7Q@googlegroups.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com. [209.85.192.179])
        by gmr-mx.google.com with ESMTPS id x3si1792685pdh.2.2015.06.02.01.51.54
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 01:51:54 -0700 (PDT)
Received: by pdbnf5 with SMTP id nf5so67261571pdb.2
        for <rtc-linux@googlegroups.com>; Tue, 02 Jun 2015 01:51:54 -0700 (PDT)
Message-ID: <556D6E9C.4050402@linaro.org>
Date: Tue, 02 Jun 2015 14:21:40 +0530
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, sameo@linux.intel.com, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, zhaoy <zhaoy@marvell.com>
Subject: [rtc-linux] Re: [PATCH 2/4] mfd: 88pm800: use irq_mode to configure
 interrupt status reg clear method
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org> <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org> <20150601083159.GD3329@x1>
In-Reply-To: <20150601083159.GD3329@x1>
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



On Monday 01 June 2015 02:01 PM, Lee Jones wrote:
> On Sat, 30 May 2015, Vaibhav Hiremath wrote:
>
>>  From the spec, bit 1 of reg 0xe (page 0): IN_CLEAR_MODE controls the
>> method of clearing interrupt status register of 88pm800;
>>
>>    0: clear on read
>>    1: clear on write
>>
>> Signed-off-by: zhaoy <zhaoy@marvell.com>
>
> This signed-off is not acceptable.
>
> No nicknames.  Full names only.
>

I just carry forwarded the signoff from original commit.
Let me find his complete signoff and add it to this patch.


>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/mfd/88pm800.c       | 4 +++-
>>   include/linux/mfd/88pm80x.h | 2 ++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>> index 06ee058..8ea4467 100644
>> --- a/drivers/mfd/88pm800.c
>> +++ b/drivers/mfd/88pm800.c
>> @@ -391,7 +391,8 @@ static int device_irq_init_800(struct pm80x_chip *chip)
>>   	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
>>   	    PM800_WAKEUP2_INT_MASK;
>>
>> -	data = PM800_WAKEUP2_INT_CLEAR;
>> +	data = (chip->irq_mode) ?
>> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
>
> These variable names are terrible.  'irq_mode' as a bool tells me
> nothing.
>
> What does; irq_mode = 'yes' and irq_mode = 'no' mean?  If I didn't
> read the remainder of the code, I would assume if it was 'yes' then
> the device was in IRQ Mode and if not, it would be in PIO or Polling
> mode, but that's not what it means at all is it?
>
> As for 'data', well, isn't everything data?
>


I will rename it.


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
