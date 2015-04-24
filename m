Return-Path: <rtc-linux+bncBDS7HNEFSALRBYM75CUQKGQEA26NWZQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si81830wib.3.2015.04.24.02.41.52
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Apr 2015 02:41:52 -0700 (PDT)
Date: Fri, 24 Apr 2015 11:41:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the
 mcp794xx alarm after programming time
Message-ID: <20150424094151.GO8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
 <20150421234139.GF8539@piout.net>
 <5536E433.90103@ti.com>
 <20150422010925.GH8539@piout.net>
 <55370073.3060809@ti.com>
 <20150422113053.GI8539@piout.net>
 <55383724.2080806@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55383724.2080806@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 22/04/2015 at 19:04:52 -0500, Nishanth Menon wrote :
> > I fully agree that your patch doesn't change the behaviour for the other
> > cases you presented and further clean up is to be done in a separate set
> > of patches.
> > 
> 

Sure,
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


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
