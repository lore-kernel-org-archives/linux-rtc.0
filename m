Return-Path: <rtc-linux+bncBAABBEGVYC3QKGQE26GVAQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si381084wmf.2.2016.03.21.10.08.32
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Mar 2016 10:08:32 -0700 (PDT)
From: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 0/2] rtc: abx80x: Handle autocalibration and
 oscillator failure
Date: Mon, 21 Mar 2016 18:06:08 +0100
Message-Id: <cover.1458579029.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The current patches handle the autocalibration and the oscillator failure
for ABX80X RTC.
The autocalibration is handled using sysfs entries and the oscillator
failure bit is handled only for the XT Oscillator.

Mylene JOSSERAND (2):
  rtc: abx80x: handle autocalibration
  rtc: abx80x: handle the oscillator failure bit

 drivers/rtc/rtc-abx80x.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 2 deletions(-)

-- 
2.7.0

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
