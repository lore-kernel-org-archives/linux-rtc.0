Return-Path: <rtc-linux+bncBAABBB6PUC2QKGQEUL5EIZQ@googlegroups.com>
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id 190si434719pfb.1.2016.01.26.18.12.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 18:12:22 -0800 (PST)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1L00VXWA4LWMD0@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 11:12:21 +0900 (KST)
Date: Wed, 27 Jan 2016 11:12:14 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 07/10] rtc: max77686: Use dev_warn()
 instead of pr_warn()
Message-id: <20160127021214.GG14296@samsunx.samsung>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-8-git-send-email-javier@osg.samsung.com>
 <20160127012230.GE14296@samsunx.samsung> <56A82331.5050403@osg.samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <56A82331.5050403@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

> >>  		if (tm->tm_year < 100) {
> >>-			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
> >>-				1900 + tm->tm_year);
> >>+			dev_warn(info->dev,
> >>+				 "RTC can't handle year %d. Assume it's 2000\n",
> >>+				 1900 + tm->tm_year);
> >>  			return -EINVAL;
> >
> >Because we are returning an error value, why not use dev_err()?
> >
> 
> You are absolutely right. Since the driver was using pr_warn(), I used
> dev_warn() but dev_err() would had been correct.
> 
> If you don't mind I plan to do it as a follow up patch to avoid having
> to resend the whole series only for this change.

Fine for me!

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
