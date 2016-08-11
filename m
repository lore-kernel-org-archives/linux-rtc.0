Return-Path: <rtc-linux+bncBDMLZJ6I5AIBBUMZWG6QKGQEN4DEA4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id i198si71599wmd.2.2016.08.11.03.00.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 03:00:49 -0700 (PDT)
Received: by mail-wm0-x242.google.com with SMTP id i5so370701wmg.2
        for <rtc-linux@googlegroups.com>; Thu, 11 Aug 2016 03:00:49 -0700 (PDT)
From: Daniel Romell <danielromell@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	daro@hms.se,
	jao@hms.se,
	mago@hms.se
Subject: [rtc-linux] [PATCH 0/2] bq32000 fixes
Date: Thu, 11 Aug 2016 11:59:13 +0200
Message-Id: <1470909555-9226-1-git-send-email-daro@hms.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi all,

This is a couple of patches for the bq32000 RTC.

The first one is purely cosmetic, fixing a case where the wrong mask (but
correct value) was used when reading a register value.

The second patch adds a check for a failure flag in the read function. If t=
he
register contents can't be trusted, an error is returned instead.
The patch also removes some code in the probe function that would clear the
failure flag without resolving the error condition. The error is now only
cleared when writing a new time to the RTC.

Jan =C3=96stlund (2):
  rtc: bq32k: Use correct mask name for 'minutes' register.
  rtc: bq32k: Fix handling of oscillator failure flag

 drivers/rtc/rtc-bq32k.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--
2.7.4

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
