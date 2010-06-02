Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [2/4] rtc: rtc-rs5c372: fixed check for 'oscillator halted' condition
From: thomas.koeller@baslerweb.com
Message-Id: <1275486787-30406-3-git-send-email-thomas.koeller@baslerweb.com>
To: p_gortmaker@yahoo.com,
	rtc-linux@googlegroups.com
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>
Date: Wed,  2 Jun 2010 15:53:05 +0200
List-ID: <rtc-linux.googlegroups.com>

From: Thomas Koeller <thomas.koeller@baslerweb.com>

The R2025SD chip, according to its data sheet, sets the /XST
bit to zero if the oscillator stops. Hence the check for this
condition was wrong.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 drivers/rtc/rtc-rs5c372.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 211cacd..be80560 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -535,9 +535,9 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 	int addr, i, ret = 0;
 
 	if (rs5c372->type == rtc_r2025sd) {
-		if (!(rs5c372->regs[RS5C_REG_CTRL2] & R2025_CTRL2_XST))
+		if (rs5c372->regs[RS5C_REG_CTRL2] & R2025_CTRL2_XST)
 			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] &= ~R2025_CTRL2_XST;
+		rs5c372->regs[RS5C_REG_CTRL2] |= R2025_CTRL2_XST;
 	} else {
 		if (!(rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP))
 			return ret;
