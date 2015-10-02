Return-Path: <rtc-linux+bncBDS7HNEFSALRBRUHXKYAKGQEGP5BE4I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c1si230629wiv.3.2015.10.02.06.16.54
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Oct 2015 06:16:54 -0700 (PDT)
Date: Fri, 2 Oct 2015 15:16:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH 01/17] rtc: pl031: remove misuse of
 IRQF_NO_SUSPEND flag
Message-ID: <20151002131643.GD10444@piout.net>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
 <560E603E.8080603@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <560E603E.8080603@arm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/10/2015 at 11:45:18 +0100, Sudeep Holla wrote :
> 
> 
> On 02/10/15 11:40, Linus Walleij wrote:
> >On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> >>The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> >>be left enabled so as to allow them to work as expected during the
> >>suspend-resume cycle, but doesn't guarantee that it will wake the system
> >>from a suspended state, enable_irq_wake is recommended to be used for
> >>the wakeup.
> >>
> >>This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> >>introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
> >>
> >>Cc: Linus Walleij <linus.walleij@linaro.org>
> >>Cc: Alessandro Zummo <a.zummo@towertech.it>
> >>Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>Cc: rtc-linux@googlegroups.com
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> >Looks correct to me.
> >Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> 
> Thanks, while you are at it, do you know what interrupt stv2_pl031
> shares so that I can fix the TODO in the comment or the code(whichever
> applicable).
> 

So that you know, I'm planning to apply them this weekend, I couldn't
find time to do it before.

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
