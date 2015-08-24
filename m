Return-Path: <rtc-linux+bncBDS7HNEFSALRBYNB5OXAKGQEOBP5JZY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x20si570982wia.0.2015.08.24.01.08.01
        for <rtc-linux@googlegroups.com>;
        Mon, 24 Aug 2015 01:08:01 -0700 (PDT)
Date: Mon, 24 Aug 2015 10:08:00 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Suneel Garapati <suneel.garapati@xilinx.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, sorenb@xilinx.com,
	Alessandro Zummo <a.zummo@towertech.it>, punnaia@xilinx.com,
	anuragku@xilinx.com, anirudh@xilinx.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
Message-ID: <20150824080800.GG13155@piout.net>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net>
 <55DACC5A.80707@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55DACC5A.80707@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/08/2015 at 09:48:42 +0200, Michal Simek wrote :
> On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
> > On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
> >> adds support for RTC controller found on
> >> Xilinx Zynq Ultrascale+ MPSoC platform.
> >>
> >> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> >> ---
> >> Changes v3 
> >> - fix checkpatch errors 
> >> - check time in secs arg against max sec val 
> >> - order header files 
> >> - use ptr_err_or_zero macro 
> >> - use time64 variants 
> >> Changes v2 
> >> - change alm to alarm 
> >> ---
> >>  drivers/rtc/Kconfig      |   7 ++
> >>  drivers/rtc/Makefile     |   1 +
> >>  drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 287 insertions(+)
> >>  create mode 100644 drivers/rtc/rtc-zynqmp.c
> >>
> > Applied, thanks.
> > 
> 

Actually, I got the following message:
A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  suneel.garapati@xilinx.com
    Unknown User

I'm not fond of carrying patches with uncontactable authors. Is that a
permanent error?

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
