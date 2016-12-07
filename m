Return-Path: <rtc-linux+bncBCW4XG6ATMLBB7NVULBAKGQEPNZFWRI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id p138si1166924wme.1.2016.12.07.15.27.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:57 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id g23so31106476wme.1
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:57 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 6/6] rtc: mcp795: Fix whitespace and indentation.
Date: Thu,  8 Dec 2016 00:27:42 +0100
Message-Id: <588ddbf1ec3c6c14e6650ab9b5414d8ac4f4e36a.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Fix whitespace and indentation errors and the following
checkpatch warnings:
- line 15: Block comments use a trailing */ on a separate line
- line 256: Line over 80 characters
No code change.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 8ed55f6..ce75e42 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -12,7 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * */
+ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -31,7 +31,7 @@
 #define MCP795_EEWREN	0x06
 #define MCP795_SRREAD	0x05
 #define MCP795_SRWRITE	0x01
-#define MCP795_READ		0x13
+#define MCP795_READ	0x13
 #define MCP795_WRITE	0x12
 #define MCP795_UNLOCK	0x14
 #define MCP795_IDWRITE	0x32
@@ -45,9 +45,9 @@
 #define MCP795_REG_MONTH	0x06
 #define MCP795_REG_CONTROL	0x08
 
-#define MCP795_ST_BIT	BIT(7)
-#define MCP795_24_BIT	BIT(6)
-#define MCP795_LP_BIT	BIT(5)
+#define MCP795_ST_BIT		BIT(7)
+#define MCP795_24_BIT		BIT(6)
+#define MCP795_LP_BIT		BIT(5)
 #define MCP795_EXTOSC_BIT	BIT(3)
 #define MCP795_OSCON_BIT	BIT(5)
 
@@ -253,7 +253,7 @@ static int mcp795_probe(struct spi_device *spi)
 	mcp795_rtcc_set_bits(&spi->dev, 0x03, MCP795_24_BIT, 0);
 
 	rtc = devm_rtc_device_register(&spi->dev, "rtc-mcp795",
-								&mcp795_rtc_ops, THIS_MODULE);
+					&mcp795_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
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
