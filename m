Return-Path: <rtc-linux+bncBDS7HNEFSALRBAPTS6XQKGQEYL53BDI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si218873wib.3.2015.09.01.12.16.17
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Sep 2015 12:16:17 -0700 (PDT)
Date: Tue, 1 Sep 2015 21:16:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] Re: [PATCH -next] rtc: drop unused ret variable orphaned
 by misc_deregister becoming void
Message-ID: <20150901191616.GG3409@piout.net>
References: <1440271591-5640-1-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdXMHg-HR10WQavREmnva6u5-i0ekFeGM5za5UUHgiN0dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMuHMdXMHg-HR10WQavREmnva6u5-i0ekFeGM5za5UUHgiN0dA@mail.gmail.com>
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

On 01/09/2015 at 19:37:07 +0200, Geert Uytterhoeven wrote :
> On Sat, Aug 22, 2015 at 9:26 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > In commit f368ed6088ae9c1fbe1c897bb5f215ce5e63fa1e ("char: make
> > misc_deregister a void function") this ret variable became unused
> > which now generates a compile warning.  Get rid of it.
> >
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: rtc-linux@googlegroups.com
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> It's funny how these things end up in mainline, despite at least two
> people providing a patch.
> 

The fact is that I've asked Greg to take the first fix as he is the one
carrying the offending patch. He didn't do it so I'll ensure that the
fix reaches Linus before -rc1.


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
