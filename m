Return-Path: <rtc-linux+bncBAABBDG2UC2QKGQEA7GQGEQ@googlegroups.com>
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id tn7si497569pac.1.2016.01.26.18.35.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 18:35:56 -0800 (PST)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1L00T35B7UPPC0@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 11:35:54 +0900 (KST)
Date: Wed, 27 Jan 2016 11:35:54 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 07/10] rtc: max77686: Use dev_warn()
 instead of pr_warn()
Message-id: <20160127023554.GI14296@samsunx.samsung>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-8-git-send-email-javier@osg.samsung.com>
 <20160127012230.GE14296@samsunx.samsung> <56A82331.5050403@osg.samsung.com>
 <56A825F0.9000108@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <56A825F0.9000108@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

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

Nevertheless, the function fails, and those who call
max77686_rtc_tm_to_data() fail as well, so, we are printing
warning, but behaving as error.

Either we print error and return error, or we print warning, we
set:

tm->tm_year = 100; /* don't know if I got the logic right */

and return 0

Right?

Thanks,
Andi

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
