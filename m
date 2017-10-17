Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Bastian Stender <bst@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Marek Vasut <marex@denx.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>,
        Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] rtc: ds1307: add OF and ACPI entries for Epson RX8130
Date: Tue, 17 Oct 2017 14:46:07 +0200
Message-Id: <20171017124607.17461-1-bst@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

Make Epson RX8130 device tree and ACPI aware.

Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")
Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
 drivers/rtc/rtc-ds1307.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index e7d9215c9201..8e2cd45a2f96 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -325,6 +325,10 @@ static const struct of_device_id ds1307_of_match[] = {
 		.compatible = "isil,isl12057",
 		.data = (void *)ds_1337
 	},
+	{
+		.compatible = "epson,rx8130",
+		.data = (void *)rx_8130
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ds1307_of_match);
@@ -348,6 +352,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "PT7C4338", .driver_data = ds_1307 },
 	{ .id = "RX8025", .driver_data = rx_8025 },
 	{ .id = "ISL12057", .driver_data = ds_1337 },
+	{ .id = "RX8130", .driver_data = rx_8130 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
-- 
2.11.0
