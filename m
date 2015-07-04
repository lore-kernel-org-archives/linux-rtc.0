Return-Path: <rtc-linux+bncBDS7HNEFSALRBPW34CWAKGQEZ2XCXBQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si722152wib.1.2015.07.04.12.02.22
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jul 2015 12:02:22 -0700 (PDT)
Date: Sat, 4 Jul 2015 21:02:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Fabio Estevam <festevam@gmail.com>, rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] Re: [PATCH] drivers/rtc/rtc-armada38x: Remove unused
 variable from armada38x_rtc_set_time()
Message-ID: <20150704190221.GB5497@piout.net>
References: <1436034454-10473-1-git-send-email-festevam@gmail.com>
 <20150704184216.GA5497@piout.net>
 <55982BF4.3020303@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55982BF4.3020303@free-electrons.com>
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

On 04/07/2015 at 20:54:44 +0200, Gregory CLEMENT wrote :
> Hi Alexandre,
> 
> On 04/07/2015 20:42, Alexandre Belloni wrote:
> > Hi Fabio,
> > 
> > On 04/07/2015 at 15:27:34 -0300, Fabio Estevam wrote :
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Remove the 'flags' variable in order to fix the following warning:
> >>
> >> drivers/rtc/rtc-armada38x.c:91:22: warning: unused variable 'flags' [-Wunused-variable]
> >>
> > 
> > Thank you but I'm pretty sure that one is fixed (that is the fourth
> > patch to do so) ;)
> 
> Well, it should be fixed however none of the patch sent were merged in Linus tree yet...
> 

Hum, okay, I just realized f98b733e93e00365b4df78fbb33c2cad3080f6bb is not fixing it...

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
