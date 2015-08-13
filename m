Return-Path: <rtc-linux+bncBAABBLPDWOXAKGQEVFHQ3VA@googlegroups.com>
Received: from mx02.posteo.de (mx02.posteo.de. [89.146.194.165])
        by gmr-mx.google.com with ESMTPS id c3si120623wiz.2.2015.08.13.12.36.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 12:36:13 -0700 (PDT)
Date: Thu, 13 Aug 2015 21:33:27 +0200
From: Felix Janda <felix.janda@posteo.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: as3772: Fix off-by-one error in month value
Message-ID: <20150813193327.GA7843@nyan>
References: <20150801175924.GA5371@nyan>
 <20150812132759.GI3411@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150812132759.GI3411@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Alexandre Belloni wrote:
> Hi,

Thank you very much for your help!

> On 01/08/2015 at 19:59:24 +0200, Felix Janda wrote :
> > The RTC's month value starts at 1, whereas the kernel's starts at 0.
> > 
> > Signed-off-by: Felix Janda <felix.janda@posteo.de>
> > ---
> > This is my first kernel patch. It's content is actually from
> > 
> > https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/9ce8d10f39c441642fba58ab8248d78951cec7a7
> > 
> > How can this be acknowledged? The patch from the chromiumos kernel
> > can't be taken as it is, can it?
> 
> You should send the patch with "Bibek Basu <bbasu@nvidia.com>" as the
> author and both SoB tags, Bibek's and yours. The other, gerrit related,
> tags can be removed.
> 
> It will look like:
> https://groups.google.com/forum/#!topic/rtc-linux/9NJUEAJWIkI

So I should better not rewrite the commit message? At least the
"CHROMIUM: " prefix of the title seems inappropriate.

Felix

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
