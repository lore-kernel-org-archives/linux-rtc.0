Return-Path: <rtc-linux+bncBCVK5RWD2QBRBJFLTHCQKGQEDFBYO4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from anchovy.45ru.net.au (anchovy3.45ru.net.au. [203.30.46.155])
        by gmr-mx.google.com with ESMTPS id h130si452845pfe.1.2017.02.16.17.45.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:45:08 -0800 (PST)
From: Phil Reid <preid@electromag.com.au>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
  akinobu.mita@gmail.com, preid@electromag.com.au, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 0/3] rtc: ds3232: Minor cleanup and fix sysfs wakealarm
Date: Fri, 17 Feb 2017 09:44:55 +0800
Message-Id: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Minor whitespace cleanup and regmap register definition.
Fix so that sysfs wakealarm attribute is visible.

Phil Reid (3):
  rtc: ds3232: Cleanup whitespace around register and bit definitions.
  rtc: ds3232: Add regmap max_register definition.
  rtc: ds3232: Call device_init_wakeup before device_register

 drivers/rtc/rtc-ds3232.c | 56 +++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
