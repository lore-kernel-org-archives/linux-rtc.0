Return-Path: <rtc-linux+bncBCC6ZWOPXENRBZ44S2ZQKGQE466VE3Y@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id 204si739622wmx.1.2015.12.07.05.49.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 05:49:26 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH] RTC/PCF85063: fix reading/setting time/date
Date: Mon,  7 Dec 2015 14:49:31 +0100
Message-Id: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The PCF85063 RTC needs special treatment while setting or reading the
time/date:

 - while reading the 7 time/date registers they are blocked from updating by
   the one second pulse internally. So reading all time/date registers should
   happen in one turn to ensure reading is an atomic operation

 - to let setting the time/date be an atomic operation as well, the clock
   dividers must be kept in reset state to avoid a one second pulse during
   writing the 7 time/date registers

Patch 1 and 2 change reading the time/date. I have kept them separately for
easier review. Squasching both into one patch render it more or less
unreadable.
Patch 3 changes setting the time/date.

Comments are welcome
Juergen

Please keep me on CC as I'm not subscribed to the list.

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
