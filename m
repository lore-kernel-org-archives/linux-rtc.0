Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: rtc: update author email for rtc-at32ap700x
From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Message-Id: <1309273417-8884-1-git-send-email-hans-christian.egtvedt@atmel.com>
To: a.zummo@towertech.it,
	rtc-linux@googlegroups.com
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Date: Tue, 28 Jun 2011 17:03:37 +0200
List-ID: <rtc-linux.googlegroups.com>

This patch updates the email address of the rtc-at32ap700x driver supported by
me to an email account I will use on a more regular basis in the future.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 drivers/rtc/rtc-at32ap700x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
index e725d51..402e52f 100644
--- a/drivers/rtc/rtc-at32ap700x.c
+++ b/drivers/rtc/rtc-at32ap700x.c
@@ -314,6 +314,6 @@ static void __exit at32_rtc_exit(void)
 }
 module_exit(at32_rtc_exit);
 
-MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
+MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("Real time clock for AVR32 AT32AP700x");
 MODULE_LICENSE("GPL");
