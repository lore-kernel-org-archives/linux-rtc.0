Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWH4YXFAKGQESMAXPNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 132si257443wmn.6.2017.06.26.14.36.23
        for <rtc-linux@googlegroups.com>;
        Mon, 26 Jun 2017 14:36:23 -0700 (PDT)
Date: Mon, 26 Jun 2017 23:35:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
Message-ID: <20170626213534.jur6rggwbzhk6r4t@piout.net>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-3-f.fainelli@gmail.com>
 <20170624185942.vq656pjxbqnqdhll@piout.net>
 <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/06/2017 at 10:15:46 -0700, Florian Fainelli wrote:
> > This is not needed since d68778b80dd7
> 
> Great, I will take that out.
> 
> Do you care whether some dev_dbg() prints are left in the driver or
> should I remove those in v2?
> 

It could have stayed but it seems you removed it from v2.

I'll applay that but it is ok if you change your mind.

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
