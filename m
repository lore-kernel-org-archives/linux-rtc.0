Return-Path: <rtc-linux+bncBDS7HNEFSALRBZHQY6WQKGQEESDMYJY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v8si239583wiw.1.2015.07.24.01.33.40
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Jul 2015 01:33:40 -0700 (PDT)
Date: Fri, 24 Jul 2015 10:33:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"a.zummo@towertech.it" <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-rx8025: remove obsolete
 local_irq_disable() and local_irq_enable() for rtc_update_irq()
Message-ID: <20150724083339.GG14893@piout.net>
References: <FC629F1A536C6F42B960B5E32E20BD35922297@exc2.buero.ginzinger.com>
 <20150722220529.GQ2853@piout.net>
 <FC629F1A536C6F42B960B5E32E20BD35922388@exc2.buero.ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <FC629F1A536C6F42B960B5E32E20BD35922388@exc2.buero.ginzinger.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 24/07/2015 at 08:14:58 +0000, Roosen Henri wrote :
> >
> > Seems good to me, I had a similar cleanup that I didn't send yet. do you have
> > an rx8025? I have more cleanups and I can't test them.
> >
> 
> Unfortunately I don't have a rx8025. But I have a system with a rx8803. The manufacturer is providing a driver which is derived from the rx8025 driver.
> 

Ok, my cleanup is then adding support for the rx8803. The provided
driver is actually really bad. I'll submit this weekend.


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
