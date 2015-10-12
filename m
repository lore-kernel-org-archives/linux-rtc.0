Return-Path: <rtc-linux+bncBDS7HNEFSALRB5OM5WYAKGQEWQFZE2Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q6si425990wif.2.2015.10.12.00.51.16
        for <rtc-linux@googlegroups.com>;
        Mon, 12 Oct 2015 00:51:16 -0700 (PDT)
Date: Mon, 12 Oct 2015 09:51:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	"Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"Desroches, Ludovic" <Ludovic.Desroches@atmel.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH] rtc: at91rm9200: clear RTC alarm status flag
 prior to suspending
Message-ID: <20151012075115.GC3558@piout.net>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
 <20151012065323.GA3558@piout.net>
 <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/10/2015 at 07:48:18 +0000, Yang, Wenyou wrote :
> > On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> > > This patch is to clear the RTC alarm status flag prior to suspending
> > > to avoid the erroneous wake-up activity.
> > >
> > 
> > Is this a new issue appearing with the sama5d2 or was it present from the
> > beginning?
> With the sama5d2 ULP1 mode, not from the beginning.
> 

I think this information should appear in the commit log.

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
