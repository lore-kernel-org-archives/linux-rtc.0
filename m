Return-Path: <rtc-linux+bncBDS7HNEFSALRBK5FWO3AKGQEYKWE2XY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h73si10672wme.0.2016.02.23.13.44.11
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 13:44:11 -0800 (PST)
Date: Tue, 23 Feb 2016 22:44:09 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 1/3] rtc: Add functions to set and read rtc offset
Message-ID: <20160223214409.GB10681@piout.net>
References: <20160205143908.GJ4782@piout.net>
 <1454704873-31066-1-git-send-email-stillcompiling@gmail.com>
 <20160223104713.01508e11@jclayton-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160223104713.01508e11@jclayton-pc>
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

On 23/02/2016 at 10:47:13 -0800, Joshua Clayton wrote :
> On Fri,  5 Feb 2016 12:41:11 -0800
> Joshua Clayton <stillcompiling@gmail.com> wrote:
> 
> Alexandre,
> in case you didn't see, I made the change you requested.
> The rtc_read_offset function checks for a read_offset function
> and returns -EINVAL if not there, instead of an offset of 0.
> I just didn't put together a cover letter this time around.
>  

Sure, I was planning to review them tonight anyway.

All applied, thanks!

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
