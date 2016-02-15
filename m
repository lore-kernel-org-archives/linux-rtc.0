Return-Path: <rtc-linux+bncBAABBEFTQ63AKGQEQ6XXESQ@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id u66si3011171pfa.2.2016.02.15.05.58.40
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 05:58:40 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1455542202-13977-1-git-send-email-javier@osg.samsung.com>
 <20160215134535.GB15219@piout.net>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com,
 devicetree@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56C1D98A.8040408@osg.samsung.com>
Date: Mon, 15 Feb 2016 10:58:34 -0300
MIME-Version: 1.0
In-Reply-To: <20160215134535.GB15219@piout.net>
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

Hello Alexandre,

On 02/15/2016 10:45 AM, Alexandre Belloni wrote:
> On 15/02/2016 at 10:16:42 -0300, Javier Martinez Canillas wrote :
>> Commit 43f3408261a2 ("rtc: s3c: Document required clocks in the DT
>
> I'm pretty sure you shouldn't refer to a commit that is in linux-next.
>

The commit comes from Rob's dt/linus branch that uses Linux 4.5-rc3 as
a base. I'm not a git expert but I thought that if the branch is not
rebased and used for the pull request then the resulting commit in
mainline would end with the same sha-1.

But I can remove the mention to the commit and "Fixes:" tag since the
commit is not yet in mainline, that should be more safe indeed.
  
>> binding") added to the S3C binding doc the required clocks needed
>> by the Real Time Clock but the S3C driver supports different HW IP
>> and only the s3c6410 needs a source clock.
>>
>> Fix the DT binding explaning that the second clock is only needed
>            explaining ^

Ok, I'll fix that typo.

>> by this IP block and not for the others.
>>
>> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Fixes: 43f3408261a2 ("rtc: s3c: Document required clocks in the DT binding")
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>
> Anyway, I'm fine with it, feel free to add my ack.
>

Thanks, I'll add it in v2.
  
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
