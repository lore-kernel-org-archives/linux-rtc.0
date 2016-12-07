Return-Path: <rtc-linux+bncBCW4XG6ATMLBB45VULBAKGQEQKYYPTY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id o77si1201360wme.0.2016.12.07.15.27.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:46 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id m203so31018352wma.3
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:46 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 0/6] Provides bug fixes for rtc-mcp795.c
Date: Thu,  8 Dec 2016 00:27:36 +0100
Message-Id: <cover.1481151278.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patchset provides 4 bug fixes (patch 1, 2, 3, 4), one 
improvement (patch 5) and whitespace, indention errors fixes 
(patch 6) in the file driver/rtc/rtc-mcp795.c.
Please review the changes and consider to apply them to the 
main kernel tree.

Changes from v1:
- Introduced SoB to all patches.
- Patch which switches to bcd2bin/bin2bcd became as first now, 
  it also solved the shift problem presented in the previous patch 1.
- Added restoring EXTOSC bit to its previous value.
- All whitespace and indention fixes moved to the new patch 6.
- Added new patch which replaces all bitmask values with the 
  BIT(x) macro.

Emil Bartczak (6):
  rtc: mcp795: use bcd2bin/bin2bcd.
  rtc: mcp795: fix bitmask value for leap year (LP).
  rtc: mcp795: fix time range difference between linux and RTC chip.
  rtc: mcp795: fix month write resetting date to 1.
  rtc: mcp795: Prefer using the BIT() macro.
  rtc: mcp795: Fix whitespace and indentation.

 drivers/rtc/rtc-mcp795.c | 122 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 22 deletions(-)

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
