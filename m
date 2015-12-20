Return-Path: <rtc-linux+bncBDS7HNEFSALRB65J3KZQKGQENI7M5DQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si385949wmn.0.2015.12.20.03.46.03
        for <rtc-linux@googlegroups.com>;
        Sun, 20 Dec 2015 03:46:03 -0800 (PST)
Date: Sun, 20 Dec 2015 12:46:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 3/3] RTC/PCF85063: fix time/date setting
Message-ID: <20151220114602.GE3541@piout.net>
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
 <1449496174-7813-4-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449496174-7813-4-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/12/2015 at 14:49:34 +0100, Juergen Borleis wrote :
> When setting a new time/date the RTC's clock must be stopped first, in
> order to write the time/date registers in an atomic manner.
> So, this change stops the clock first and then writes the time/date
> registers and the clock control register (to re-enable the clock) in one
> turn.
> 

I'd have the same comment for that patch. Using
i2c_smbus_write_byte_data and i2c_smbus_write_block_data would make the
code clearer and also more robust because it takes care of
retransmissions for example.


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
