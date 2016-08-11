Return-Path: <rtc-linux+bncBDMLZJ6I5AIBBK6EWG6QKGQEZCBMFOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id b77si584392wmb.1.2016.08.11.04.31.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 04:31:55 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id i5so812992wmg.2
        for <rtc-linux@googlegroups.com>; Thu, 11 Aug 2016 04:31:55 -0700 (PDT)
From: Daniel Romell <danielromell@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	daro@hms.se,
	jao@hms.se,
	mago@hms.se
Subject: [rtc-linux] [PATCH v2 0/2] bq32000 fixes
Date: Thu, 11 Aug 2016 13:31:42 +0200
Message-Id: <1470915104-10683-1-git-send-email-daro@hms.se>
In-Reply-To: <1470909555-9226-1-git-send-email-daro@hms.se>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
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

Changes since v1:
* Return -EINVAL instead of -EIO when failure flag is set.

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
