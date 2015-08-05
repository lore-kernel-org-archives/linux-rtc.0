Return-Path: <rtc-linux+bncBCAMRWGQV4CRBLXQRCXAKGQES454PJQ@googlegroups.com>
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id bk2si282270wib.1.2015.08.05.09.22.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 09:22:05 -0700 (PDT)
Message-ID: <55C2382C.7010606@mleia.com>
Date: Wed, 05 Aug 2015 19:22:04 +0300
From: Vladimir Zapolskiy <vz@mleia.com>
MIME-Version: 1.0
To: rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [rtc-linux] Re: [PATCH 05/11] rtc: ds1511: clean up ds1511_nvram_read()/ds1511_nvram_write()
References: <1437947316-5652-1-git-send-email-vz@mleia.com> <1437947316-5652-6-git-send-email-vz@mleia.com> <20150805082402.GA3486@piout.net>
In-Reply-To: <20150805082402.GA3486@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On 05.08.2015 11:24, Alexandre Belloni wrote:
> Hi,
> 
> On 27/07/2015 at 00:48:30 +0300, Vladimir Zapolskiy wrote :
>> The change removes redundant sysfs binary file boundary checks, since
>> this task is already done on caller side in fs/sysfs/file.c
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  drivers/rtc/rtc-ds1511.c | 38 ++++++++------------------------------
>>  1 file changed, 8 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
>> index 7415c2b..2213fab 100644
>> --- a/drivers/rtc/rtc-ds1511.c
>> +++ b/drivers/rtc/rtc-ds1511.c
>> @@ -407,25 +407,14 @@ ds1511_nvram_read(struct file *filp, struct kobject *kobj,
>>  {
>>  	ssize_t count;
>>  
>> -	/*
>> -	 * if count is more than one, turn on "burst" mode
>> -	 * turn it off when you're done
>> -	 */
>> -	if (size > 1)
>> -		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
>> -
>> -	if (pos > DS1511_RAM_MAX)
>> -		pos = DS1511_RAM_MAX;
>> -
>> -	if (size + pos > DS1511_RAM_MAX + 1)
>> -		size = DS1511_RAM_MAX - pos + 1;
>> +	/* turn on "burst" mode, turn it off when you're done */
>> +	rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
> 
> That one feels wrong, you are now unconditionally using burst mode, this
> was not the case before. If this has been tested and works, I'd ay that
> this at least require a mention in the commit message.
> 

I believe this is a correct fix, burst mode should be always enabled,
probably it might be better even to move its configuration to probe().

>From the spec:

  The burst-mode enable bit allows the extended user RAM address
  registers to automatically increment for consecutive reads and writes.

  When BME is set to 1, the automatic incrementing is enabled; when BME
  is set to 0, the automatic incrementing is disabled.

Prior to the change the sequence of

  read(fd, buf, 1);
  read(fd, buf, 1);
  read(fd, buf, 1);
  ...

won't sequentially read NVRAM byte by byte as it should be IMO, at least
it contradicts to common and expected usage of read().

If there is no objections, I'll keep this part of the proposed change
unmodified, but thanks for attracting my attention to the potential
problem, I've managed to notice that DS1511_RAM_MAX value is invalid, it
must be 256 --- the current value of 0xff *and* "no-burst" mode for
1-byte reading probably is done as a clumsy attempt to avoid overflow.

I'll resend the change with DS1511_RAM_MAX update and improved commit
message.

With best wishes,
Vladimir

>>  
>>  	rtc_write(pos, DS1511_RAMADDR_LSB);
>> -	for (count = 0; size > 0; count++, size--)
>> +	for (count = 0; count < size; count++)
>>  		*buf++ = rtc_read(DS1511_RAMDATA);
>>  
>> -	if (count > 1)
>> -		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>> +	rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>>  
>>  	return count;
>>  }
>> @@ -437,25 +426,14 @@ ds1511_nvram_write(struct file *filp, struct kobject *kobj,
>>  {
>>  	ssize_t count;
>>  
>> -	/*
>> -	 * if count is more than one, turn on "burst" mode
>> -	 * turn it off when you're done
>> -	 */
>> -	if (size > 1)
>> -		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
>> -
>> -	if (pos > DS1511_RAM_MAX)
>> -		pos = DS1511_RAM_MAX;
>> -
>> -	if (size + pos > DS1511_RAM_MAX + 1)
>> -		size = DS1511_RAM_MAX - pos + 1;
>> +	/* turn on "burst" mode, turn it off when you're done */
>> +	rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
>>  
>>  	rtc_write(pos, DS1511_RAMADDR_LSB);
>> -	for (count = 0; size > 0; count++, size--)
>> +	for (count = 0; count < size; count++)
>>  		rtc_write(*buf++, DS1511_RAMDATA);
>>  
>> -	if (count > 1)
>> -		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>> +	rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>>  
>>  	return count;
>>  }
>> -- 
>> 2.1.4
>>
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
