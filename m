Return-Path: <rtc-linux+bncBCNNJWF7RUMRBXM6WSZAKGQE25YU2VY@googlegroups.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com. [2607:f8b0:400e:c03::235])
        by gmr-mx.google.com with ESMTPS id bh2si643671pbb.1.2015.11.18.15.53.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 15:53:01 -0800 (PST)
Received: by mail-pa0-x235.google.com with SMTP id ej9so60032173pac.2
        for <rtc-linux@googlegroups.com>; Wed, 18 Nov 2015 15:53:01 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 8/9] rtc-pcf2123: use sysfs groups
Date: Wed, 18 Nov 2015 15:52:58 -0800
Message-ID: <2659269.QUxo4jPbI7@jclayton-pc>
In-Reply-To: <63d5284dfb9d04f1f0a33c02cd937e2ddd72fb9b.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com> <63d5284dfb9d04f1f0a33c02cd937e2ddd72fb9b.1446587705.git.stillcompiling@gmail.com>
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

On Wednesday, November 04, 2015 07:36:39 AM Joshua Clayton wrote:
> Switch from manually creating all the sysfs attributes to
> defining them mostly in the canonical way.
> We are adding them to an spi driver, so we must still add and remove
> the group manually, but everythig else is done by The Book(tm) .
s/everythig/everything/

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
