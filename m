Return-Path: <rtc-linux+bncBDS7HNEFSALRBAWDVK3QKGQEY6OTUUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v68si301358wmd.1.2016.03.17.05.22.26
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 05:22:26 -0700 (PDT)
Date: Thu, 17 Mar 2016 13:22:25 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Burton <paul.burton@imgtec.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 5/5] MIPS: jz4740: Use the jz4740-rtc driver
 as the power controller
Message-ID: <20160317122225.GF3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-5-git-send-email-paul@crapouillou.net>
 <20160314015353.GB29020@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160314015353.GB29020@linux-mips.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 14/03/2016 at 02:53:53 +0100, Ralf Baechle wrote :
> On Sat, Mar 05, 2016 at 11:38:51PM +0100, Paul Cercueil wrote:
> 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
> >  arch/mips/jz4740/reset.c               | 64 ----------------------------------
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Feel free to funnel this patch upstream through the RTC tree.  Or I can
> carry the whole series, just lemme know.
> 

I made a few minor comments. I'll take the series once it has been
resent.

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
