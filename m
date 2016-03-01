Return-Path: <rtc-linux+bncBDS7HNEFSALRB6522W3AKGQENW3SW4Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si742717wmw.3.2016.03.01.01.14.35
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 01:14:35 -0800 (PST)
Date: Tue, 1 Mar 2016 10:14:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: RTCLINUX <rtc-linux@googlegroups.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: enable COMPILE_TEST
Message-ID: <20160301091434.GE2627@piout.net>
References: <1456788518-31420-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAMuHMdW52X2y3t+oHt3Uvax_ihBxr2F7j9xCzWSqfn0RRC+Yfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMuHMdW52X2y3t+oHt3Uvax_ihBxr2F7j9xCzWSqfn0RRC+Yfw@mail.gmail.com>
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

On 01/03/2016 at 10:01:12 +0100, Geert Uytterhoeven wrote :
> On Tue, Mar 1, 2016 at 12:28 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > There are several arch-specific RTC drivers that can be successfully
> > compiled on other platforms. Add a COMPILE_TEST dependency for those.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> BTW, no additional dependencies needed on sun3-allmodconfig.
> One new warning seen, patch sent.
> 

This is only a tentative patch to see what issues that has. currently,
this fails on ia64 and mn10300 so I will probably not sent it as is to
Linus.

Thanks for looking into it!

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
