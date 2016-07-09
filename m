Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBPKQK6AKGQEGKMFHDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s21si318177wme.1.2016.07.09.01.25.41
        for <rtc-linux@googlegroups.com>;
        Sat, 09 Jul 2016 01:25:41 -0700 (PDT)
Date: Sat, 9 Jul 2016 10:25:40 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 5/5] rtc: v3020: move rtc-v3020.h to platform_data
Message-ID: <20160709082540.GO22202@piout.net>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-5-git-send-email-alexandre.belloni@free-electrons.com>
 <87bn2745lb.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87bn2745lb.fsf@belgarion.home>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/07/2016 at 09:45:52 +0200, Robert Jarzmik wrote :
> Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:
> 
> > rtc-v3020.h belongs to include/linux/platform_data/
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > Cc: Daniel Mack <daniel@zonque.org>
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> > Cc: linux-arm-kernel@lists.infradead.org
> >  arch/arm/mach-pxa/cm-x270.c                   | 2 +-
> >  arch/arm/mach-pxa/cm-x300.c                   | 2 +-
> >  arch/arm/mach-pxa/em-x270.c                   | 2 +-
> >  drivers/rtc/rtc-v3020.c                       | 2 +-
> >  include/linux/{ => platform_data}/rtc-v3020.h | 0
> >  5 files changed, 4 insertions(+), 4 deletions(-)
> >  rename include/linux/{ => platform_data}/rtc-v3020.h (100%)
> For mach-pxa :
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Is this going through your rtc tree, or should I pick it up through the pxa one ?
> 

Actually, I've pushed it through rtc-next yesterday. I've just added
your ack now.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
