Return-Path: <rtc-linux+bncBCGLJQVNREJBBY7D4GVAKGQEEVVE7PY@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id x3si729509pdh.2.2015.05.17.03.48.02
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 03:48:03 -0700 (PDT)
Message-ID: <1431859679.31486.4.camel@mtksdaap41>
Subject: Re: [rtc-linux] [PATCH] rtc: mt6397: fix build on some 32bits platforms
From: Eddie Huang <eddie.huang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
Date: Sun, 17 May 2015 18:47:59 +0800
In-Reply-To: <20150514215504.GF3338@piout.net>
References: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <20150514215504.GF3338@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 2015-05-14 at 23:55 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 14/05/2015 at 22:51:18 +0200, Alexandre Belloni wrote :
> > On some !ARM 32bits platforms, the following compilation error happens
> > because of the division on a 64bits value in mtk_rtc_read_time():
> > 
> > drivers/built-in.o: In function `mtk_rtc_read_time':
> > rtc-mt6397.c:(.text+0x265d13f): undefined reference to `__divdi3'
> > rtc-mt6397.c:(.text+0x265d150): undefined reference to `__moddi3'
> > 
> > Use div_s64() as done in rtc_time64_to_tm() to solve that.
> > 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> I've already pushed that patch to rtc-next to repair the build for i386
> and m68k but feel free to comment if you see anything wrong.

Sorry for late. I am in vacation and can't receive mail last week.
Thanks your effort to correct this.

Eddie


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
