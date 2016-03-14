Return-Path: <rtc-linux+bncBAABBUV3TS3QKGQEWDONUGY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si3588457pab.0.2016.03.14.13.23.45
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 13:23:45 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Don't print an error on probe deferral
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
 <1457982675.11972.119.camel@perches.com> <56E7119B.9060900@osg.samsung.com>
 <1457984317.11972.123.camel@perches.com> <56E71825.5070104@osg.samsung.com>
 <1457985791.11972.128.camel@perches.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56E71DCA.7090608@osg.samsung.com>
Date: Mon, 14 Mar 2016 17:23:38 -0300
MIME-Version: 1.0
In-Reply-To: <1457985791.11972.128.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Joe,

On 03/14/2016 05:03 PM, Joe Perches wrote:
> On Mon, 2016-03-14 at 16:59 -0300, Javier Martinez Canillas wrote:
>> I don't think they make little sense now since even a non-native english
>> speaker like me can understand it :)
> 
> That's a non sequitur if ever I read one.
>

I was trying to be funny but it seems that I failed.
 
>> But yes, it's cryptic at the very least. That's the problem with long text
>> and the 80 char limit to make checkpatch.pl happy. I guess I can just move
>> the message a little bit even if that will make to not be properly aligned.
> 
> There's no issue with longer than 80 column lines
> for these messages.  checkpatch wouldn't complain.
> 

Great, I didn't know that checkpatch had an exception for the 80 column
rule. I'll post a v2 then.

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
