Return-Path: <rtc-linux+bncBCW4XG6ATMLBBPEGQHBQKGQEBAODQBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id o77si3387355wme.0.2016.12.25.14.07.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2016 14:07:56 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id y21so24150001lfa.0
        for <rtc-linux@googlegroups.com>; Sun, 25 Dec 2016 14:07:56 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 0/2] Provides support for alarm.
Date: Sun, 25 Dec 2016 23:07:41 +0100
Message-Id: <1482703663-9115-1-git-send-email-emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patchset provides support for weekday and alarm 
in the file driver/rtc/rtc-mcp795.c. 
Please review the changes and consider to apply them to the main kernel tree.

Changes from v1:
- Cover letter added.

Emil Bartczak (2):
  rtc: mcp795: Add support for weekday.
  rtc: mcp795: add alarm support.

 drivers/rtc/rtc-mcp795.c | 183 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 6 deletions(-)

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
