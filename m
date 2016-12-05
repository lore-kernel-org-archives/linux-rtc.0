Return-Path: <rtc-linux+bncBCW4XG6ATMLBBHGPSXBAKGQEXRDVZWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id s128si5471wme.1.2016.12.05.05.11.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 05:11:55 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id g23so15878251wme.1
        for <rtc-linux@googlegroups.com>; Mon, 05 Dec 2016 05:11:55 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH 0/4] Provides bug fixes for rtc-mcp795.c
Date: Mon,  5 Dec 2016 14:11:49 +0100
Message-Id: <cover.1480939487.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patchset provides 3 bug fixes (patch 1, 2 and 3) and one 
improvement (patch 4) in the file driver/rtc/rtc-mcp795.c.
Please review the changes and consider to apply them to the 
main kernel tree.

Emil Bartczak (4):
  rtc: mcp795: fix invalid month setting.
  rtc: mcp795: fix time range difference between linux and RTC chip
  rtc: mcp795: fix month write resetting date to 1.
  rtc: mcp795: use bcd2bin/bin2bcd.

 drivers/rtc/rtc-mcp795.c | 125 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 31 deletions(-)

-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
