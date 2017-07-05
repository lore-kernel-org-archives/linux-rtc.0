Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBHV26LFAKGQEIWVX5CI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id 71si2644786wmp.3.2017.07.05.01.02.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 01:02:37 -0700 (PDT)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [rtc-linux] [PATCH v2 0/2] RTC: s35390a: Improve low voltage or
 invalid time detection
Date: Wed,  5 Jul 2017 10:02:28 +0200
Message-Id: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patchset implements feature to detect RTC low voltage or power off.

Changes since v1:
	- Read register instead setting flags

Fabien Lahoudere (2):
  RTC: s35390a: handle invalid RTC time
  RTC: s35390a: implement ioctls

 drivers/rtc/rtc-s35390a.c | 104 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 31 deletions(-)

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
