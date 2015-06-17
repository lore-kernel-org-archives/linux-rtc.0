Return-Path: <rtc-linux+bncBCMNZUWXYYORB24HQ6WAKGQEUIR5LQI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com. [209.85.192.175])
        by gmr-mx.google.com with ESMTPS id fl5si663678pad.0.2015.06.17.12.00.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 12:00:59 -0700 (PDT)
Received: by pdbki1 with SMTP id ki1so46712991pdb.1
        for <rtc-linux@googlegroups.com>; Wed, 17 Jun 2015 12:00:58 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	lee.jones@linaro.org,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [rtc-linux] [PATCH-v2 0/3] mfd: 88pm800: Add Device tree support
Date: Thu, 18 Jun 2015 00:28:04 +0530
Message-Id: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
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

This patch-series adds support for Device tree to 88PM800 mfd driver.
It also enabled configuration of irq clear method through DT.

Testing::
 - Boot tested on PXA1928 based platform.
 - probe of mfd, rtc and regulator function passing successfully.
 - Basic read operations on registers


V1 => V1
=======
Link to V1: http://lkml.iu.edu/hypermail/linux/kernel/1505.3/04386.html

  - Split binding changes from original commit
  - Updated binding info as per Rob's suggestion
  - Dropped PATCH 4/4, as discussed during review
  - Dropped PATCH 3/4, as it is independent RTC code change,
    so will submit it separately to ease merging.
  - Fixed all other minor comments

Attempt has been made to push some of the patches to the list sometime
back in 2013.

Link to previous patch submission:
        https://lkml.org/lkml/2013/8/14/86

Vaibhav Hiremath (3):
  mfd: 88pm800: Add device tree support
  mfd: 88pm800: Allow configuration of interrupt clear method
  mfd: devicetree: bindings: Add new 88pm800 mfd binding

 Documentation/devicetree/bindings/mfd/88pm800.txt | 60 +++++++++++++++++++++++
 drivers/mfd/88pm800.c                             | 40 +++++++++++++--
 include/linux/mfd/88pm80x.h                       |  6 ++-
 3 files changed, 99 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

-- 
1.9.1

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
