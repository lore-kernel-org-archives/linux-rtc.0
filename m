Return-Path: <rtc-linux+bncBDS7HNEFSALRBG5V3KVQKGQER5NMQUI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k10si48264wia.1.2015.06.09.00.49.47
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Jun 2015 00:49:47 -0700 (PDT)
Date: Tue, 9 Jun 2015 09:49:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [42/73] rtc: delete non-required instances of include <linux/init.h>
Message-ID: <20150609074946.GG5222@piout.net>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
 <20150608195455.GF5222@piout.net>
 <20150608210634.GJ7125@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150608210634.GJ7125@windriver.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 08/06/2015 at 17:06:34 -0400, Paul Gortmaker wrote :
> > I've contemplated applying that patch but I'm not sure it is actually a
> > good idea because those 46 drivers are using a variant of module_driver
> > which actually uses __init and __exit. After your patch it is still
> > working simply because init.h gets included that way:
> 
> Firstly, I am kind of curious why an 18 month old patch is getting
> replied to now.   That aside, this interdependence between module.h and
> init.h was reconsidered and you can see the resolution solution here:
> 
> https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com
> 
> To summarize what is said there, yes - you can ignore the one line
> removals for now.  We will revisit them after the above is merged.
> 

I've taken the RTC subsystem maintainership and I've been sorting the
2372 patches left in patchwork down to 126 and yours was one of these.

Seeing your answer, I think my question was legitimate. I'll be happy to
take your revised patch once ready.

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
