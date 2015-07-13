Return-Path: <rtc-linux+bncBDS7HNEFSALRBN5IR6WQKGQE2OGVLXQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si386756wib.2.2015.07.13.08.07.35
        for <rtc-linux@googlegroups.com>;
        Mon, 13 Jul 2015 08:07:35 -0700 (PDT)
Date: Mon, 13 Jul 2015 17:07:32 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Zhi Li <lznuaa@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, rtc-linux@googlegroups.com,
	Frank Li <Frank.Li@freescale.com>,
	kbuild test robot <fengguang.wu@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH] rtc: snvs: select option REGMAP_MMIO
Message-ID: <20150713150732.GC20482@piout.net>
References: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
 <CAHrpEqSi=BPuZrqSvozvggAFsnXy2DqnfkzP5dpsP2cShzM7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHrpEqSi=BPuZrqSvozvggAFsnXy2DqnfkzP5dpsP2cShzM7Hg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/07/2015 at 09:48:33 -0500, Zhi Li wrote :
> On Mon, Jul 13, 2015 at 3:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > Select REGMAP_MMIO to fix the following build error seen with x86_64
> > randconfig.
> >
> >   drivers/built-in.o: In function `snvs_rtc_probe':
> > rtc-snvs.c:(.text+0x567730): undefined reference to `devm_regmap_init_mmio_clk'
> >
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> Acked-by: Frank Li <Frank.Li@freescale.com>
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
