Return-Path: <rtc-linux+bncBDS7HNEFSALRBBO7UC2QKGQEXIEHDWY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h123si165274wmd.0.2016.01.26.18.46.29
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 18:46:29 -0800 (PST)
Date: Wed, 27 Jan 2016 03:46:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Andi Shyti <andi.shyti@samsung.com>, linux-kernel@vger.kernel.org,
	Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 07/10] rtc: max77686: Use dev_warn()
 instead of pr_warn()
Message-ID: <20160127024628.GC25597@piout.net>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-8-git-send-email-javier@osg.samsung.com>
 <20160127012230.GE14296@samsunx.samsung>
 <56A82331.5050403@osg.samsung.com>
 <56A825F0.9000108@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56A825F0.9000108@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/01/2016 at 11:05:36 +0900, Krzysztof Kozlowski wrote :
> On 27.01.2016 10:53, Javier Martinez Canillas wrote:
> > Hello Andi,
> > 
> > Thanks a lot for your feedback and review.
> > 
> > On 01/26/2016 10:22 PM, Andi Shyti wrote:
> >> Hi Javier,
> >>
> >>>           if (tm->tm_year < 100) {
> >>> -            pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
> >>> -                1900 + tm->tm_year);
> >>> +            dev_warn(info->dev,
> >>> +                 "RTC can't handle year %d. Assume it's 2000\n",
> >>> +                 1900 + tm->tm_year);
> >>>               return -EINVAL;
> >>
> >> Because we are returning an error value, why not use dev_err()?
> >>
> > 
> > You are absolutely right. Since the driver was using pr_warn(), I used
> > dev_warn() but dev_err() would had been correct.
> 
> Wait. The message says that "2000 will be assumed" which is not an
> error. The message indicates that driver will proceed, thus the warning.
> 
> However the driver won't proceed because the max77686_rtc_set_time()
> will abort. This came from max8997 which has the same issue.
> 
> This means that either message should be changed (dev_err() without the
> "assume" verb) or the function should not abort and set the year to
> 2000+something (then dev_warn()... look at rtc-ds3234.c and rtc-mcp795.c).
> 
> The easiest would be to choose #1 - no changes in the logic.
> 

My stance on that is to never set a date that differs from the requested
date. Else, userspace has no way of knowing whether this is an erroneous
date or the real date when reading back.

I think I had a look and the driver is already doing the right thing but
the message is wrong.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
