Return-Path: <rtc-linux+bncBCAMRWGQV4CRBD7IRCXAKGQE4XW375Q@googlegroups.com>
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id gt9si275457wib.2.2015.08.05.09.04.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 09:04:30 -0700 (PDT)
Message-ID: <55C2340D.4060506@mleia.com>
Date: Wed, 05 Aug 2015 19:04:29 +0300
From: Vladimir Zapolskiy <vz@mleia.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [rtc-linux] Re: [PATCH 08/11] rtc: m48t59: clean up m48t59_nvram_read()/m48t59_nvram_write()
References: <1437947316-5652-1-git-send-email-vz@mleia.com> <1437947316-5652-9-git-send-email-vz@mleia.com> <20150805082721.GB3486@piout.net>
In-Reply-To: <20150805082721.GB3486@piout.net>
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

On 05.08.2015 11:27, Alexandre Belloni wrote:
> On 27/07/2015 at 00:48:33 +0300, Vladimir Zapolskiy wrote :
>> @@ -365,11 +366,10 @@ static ssize_t m48t59_nvram_write(struct file *filp, struct kobject *kobj,
>>  	ssize_t cnt = 0;
>>  	unsigned long flags;
>>  
>> -	for (; size > 0 && pos < pdata->offset; cnt++, size--) {
>> -		spin_lock_irqsave(&m48t59->lock, flags);
>> +	spin_lock_irqsave(&m48t59->lock, flags);
>> +
>> +	for (; cnt < size; cnt++)
>>  		M48T59_WRITE(*buf++, cnt);
>> -		spin_unlock_irqrestore(&m48t59->lock, flags);
>> -	}
>>  
> 
> Isn't a spin_unlock_irqrestore() missing?
> 

oops, you are correct, will update this change.

With best wishes,
Vladimir

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
