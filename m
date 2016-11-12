Return-Path: <rtc-linux+bncBCQPVKWLVAIRBW5QTXAQKGQE3IIOT7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id o6si2761978pap.2.2016.11.12.09.58.50
        for <rtc-linux@googlegroups.com>;
        Sat, 12 Nov 2016 09:58:51 -0800 (PST)
Date: Sat, 12 Nov 2016 09:58:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Nicolae Rosia <Nicolae_Rosia@mentor.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
Message-ID: <20161112175845.GP7138@atomide.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
 <20161112112009.34gwcedl57v77ng5@earth>
 <CAKP5S=27ZHZyKj9LWVDaeSXzCyrsrJmNbc3r-YRXXXKsk74yag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAKP5S=27ZHZyKj9LWVDaeSXzCyrsrJmNbc3r-YRXXXKsk74yag@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Nicolae Rosia <nicolae.rosia.oss@gmail.com> [161112 03:37]:
> Hi,
> 
> 
> On Sat, Nov 12, 2016 at 1:20 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > This patch is missing long description. I would have patched it the
> > other way around. There is no reason to use irq_of_parse_and_map if
> > generic platform_get_irq can be used.
> Since this patch series removes platform support and makes the driver DT only,
> I thought it would be a good idea to make it explicit that it depends on OF_IRQ.

You can still use platform_get_irq(), eventually that will be just some
generic call. Don't we already have the "generic" names defined somewhere
in kernel?

Regards,

Tony

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
