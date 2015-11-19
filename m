Return-Path: <rtc-linux+bncBCNNJWF7RUMRB3FNWSZAKGQETZM6D6A@googlegroups.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com. [2607:f8b0:400e:c03::230])
        by gmr-mx.google.com with ESMTPS id fa8si628525pab.1.2015.11.18.16.25.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 16:25:16 -0800 (PST)
Received: by mail-pa0-x230.google.com with SMTP id dm15so60899286pac.3
        for <rtc-linux@googlegroups.com>; Wed, 18 Nov 2015 16:25:16 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 0/9] rtc-2123: access the clock offset feature
Date: Wed, 18 Nov 2015 16:25:14 -0800
Message-ID: <2802614.ZvDTOLQF6p@jclayton-pc>
In-Reply-To: <20151117162530.GC14677@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com> <2107368.j5bIbb5cBF@jclayton-pc> <20151117162530.GC14677@piout.net>
MIME-Version: 1.0
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

On Tuesday, November 17, 2015 05:25:30 PM Alexandre Belloni wrote:
> On 17/11/2015 at 07:30:48 -0800, Joshua Clayton wrote :
> > On Wednesday, November 04, 2015 07:36:31 AM Joshua Clayton wrote:
> > Any comments on this series?
> > I realize now that I submitted it during the merge window, so it may have been overlooked.
> > 
> 
> I will have a few comments but I didn't review everything thoroughly
> yet. As you mentioned, you submitted during the merge window so this was
> not going to be in 4.4 anyway.
> 
> 
Thanks!
I can relax since I know it is on your radar.
I have responded my self to a couple of fat fingers in the commit messages.
I am also in the process of testing the actual effects of the feature.

One thing I'm not sure I have adequately described (and didn't really
understand until I started testing) is that a positive value in the adjust
register increases the average value of a second, so it makes the clock
slower, while a negative adjustment makes it faster.

This was counterintuitive to me.
Not having deeply examined other rtc's with similar capabilities, I can't
say whether this is the norm.

-- 
~Joshua Clayton

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
