Return-Path: <rtc-linux+bncBCNNJWF7RUMRBC46WSZAKGQEAYTMP7Q@googlegroups.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com. [2607:f8b0:400e:c03::22f])
        by gmr-mx.google.com with ESMTPS id xk4si550445pbc.2.2015.11.18.15.51.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 15:51:39 -0800 (PST)
Received: by mail-pa0-x22f.google.com with SMTP id fh17so61931203pab.0
        for <rtc-linux@googlegroups.com>; Wed, 18 Nov 2015 15:51:39 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 9/9] rtc-pcf2123: adjust the clock rate via sysfs
Date: Wed, 18 Nov 2015 15:51:35 -0800
Message-ID: <3618154.iGh6Vcis4K@jclayton-pc>
In-Reply-To: <e06c88aded2d6f06103d73a1020576e3e0772331.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com> <e06c88aded2d6f06103d73a1020576e3e0772331.1446587705.git.stillcompiling@gmail.com>
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

On Wednesday, November 04, 2015 07:36:40 AM Joshua Clayton wrote:
> pcf2123 has an offset register, which can be used to make minor
> adjustments to the clock rate to compensate for temperature or
> a crystal that is not exactly right.
> 
> The adjustment is calculated in parts per billion. The data sheet
> uses parts per million (as do some others), but with 2 digits of
> precision. Since floating point is forbidden, parts per billion is
> a better fit.
> 
> Add a pair of sysfs files to seetand retrieve the offset in ppm.
Bah.
I noticed a couple of typos in the last line of the commit message.
Will get rid of "in ppm" since it is not in ppm.
s/seetand/set and/

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
