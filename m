Return-Path: <rtc-linux+bncBDJNHL5JSEOBB4ERYSUQKGQEO3VHJGA@googlegroups.com>
Received: from vps0.lunn.ch (vps0.lunn.ch. [178.209.37.122])
        by gmr-mx.google.com with ESMTPS id p9si106417wiz.3.2015.04.17.06.21.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Apr 2015 06:21:52 -0700 (PDT)
Date: Fri, 17 Apr 2015 15:17:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Arnaud Ebalard <arno@natisbad.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: Fix concurrency access in armada38x_rtc_set_time
Message-ID: <20150417131734.GB7768@lunn.ch>
References: <1429103633-24376-1-git-send-email-gregory.clement@free-electrons.com>
 <20150415192732.GB13105@lunn.ch>
 <5531070A.7080105@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5531070A.7080105@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, Apr 17, 2015 at 03:13:46PM +0200, Gregory CLEMENT wrote:
> Hi Andrew,
> 
> On 15/04/2015 21:27, Andrew Lunn wrote:
> > On Wed, Apr 15, 2015 at 03:13:53PM +0200, Gregory CLEMENT wrote:
> >> While setting the time, the RTC TIME register should not be
> >> accessed. However due to hardware constraints, setting the RTC time
> >> involves sleeping during 100ms. This sleep was done outside the
> >> critical section protected by the spinlock, so it was possible to read
> >> the RTC TIME register and get an incorrect value. This patch
> >> introduces a mutex for protecting the RTC TIME access, unlike the
> >> spinlock it is allowed to sleep in a critical section protected by a
> >> mutex. The RTC STATUS register can still be used from the interrupt
> >> handler but it has no effect on setting the time.
> > 
> > Hi Gregory
> > 
> > There is the following comment in the code:
> > 
> >         /*
> >          * Setting the RTC time not always succeeds. According to the
> >          * errata we need to first write on the status register and
> >          * then wait for 100ms before writing to the time register to be
> >          * sure that the data will be taken into account.
> >          */
> > 
> > The interrupt handler also writes to the STATUS register. So what
> > happens if there is an interrupt during that 100ms and a second write
> > to STATUS?
> 
> 
> As I wrote in the commit log, the RTC STATUS register can still be used from
> the interrupt handler but it has no effect on setting the time: between writing
> 0 in the RTC_STATUS register and writing the time in the RTC_TIME register,
> writing anything in RTC_STATUS won't prevent to write the time successfully.

Hi Gregory

Thanks for explaining. If you have to respin for any reason, it would
be nice to make the commit log more explicit about this.

I didn't do a detailed review, but i did review it to some extent, so

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

   Andrew

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
