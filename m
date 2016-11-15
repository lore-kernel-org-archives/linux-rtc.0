Return-Path: <rtc-linux+bncBCQPVKWLVAIRBBNUVHAQKGQEOG6RRHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id ua1si5404396pac.0.2016.11.14.16.42.44
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Nov 2016 16:42:44 -0800 (PST)
Date: Mon, 14 Nov 2016 16:42:40 -0800
From: Tony Lindgren <tony@atomide.com>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: rtc-twl: cleanup
Message-ID: <20161115004239.GF4082@atomide.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <CAKP5S=1YeLRqun5ABjYRk=be1fVBGJPqo_nOC1oYmnguG0+jpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAKP5S=1YeLRqun5ABjYRk=be1fVBGJPqo_nOC1oYmnguG0+jpg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Nicolae Rosia <nicolae.rosia.oss@gmail.com> [161112 02:23]:
> On Sat, Nov 12, 2016 at 12:07 PM, Nicolae Rosia
> <Nicolae_Rosia@mentor.com> wrote:
> > This is a cleanup and preparation of rtc-twl to reduce the usage of
> > twl-core exported functions.
> > The next patch series will further reduce the usage of exported functions
> > but first it requires some changes in mfd/twl-core.c
> Tony, could you please test this series again and add your Tested-By ?

Yes still works for me as tested with rtcwake on omap3 and omap4:

Tested-by: Tony Lindgren <tony@atomide.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
