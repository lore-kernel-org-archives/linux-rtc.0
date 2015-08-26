Return-Path: <rtc-linux+bncBCQPVKWLVAIRB7H566XAKGQEICDL22I@googlegroups.com>
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id bm5si2376921pbc.1.2015.08.26.11.01.31
        for <rtc-linux@googlegroups.com>;
        Wed, 26 Aug 2015 11:01:32 -0700 (PDT)
Date: Wed, 26 Aug 2015 11:01:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <a0393675@ti.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, bcousson@baylibre.com, johan@kernel.org,
	linux-omap@vger.kernel.org, rtc-linux@googlegroups.com,
	grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH v5 0/3] ARM: AM437X: Add rtc clock handling
Message-ID: <20150826180126.GS4215@atomide.com>
References: <1439890876-19024-1-git-send-email-j-keerthy@ti.com>
 <20150821211812.GI3769@piout.net>
 <55DDEE88.3020407@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55DDEE88.3020407@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

* Keerthy <a0393675@ti.com> [150826 09:54]:
> Tony,
> 
> On Saturday 22 August 2015 02:48 AM, Alexandre Belloni wrote:
> >Tony,
> >
> >On 18/08/2015 at 15:11:13 +0530, Keerthy wrote :
> >>The series is applicable for all am437x series of processors.
> >>It adds clock handling support. Boot tested on am437x-gp-evm.
> >>
> >>Keerthy (3):
> >>   ARM: dts: AM437x: Add the internal and external clock nodes for rtc
> >>   rtc: omap: Add internal clock enabling support
> >>   rtc: omap: Add external clock enabling support
> >>
> >
> >I'm wondering how you want to get those patches merged. I can let you
> >take 2 and 3 through arm-soc but you will miss 4.3. Or I can take 2 and
> >3 for 4.3 but the documentation will be missing.
> 
> A gentle ping on this series.

Alexandre, it's probably best that you take them all. The dts changes
apply against Linux next with fuzz so there should not be any merge
conflict. Feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony

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
